import 'dart:async';
import 'dart:convert';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import '../controller/HelpCenter_Controller.dart';
import '../resources/app_assets.dart';
import '../resources/app_text.dart';
import '../widgets/dimensions.dart';
import '../widgets/editprofile_textfield.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);
  static var helpCenterScreen = "/helpCenterScreen";

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  final helpCenterController = Get.put(HelpCenterController());
  RxInt showSubTitle = (0).obs;
  // @override
  // void initState() {
  //   super.initState();
  //   helpCenterController.getHelpCenterData().then((value) {
  //     setState(() {});
  //   });
  // }
  final _formKey = GlobalKey<FormState>();
  //  final addressController = Get.put(MyAddressController());
  // Rx<AddressData> addressModel = AddressData().obs;
  final List<String> choiceAddress = ["Home", "Office", "Hotel", "Other"];
  final RxBool _isValue = false.obs;
  RxBool customTip = false.obs;
  RxString selectedChip = "Home".obs;
  final TextEditingController searchController = TextEditingController();
  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;

  String? _currentAddress;
  String? _address = "";
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                  _currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 15)));
      // _onAddMarkerButtonPressed(
      //     LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      //     "current location");
      setState(() {});
      // location = _currentAddress!;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        _address =
        '${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  final TextEditingController otherController = TextEditingController();
  showChangeAddressSheet() {
    final TextEditingController flatNoController = TextEditingController();
    final TextEditingController streetController = TextEditingController();
    final TextEditingController recipientController = TextEditingController();
    // otherController.text = addressModel.addressType ?? "Home";
    // selectedChip.value = addressModel.addressType ?? "Home";
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Obx(() {
              return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isValue.value = !_isValue.value;
                              });
                              Get.back();
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: const ShapeDecoration(
                                  color: AppTheme.blackcolor,
                                  shape: CircleBorder()),
                              child: Center(
                                  child: Icon(
                                    Icons.clear,
                                    color: AppTheme.backgroundcolor,
                                    size: AddSize.size30,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: AddSize.size20,
                          ),
                          Container(
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding16,
                                  vertical: AddSize.padding16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Enter complete address",
                                    style: TextStyle(
                                        color: AppTheme.blackcolor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      choiceAddress.length,
                                          (index) => chipList(choiceAddress[index]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  if (customTip.value)
                                    EditProfileTextFieldWidget(
                                      hint: "Other",
                                      controller: otherController,
                                    ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  EditProfileTextFieldWidget(
                                    controller: flatNoController,
                                    hint: "Flat, House no, Floor, Tower",
                                    label: "Flat, House no, Floor, Tower",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                          'Flat, House no, Floor, Tower'),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  EditProfileTextFieldWidget(
                                    controller: streetController,
                                    hint: "Street, Society, Landmark",
                                    label: "Street, Society, Landmark",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                          'Street, Society, Landmark'),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  EditProfileTextFieldWidget(
                                    controller: recipientController,
                                    hint: "Recipient’s name",
                                    label: "Recipient’s name",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Recipient’s name'),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  CommonButton(title: 'save address'.toUpperCase()),
                                  // ElevatedButton(
                                  //     onPressed: () {
                                  //       // if (_formKey.currentState!.validate()) {
                                  //       //   addressModel.street != null &&
                                  //       //       addressModel.flatNo != null &&
                                  //       //       addressModel.landmark != null
                                  //       //       ? editAddress(
                                  //       //       location: _address,
                                  //       //       flat_no:
                                  //       //       flatNoController.text,
                                  //       //       street:
                                  //       //       streetController.text,
                                  //       //       landmark:
                                  //       //       streetController.text,
                                  //       //       address_type:
                                  //       //       otherController.text,
                                  //       //       context: context,
                                  //       //       address_id: addressModel
                                  //       //           .id
                                  //       //           .toString())
                                  //       //       .then((value) {
                                  //       //     showToast(value.message);
                                  //       //     if (value.status == true) {
                                  //       //       Get.toNamed(MyAddress
                                  //       //           .myAddressScreen);
                                  //       //       addressController
                                  //       //           .getAddress();
                                  //       //       flatNoController.clear();
                                  //       //       streetController.clear();
                                  //       //       otherController.clear();
                                  //       //       recipientController.clear();
                                  //       //       selectedChip.value = "";
                                  //       //     }
                                  //       //   })
                                  //       //       : addAddress(
                                  //       //       location: _address,
                                  //       //       flat_no:
                                  //       //       flatNoController.text,
                                  //       //       street:
                                  //       //       streetController.text,
                                  //       //       landmark:
                                  //       //       streetController.text,
                                  //       //       address_type:
                                  //       //       otherController.text,
                                  //       //       context: context)
                                  //       //       .then((value) {
                                  //       //     showToast(value.message);
                                  //       //     if (value.status == true) {
                                  //       //       Get.toNamed(MyAddress
                                  //       //           .myAddressScreen);
                                  //       //       addressController
                                  //       //           .getAddress();
                                  //       //       flatNoController.clear();
                                  //       //       streetController.clear();
                                  //       //       otherController.clear();
                                  //       //       recipientController.clear();
                                  //       //       selectedChip.value = "";
                                  //       //     }
                                  //       //   });
                                  //       // }
                                  //     },
                                  //     style: ElevatedButton.styleFrom(
                                  //       minimumSize:
                                  //       const Size(double.maxFinite, 60),
                                  //       primary: AppTheme.primaryColor,
                                  //       elevation: 0,
                                  //       shape: RoundedRectangleBorder(
                                  //           borderRadius:
                                  //           BorderRadius.circular(10)),
                                  //     ),
                                  //     child: Text(
                                  //       "SAVE ADDRESS",
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .headline5!
                                  //           .copyWith(
                                  //           color: AppTheme.backgroundcolor,
                                  //           fontWeight: FontWeight.w500,
                                  //           fontSize: AddSize.font18),
                                  //     )),
                                ],
                              ),
                            ),
                          ),
                          // Obx(() {
                          //   return SizedBox(
                          //     height: sizeBoxHeight.value,
                          //   );
                          // })
                        ],
                      ),
                    ),
                  ));
            }),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkGps();
    _getCurrentPosition();
    // if (Get.arguments != null) {
    //   addressModel.value = Get.arguments[0];
    // }
  }

  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";
  GoogleMapController? mapController1; //contrller for Google map
  CameraPosition? cameraPosition;
  String location = "Search Location";

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // Future<void> _onAddMarkerButtonPressed(LatLng lastMapPosition, markerTitle,
  //     {allowZoomIn = true}) async {
  //   final Uint8List markerIcon =
  //   await getBytesFromAsset(AppAssets.locationMarker, 100);
  //   markers.clear();
  //   markers.add(Marker(
  //       markerId: MarkerId(lastMapPosition.toString()),
  //       position: lastMapPosition,
  //       infoWindow: const InfoWindow(
  //         title: "",
  //       ),
  //       icon: BitmapDescriptor.fromBytes(markerIcon)));
  //   // BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan,)));
  //   if (googleMapController.isCompleted) {
  //     mapController!.animateCamera(CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //             target: lastMapPosition, zoom: allowZoomIn ? 14 : 11)));
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        mapController!.dispose();
        return true;
      },
      child: Scaffold(
          appBar: backAppBar2(
              title: _isValue.value == true
                  ? "Complete Address"
                  : "Add New Address",
              context: context,
              dispose: "dispose",
              disposeController: () {
                mapController!.dispose();
              }),
          body: Stack(
            children: [
              GoogleMap(
                zoomGesturesEnabled: true,
                //enable Zoom in, out on map
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 14.0, //initial zoom level
                ),
                mapType: MapType.normal,
                //map type
                onMapCreated: (controller) {
                  setState(() async {
                    mapController = controller;
                  });
                },
                // markers: markers,

                // myLocationEnabled: true,
                // myLocationButtonEnabled: true,
                // compassEnabled: true,
                // markers: Set<Marker>.of(_markers),
                onCameraMove: (CameraPosition cameraPositions) {
                  cameraPosition = cameraPositions;
                },
                onCameraIdle: () async {},
              ),
              _isValue.value == true
                  ? const SizedBox()
                  : Positioned(
                //search input bar
                  top: 10,
                  child: InkWell(
                      onTap: () async {
                        var place = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: googleApikey,
                            mode: Mode.overlay,
                            types: [],
                            strictbounds: false,
                            // components: [
                            //   Component(Component.country, 'np')
                            // ],
                            onError: (err) {
                              log("error.....   ${err.errorMessage}");
                            });
                        if (place != null) {
                          setState(() {
                            _address = place.description.toString();
                          });
                          final plist = GoogleMapsPlaces(
                            apiKey: googleApikey,
                            apiHeaders:
                            await const GoogleApiHeaders().getHeaders(),
                          );
                          print(plist);
                          String placeid = place.placeId ?? "0";
                          final detail =
                          await plist.getDetailsByPlaceId(placeid);
                          final geometry = detail.result.geometry!;
                          final lat = geometry.location.lat;
                          final lang = geometry.location.lng;
                          var newlatlang = LatLng(lat, lang);
                          setState(() {
                            _address = place.description.toString();
                          //   _onAddMarkerButtonPressed(
                          //       LatLng(lat, lang), place.description);
                           });
                          mapController?.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: newlatlang, zoom: 17)));
                          setState(() {});
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Card(
                          child: Container(
                              padding: const EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width - 40,
                              child: ListTile(
                                leading: Image.asset(
                                  AppAssets.drawer_location,
                                  width: AddSize.size15,
                                ),
                                title: Text(
                                  _address.toString(),
                                  style:
                                  TextStyle(fontSize: AddSize.font14),
                                ),
                                trailing: const Icon(Icons.search),
                                dense: true,
                              )),
                        ),
                      ))),
              Positioned(
                  bottom: 0,
                  child: Container(
                    height: AddSize.size200,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: AppTheme.backgroundcolor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: AppTheme.primaryColor,
                                      size: AddSize.size25,
                                    ),
                                    SizedBox(
                                      width: AddSize.size12,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _address.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: AddSize.font16),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // TextButton(
                              //     onPressed: () {
                              //       setState(() {
                              //         _isValue.value = !_isValue.value;
                              //       });
                              //       showChangeAddressSheet();
                              //     },
                              //     child: Text(
                              //       "CHANGE",
                              //       style: Theme
                              //           .of(context)
                              //           .textTheme
                              //           .headline5!
                              //           .copyWith(
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: AddSize.font12,
                              //           color: AppTheme.primaryColor),
                              //     ))
                            ],
                          ),
                          // Text(
                          //   _currentAddress ?? "",
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .headline5!
                          //       .copyWith(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: AddSize.font14,
                          //           color: AppTheme.lightblack),
                          // ),
                          SizedBox(
                            height: AddSize.size30,
                          ),
                          CommonButton(
                            title: 'Enter complete address',
                            onPressed: () {
                              setState(() {
                                _isValue.value = !_isValue.value;
                                selectedChip.value = "Home";
                              });
                              showChangeAddressSheet();
                              // Get.toNamed(MyRouter.chooseAddressScreen);
                            },
                          ),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         _isValue.value = !_isValue.value;
                          //         selectedChip.value = "Home";
                          //       });
                          //       showChangeAddressSheet();
                          //       // Get.toNamed(MyRouter.chooseAddressScreen);
                          //     },
                          //     style: ElevatedButton.styleFrom(
                          //       minimumSize: const Size(double.maxFinite, 60),
                          //       primary: Colors.green,
                          //       elevation: 0,
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10)),
                          //     ),
                          //     child: Text(
                          //       "Enter complete address",
                          //       style: Theme.of(context)
                          //           .textTheme
                          //           .headline5!
                          //           .copyWith(
                          //           color: AppTheme.backgroundcolor,
                          //           fontWeight: FontWeight.w500,
                          //           fontSize: AddSize.font16),
                          //     )),
                        ],
                      ),
                    ),
                  ))
            ],
          )),
    );
  }

  chipList(
      title,
      ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Column(
        children: [
          ChoiceChip(
            padding: EdgeInsets.symmetric(
                horizontal: width * .01, vertical: height * .01),
            backgroundColor: AppTheme.backgroundcolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: title != selectedChip.value
                        ? Colors.grey.shade300
                        : const Color(0xff0074D9))),
            label: Text("$title",
                style: TextStyle(
                    color: title != selectedChip.value
                        ? Colors.grey.shade600
                        : const Color(0xff0074D9),
                    fontSize: AddSize.font14,
                    fontWeight: FontWeight.w500)),
            selected: title == selectedChip.value,
            selectedColor: const Color(0xff0074D9).withOpacity(.13),
            onSelected: (value) {
              selectedChip.value = title;
              if (title == "Other") {
                customTip.value = true;
                otherController.text = "";
              } else {
                customTip.value = false;
                otherController.text = title;
              }
              setState(() {});
            },
          )
        ],
      );
    });
  }
}
  // @override
  // Widget build(BuildContext context) {
  //   return Obx(() {
  //     return Scaffold(
  //         appBar: backAppBar(title: "Help Center", context: context),
  //         body: helpCenterController.isDataLoading.value
  //             ? SingleChildScrollView(
  //                 physics: const BouncingScrollPhysics(),
  //                 child: Padding(
  //                     padding: EdgeInsets.symmetric(
  //                       horizontal: AddSize.padding16,
  //                       vertical: AddSize.padding10,
  //                     ),
  //                     child: Obx(() {
  //                       return Column(
  //                         children: [
  //                           Container(
  //                             decoration: BoxDecoration(
  //                                 color: AppTheme.backgroundcolor,
  //                                 borderRadius: BorderRadius.circular(30),
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                       color: Colors.grey.shade300,
  //                                       // offset: Offset(2, 2),
  //                                       blurRadius: 15)
  //                                 ]),
  //                             child: TextField(
  //                               maxLines: 1,
  //                               controller: helpCenterController.searchController,
  //                               style: const TextStyle(fontSize: 17),
  //                               textAlignVertical: TextAlignVertical.center,
  //                               textInputAction: TextInputAction.search,
  //                               onChanged: (value) {
  //                                 helpCenterController.getHelpCenterData();
  //                               },
  //                               decoration: InputDecoration(
  //                                   filled: true,
  //                                   suffixIcon: IconButton(
  //                                     onPressed: () {
  //                                       helpCenterController.getHelpCenterData();
  //                                     },
  //                                     icon: const Icon(
  //                                       Icons.search,
  //                                       color: AppTheme.blackcolor,
  //                                       size: 25,
  //                                     ),
  //                                   ),
  //                                   border: const OutlineInputBorder(
  //                                       borderSide: BorderSide.none,
  //                                       borderRadius: BorderRadius.all(
  //                                           Radius.circular(30))),
  //                                   fillColor: Colors.white,
  //                                   contentPadding: EdgeInsets.symmetric(
  //                                       horizontal: AddSize.padding20,
  //                                       vertical: AddSize.padding10),
  //                                   hintText: 'Search',
  //                                   hintStyle: TextStyle(
  //                                       fontSize: AddSize.font14,
  //                                       color: AppTheme.blackcolor,
  //                                       fontWeight: FontWeight.w400)),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: AddSize.size12,
  //                           ),
  //                           helpCenterController
  //                               .model.value.data!.isNotEmpty?
  //                           Column(
  //                               children: List.generate(
  //                                   helpCenterController
  //                                       .model.value.data!.length,
  //                                   (index) => Padding(
  //                                         padding: EdgeInsets.symmetric(
  //                                             vertical: AddSize.padding20,
  //                                             horizontal: AddSize.padding10),
  //                                         child: Container(
  //                                           decoration: BoxDecoration(
  //                                               color: AppTheme.backgroundcolor,
  //                                               borderRadius:
  //                                                   BorderRadius.circular(10),
  //                                               boxShadow: [
  //                                                 BoxShadow(
  //                                                     color:
  //                                                         Colors.grey.shade300,
  //                                                     // offset: Offset(2, 2),
  //                                                     blurRadius: 15)
  //                                               ]),
  //                                           child: Padding(
  //                                             padding: EdgeInsets.symmetric(
  //                                               horizontal: AddSize.padding20,
  //                                             ),
  //                                             child: Obx(() {
  //                                               return Column(
  //                                                 crossAxisAlignment:
  //                                                     CrossAxisAlignment.start,
  //                                                 children: [
  //                                                   ListTile(
  //                                                     onTap: () {
  //                                                       if (showSubTitle
  //                                                               .value ==
  //                                                           index) {
  //                                                         showSubTitle.value =
  //                                                             -1;
  //                                                       } else {
  //                                                         showSubTitle.value =
  //                                                             index;
  //                                                       }
  //                                                     },
  //                                                     minLeadingWidth: 0,
  //                                                     dense: true,
  //                                                     contentPadding:
  //                                                         EdgeInsets.zero,
  //                                                     title: Text(
  //                                                       helpCenterController
  //                                                           .model
  //                                                           .value
  //                                                           .data![index]
  //                                                           .question
  //                                                           .toString(),
  //                                                       style: Theme.of(context)
  //                                                           .textTheme
  //                                                           .headline5!
  //                                                           .copyWith(
  //                                                               fontWeight:
  //                                                                   FontWeight
  //                                                                       .w500,
  //                                                               fontSize: AddSize
  //                                                                   .font16),
  //                                                     ),
  //                                                     trailing: Icon(
  //                                                       showSubTitle
  //                                                                   .value ==
  //                                                               index
  //                                                           ? Icons
  //                                                               .keyboard_arrow_up_rounded
  //                                                           : Icons
  //                                                               .keyboard_arrow_down_outlined,
  //                                                       size: AddSize.size25,
  //                                                       color: AppTheme.subText,
  //                                                     ),
  //                                                     subtitle: showSubTitle
  //                                                                 .value ==
  //                                                             index
  //                                                         ? Html(
  //                                                             data: helpCenterController
  //                                                                 .model
  //                                                                 .value
  //                                                                 .data![index]
  //                                                                 .answer
  //                                                                 .toString(),
  //                                                           )
  //                                                         : null,
  //                                                   ),
  //                                                   SizedBox(
  //                                                       height: AddSize.size10),
  //                                                 ],
  //                                               );
  //                                             }),
  //                                           ),
  //                                         ),
  //                                       ))):Padding(
  //                             padding: EdgeInsets.symmetric(
  //                                 horizontal: AddSize.padding20 * 3,vertical: AddSize.padding20),
  //                             child: Text("Data not Available",
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .headline5!
  //                                     .copyWith(
  //                                     height: 1.5,
  //                                     fontWeight: FontWeight.w500,
  //                                     fontSize: AddSize.font14,
  //                                     color: AppTheme.blackcolor)),
  //                           ),
  //                         ],
  //                       );
  //                     })),
  //               )
  //             : const Center(child: CircularProgressIndicator()));
  //   });
  // }

