import 'package:fresh2_arrive/screens/SearchScreenData..dart';
import 'package:fresh2_arrive/screens/cart_screenOfMart.dart';
import 'package:fresh2_arrive/screens/change_password_screen.dart';
import 'package:fresh2_arrive/screens/checkout_screen_mart.dart';
import 'package:fresh2_arrive/screens/authentication_screens/reset_password_screenofMart.dart';
import 'package:fresh2_arrive/screens/custum_bottom_bar.dart';
import 'package:fresh2_arrive/screens/coupons_screen.dart';
import 'package:fresh2_arrive/screens/edit_profile.dart';
import 'package:fresh2_arrive/screens/authentication_screens/forgot_password_Screen.dart';
import 'package:fresh2_arrive/screens/help_center.dart';
import 'package:fresh2_arrive/screens/homepage.dart';
import 'package:fresh2_arrive/screens/myProfile.dart';
import 'package:fresh2_arrive/screens/my_address.dart';
import 'package:fresh2_arrive/screens/order/choose_address.dart';
import 'package:fresh2_arrive/screens/authentication_screens/otp_sreenofMart.dart';
import 'package:fresh2_arrive/screens/authentication_screens/otpscreen.dart';
import 'package:fresh2_arrive/screens/splash_screen.dart';
import 'package:fresh2_arrive/screens/thankyou_screen.dart';
import 'package:fresh2_arrive/screens/wishListScreen.dart';
import 'package:get/get.dart';
import '../screens/add_new_card_Mart.dart';
import '../screens/customer_homepage.dart';
import '../screens/customer_support.dart';
import '../screens/authentication_screens/LoginScreenMart.dart';
import '../screens/my_cart_screen.dart';
import '../screens/my_request_ofMart.dart';
import '../screens/notification_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/payment_method.dart';
import '../screens/order/myOrdersOfMart.dart';
import '../screens/setting_screen_mart.dart';
import '../screens/authentication_screens/signup_screen.dart';
import '../screens/static_chat_screen_ofMart.dart';
import '../screens/sub_category_ofCategory.dart';
import '../screens/support_screen_ofMart.dart';
import '../screens/order/OrderDetailsOfMart.dart';

class MyRouter {
  static var splashScreen = "/splashScreen";
  static var route = [
    GetPage(name: '/', page: () => const SplashScreen()),
    // GetPage(name: OnBoardingScreen.onBoardingScreen, page: () => const OnBoardingScreen()),
    GetPage(name: OnBoardingScreen.onboardingScreen, page: () => const OnBoardingScreen()),
    // GetPage(name: LoginScreen.loginScreen, page: () => const LoginScreen()),
    GetPage(name: LoginScreenMart.loginScreenMart, page: () => const LoginScreenMart()),
    GetPage(name: SignupScreenMart.signUpScreenMart, page: () => const SignupScreenMart()),
    GetPage(name: MyProfileScreen.myProfileScreen, page: () => const MyProfileScreen()),
    // GetPage(name: MarketingManager.marketingmanager, page: () => const MarketingManager()),
    GetPage(name: OtpScreen.otpScreen, page: () => const OtpScreen()),
    // GetPage(name: HomePage.homePage, page: () => const HomePage()),
    GetPage(
      name: SearchScreenData.searchScreen,
      page: () => const SearchScreenData(),
    ),
    GetPage(
        name: CustomNavigationBar.customNavigationBar,
        page: () => const CustomNavigationBar()),
    GetPage(name: MyCartScreen.myCartScreen, page: () => const MyCartScreen()),
    GetPage(
        name: EditProfileScreen.editProfileScreen,
        page: () => const EditProfileScreen()),
    GetPage(
        name: CouponsScreen.couponsScreen, page: () => const CouponsScreen()),
    GetPage(name: MyAddress.myAddressScreen, page: () => const MyAddress()),
    GetPage(
        name: NotificationScreen.notificationScreen,
        page: () => const NotificationScreen()),
    GetPage(
        name: MyOrdersOfMart.referAndEarnScreen,
        page: () => const MyOrdersOfMart()),
    GetPage(
        name: SubCategoryOfCategory.subCategoryOfCategory,
        page: () => const SubCategoryOfCategory()),
    GetPage(
        name: OtpScreenOfMart.otpScreenOfMart,
        page: () => const OtpScreenOfMart()),
    GetPage(
        name: ForgotPasswordScreen.forgotPasswordScreen,
        page: () => const ForgotPasswordScreen()),
    // GetPage(
    //     name: PaymentMethod.paymentScreen, page: () => const PaymentMethod()),
    GetPage(
        name: ThankYouScreen.thankYouScreen,
        page: () => const ThankYouScreen()),
    GetPage(
        name: OrderDetailsOfMart.orderDetailsOfMart, page: () => const OrderDetailsOfMart()),
    GetPage(
        name: StaticChatScreenMart.staticChatScreenMart, page: () => const StaticChatScreenMart()),
    GetPage(
        name: WishListScreen.wishListScreen, page: () => const WishListScreen()),
    // GetPage(
        // name: ProductScreenOfMart.productScreen, page: () => const ProductScreenOfMart()),
    GetPage(
        name: CartScreenOfMart.cartScreenOfMart, page: () => const CartScreenOfMart()),
    GetPage(
        name: ResetPasswordScreen.resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(
        name: ChangePasswordScreen.changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(name: HelpCenter.helpCenterScreen, page: () => const HelpCenter()),
    // GetPage(name: SendFeedbackScreen.termAndConditionScreen, page: () => const SendFeedbackScreen()),
    GetPage(name: CustomerSupport.customerSupportScreen, page: () => const CustomerSupport()),
    GetPage(
        name: ChooseAddress.chooseAddressScreen,
        page: () => const ChooseAddress()),
    GetPage(
        name: AddNewCardScreenMart.addNewCardScreenMart,
        page: () => const AddNewCardScreenMart()),
    GetPage(
        name: CheckoutScreenMart.checkoutScreenOfMart,
        page: () => const CheckoutScreenMart()),
    GetPage(
        name: SettingScreenMart.settingScreenOfMart,
        page: () => const SettingScreenMart()),
    // GetPage(
    //     name: SingleProductScreenMart.singleProductScreenMart,
    //     page: () => const SingleProductScreenMart()),
    GetPage(
        name: MyRequestScreen.myRequestScreenOfMart,
        page: () => const MyRequestScreen()),
    GetPage(
        name: SupportScreenOfMart.supportScreenOfMart,
        page: () => const SupportScreenOfMart()),

    GetPage(
        name: CustomerHomepage.customerHomepage,
        page: () => const CustomerHomepage()),
  ];
}
