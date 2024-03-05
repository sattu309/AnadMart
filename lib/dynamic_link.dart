// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:fresh2_arrive/screens/login_by_deeplink.dart';
// import 'package:get/get.dart';
// import 'package:package_info_plus/package_info_plus.dart';
//
// class DynamicLinksApi {
//   final dynamicLink = FirebaseDynamicLinks.instance;
//
//   handleDynamicLink() async {
//     await dynamicLink.getInitialLink();
//     dynamicLink.onLink.listen((PendingDynamicLinkData data) async {
//       handleSuccessLinking(data);
//     },);
//   }
//
//   Future<String> createReferralLink(String referralCode) async {
//     final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
//       uriPrefix: 'https://fresh2arrivereferral.page.link',
//       link: Uri.parse('https://fresh2arrive.eoxyslive.com/login?code=$referralCode'),
//       androidParameters: AndroidParameters(
//         packageName: 'com.anand_mart.android',
//       ),
//     /*  socialMetaTagParameters: SocialMetaTagParameters(
//         title: 'Refer A Friend',
//         description: 'Refer and earn',
//         imageUrl: Uri.parse('https://www.insperity.com/wp-content/uploads/Referral-_Program1200x600.png'),
//       ),*/
//     );
//
//     final ShortDynamicLink shortLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParameters,shortLinkType: ShortDynamicLinkType.unguessable);
//
//     final Uri dynamicUrl = shortLink.shortUrl;
//     print(dynamicUrl);
//     return dynamicUrl.toString();
//   }
//
//   void handleSuccessLinking(PendingDynamicLinkData data) {
//     final Uri deepLink = data.link;
//
//     var isRefer = deepLink.pathSegments.contains('refer');
//     if (isRefer) {
//       var code = deepLink.queryParameters['code'];
//       print(code.toString());
//       if (code != null) {
//         Get.toNamed(LoginByDeepLink.loginByDeepLink,arguments: [code]);
//       }
//     }
//   }
// }