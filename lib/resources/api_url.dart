import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/verify_otp_model.dart';

class ApiUrl {
  static const baseUrl = "https://anadmart.eoxyslive.com/api/";
  static const loginApi = "${baseUrl}login";
  static const registrationApi = "${baseUrl}register";
  static const wishlistUrl = "${baseUrl}add-remove-wishlist";
  static const otpApi = "${baseUrl}verify-otp";
  static const allChatListUrl = "${baseUrl}chat";
  static const saveChatUrl = "${baseUrl}chat-save";
  static const favoriteListUrl = "${baseUrl}list";
  static const socialLoginUrl = "${baseUrl}social-login";
  static const sendRequestUrl = "${baseUrl}ask-us-anything";
  static const feedbackUrl = "${baseUrl}feedback";
  static const verifyOtpOfMart = "${baseUrl}verify-otp";
  static const verifyOtpForLoginOfMart = "${baseUrl}verify-email-otp";
  static const resendOtpOfMart = "${baseUrl}resend-otp";
  static const resetPasswordOfMart = "${baseUrl}reset-password";
  static const changePasswordOfMart = "${baseUrl}change-password";
  static const forgotPasswordUrl = "${baseUrl}forgot-password";
  static const resendApi = "${baseUrl}resend-otp";
  static const categoriesUrl = "${baseUrl}categories";
  static const categoriesProductsUrl = "${baseUrl}category";
  static const couponsUrl = "${baseUrl}coupons";
  static const applyCouponsUrl = "${baseUrl}coupon-apply";
  static const removeCouponsUrl = "${baseUrl}remove-coupon";
  static const orderTipUrl = "${baseUrl}order-tip";
  static const removeTipUrl = "${baseUrl}remove-tip";
  static const userProfileUrl = "${baseUrl}user-profile";
  static const updateProfileUrl = "${baseUrl}update-profile";
  static const homeUrl = "${baseUrl}home";
  static const homeUrlForMart = "${baseUrl}home";
  static const nearStores = "${baseUrl}stores";
  static const storesUrl = "${baseUrl}near-stores";
  static const myCartUrl = "${baseUrl}my-cart";
  static const addCartUrl = "${baseUrl}add-cart";
  static const updateCartUrl = "${baseUrl}update-cart";
  static const removeCartItemUrl = "${baseUrl}remove-cart-item";
  static const addToCartRelatedUrl = "${baseUrl}cart-related-product";
  static const homeSearchUrl = "${baseUrl}search";
  static const storeDetailsUrl = "${baseUrl}store-details";
  static const addAddressUrl = "${baseUrl}add-address";
  static const myRequestUrl = "${baseUrl}ask-us-anything-my-detail";
  static const updateLocationUrl = "${baseUrl}update-location";
  static const myAddressUrl = "${baseUrl}my-address";
  static const singleAddressUrl = "${baseUrl}single-address";
  static const myOrdersUrl = "${baseUrl}my-orders";
  static const cancelOrderUrl = "${baseUrl}order-status-change";
  static const martOrderDetailsUrl = "${baseUrl}order-details";
  static const reOrdersUrl = "${baseUrl}re-order";
  static const myOrderDetailsUrl = "${baseUrl}order-details";
  static const subCategoryUrl = "${baseUrl}sub-categories";
  static const singleProductScreenUrl = "${baseUrl}product";
  static const feedbackLIstUrl = "${baseUrl}feedback-list";
  static const contactReasonUrl = "${baseUrl}contact-reason";
  static const contactReasonOptionUrl = "${baseUrl}contact-us-reason";
  static const editAddressUrl = "${baseUrl}edit-address";
  static const removeAddressUrl = "${baseUrl}remove-address";
  static const chooseOrderAddressUrl = "${baseUrl}choose-order-address";
  static const checkOutUrl = "${baseUrl}order";
  static const sendZipcodeUrl = "${baseUrl}update-location";
  static const vendorRegister = "${baseUrl}vendor-register";
  static const vendorInformationEditUrl = "${baseUrl}vendor-information-edit";
  static const myWalletUrl = "${baseUrl}wallet";
  static const paymentOptionUrl = "${baseUrl}payment-option";
  static const vendorOrderListUrl = "${baseUrl}vendor-order-list";
  static const referAndEarnUrl = "${baseUrl}refer-and-earn";
  static const notificationUrl = "${baseUrl}notification-list";
  static const vendorRejectVariantUrl = "${baseUrl}vendor-reject-variant";
  static const withdrawalListUrl = "${baseUrl}withdrawal-list";
  static const withdrawalRequestUrl = "${baseUrl}withdrawal-request";
  static const vendorInformationUrl = "${baseUrl}vendor-information";
  static const storeAvailabilityUrl = "${baseUrl}store-availability";
  static const vendorProductListUrl = "${baseUrl}vendor-product-list";
  static const assignedOrderListUrl = "${baseUrl}assigned-order-list";
  static const vendorSearchProductsUrl = "${baseUrl}products";
  static const vendorAddProductsUrl = "${baseUrl}product";
  static const checkoutOfmart = "${baseUrl}checkout";
  static const vendorDashboardUrl = "${baseUrl}vendor-dashboard";
  static const orderAcceptUrl = "${baseUrl}order-accept";
  static const storeUpdateStatusUrl = "${baseUrl}store-status-update";
  static const selfDeliveryUpdateStatusUrl =
      "${baseUrl}self-delivery-status-update";
  static const toggleStatusUrl = "${baseUrl}vendor-product-status-update";
  static const driverDeliveryRequestListUrl =
      "${baseUrl}driver-delivery-request-list";
  static const categoryUrl = "${baseUrl}category";
  static const assignedOrderUrl = "${baseUrl}assigned-order";
  static const driverOrderStatusUpdateUrl =
      "${baseUrl}driver-order-status-update";
  static const driverRegisterUrl = "${baseUrl}driver-register";
  static const driverInformationUrl = "${baseUrl}driver-information";
  static const deliveryVerifyOtpUrl = "${baseUrl}verify-delivery";
  static const setStoreTimeUrl = "${baseUrl}store-timing";
  static const marketingInf = "${baseUrl}marketing-manager-dashboard";
  static const updatedSetStoreTimeUrl = "${baseUrl}store-availability";
  static const vendorSaveProductUrl = "${baseUrl}vendor-add-product";
  static const resendDeliveryOtpUrl = "${baseUrl}resend-delivery-otp";
  static const driverDeliveryModeUpdateUrl =
      "${baseUrl}driver-delivery-mode-update";
  static const addMoneyUrl = "${baseUrl}add-money";
  static const onlineSuccessPaymentUrl = "${baseUrl}online-success-payment";
  static const vendorEditProductUrl = "${baseUrl}vendor-product/";
  static const vendorBankDetailsUrl = "${baseUrl}account-details";
  static const vendorBankListUrl = "${baseUrl}banks-list";
  static const vendorAddBankDetailsUrl = "${baseUrl}add-account-details";
  static const helpCenterUrl = "${baseUrl}faq-list";
  static const singleCategoryUrl = "${baseUrl}single-category";
  static const privacyUrl = "${baseUrl}pages";
  static const supportUrl = "${baseUrl}contact-us";
  static const sendImageUrl = "${baseUrl}send-image";
  static const managerNetwork = "${baseUrl}marketing-manager-register";
  static const userSoftDelete = "${baseUrl}user-delete";
}

getHeaders() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    if (pref.getString('user_info') != null)
      HttpHeaders.authorizationHeader:
          'Bearer ${ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!)).authToken}'
  };
  return headers;
}


Future<String> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  return user.data!.id.toString();
}
