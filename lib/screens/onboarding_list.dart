



import '../resources/app_assets.dart';

class OnBoarding {
  String title;
  String img;
  String description;

  OnBoarding(
      {required this.title, required this.img,required this.description,});
}

List<OnBoarding> page1 = [
  OnBoarding(
    title: "You first",
    img: "assets/images/onboarding2.png",

    description: 'We don’t charge you order fees. We don’t spy on you. We just help you enjoy your meals ',

  ),
  OnBoarding(
    title: "Beautifully-designed  menus",
    img: "assets/images/onboarding.png",
    description: 'Every menu item is manually reviewed by our team',

  ),
  OnBoarding(
    title: "Unbeatable rates",
    img: "assets/images/onbording3.png",
    description: 'We don’t charge any order fees. Delivery fees go where they belong.',

  ),

];


class OnBoardModelResponse {
  final String? image, title, description;


  OnBoardModelResponse({
    this.image,
    this.title,
    this.description,
  });
}

List<OnBoardModelResponse> OnBoardingData = [
  OnBoardModelResponse(
    image: AppAssets.onboarding,
    title: "20% Discount New Arrival Product",

    description: 'Get a little lift from these Sam Edelman sandals featuring ruched straps and leather lace-up ties,',

  ),
  OnBoardModelResponse(
    image: AppAssets.onboarding1,
    title: "Take Advantage Of The Offer Shopping",
    description: 'Get a little lift from these Sam Edelman sandals featuring ruched straps and leather lace-up ties,',

  ),
  OnBoardModelResponse(
    image: AppAssets.onboarding2,
    title: "Take Advantage Of The Offer Shopping",
    description: 'Get a little lift from these Sam Edelman sandals featuring ruched straps and leather lace-up ties,',

  )
];