import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:techlab/shared/colors/colors.dart';
import 'package:techlab/shared/components/custom_text.dart';
import 'package:techlab/utils/routes.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final List<Map<String, String>> items = [
    {
      'title': 'Digital Transformation',
      'subtitle':
          'Transform your business with cutting-edge Microsoft technologies. From AI-powered solutions like Microsoft AI Copilot and Azure AI to custom development of web portals, cloud migration',
      'logo': 'assets/icons/digital_transformation.svg',
    },
    {
      'title': 'Consultancy Services',
      'subtitle':
          'A wide range of consultancy services for agile transformation, CRM, and more.',
      'logo': 'assets/icons/consultancy_service.svg',
    },
    {
      'title': 'Microsoft Licensing Service',
      'subtitle':
          'Providing deeper customer engagement and tailored industry solutions.',
      'logo': 'assets/icons/microsoft_licensing_service.svg',
    },
  ];

  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: introScreenBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 60),
            child: Image.asset(
              'assets/images/logo.png',
              height: 50,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Carousel Slider
              CarouselSlider(
                items: items.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(25, 50, 25, 25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomText(
                                    marginTop: 40,
                                    text: item["title"]!,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                  CustomText(
                                    marginTop: 20,
                                    text: item["subtitle"]!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 88,
                                  height: 88,
                                  decoration: const BoxDecoration(
                                    color: primaryColor, // Red background
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/icons/digital_transformation.svg',
                                  height: 40.0,
                                  width: 40.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 400,
                  enableInfiniteScroll: false,
                  autoPlay: false,
                  aspectRatio: 10 / 9,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              // Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: items.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(entry.key),
                    child: Container(
                      width: 10.0,
                      height: 10.0,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: sliderColor, width: 2),
                        color: _currentIndex == entry.key
                            ? sliderColor
                            : Colors.transparent,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () {
                  context.go(registerPath);
                },
                child: const CustomText(
                  text: "Skip",
                  color: primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
