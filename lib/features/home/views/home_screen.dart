import 'package:flutter/material.dart';
import 'package:techlab/shared/colors/colors.dart';
import 'package:techlab/shared/components/custom_container.dart';
import 'package:techlab/shared/components/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TopImage(),
          CustomText(
            marginLeft: 10,
            text: "Our Services",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: blackColor,
          ),
          CustomContainer(
            title: "Digital Transformation",
            subTitle:
                "Transform your business with cutting-edge \n Microsoft technologies.",
            body:
                "From AI-powered solutions like Microsoft AI Copilot and Azure AI to custom development of web portals, cloud migration, and systems integration, TechLabs London specialises in delivering tailored digital transformations that drive innovation and efficiency.",
            imagePath: 'assets/images/digital_transformation.png',
          ),
          CustomContainer(
            title: "Consultancy Services",
            subTitle: "A wide range of consultancy services. ",
            body:
                "whether it’s agile transformation, CRM consulting, project management, or process re-engineering, TechLabs London provides strategic guidance to optimize performance and accelerate growth.",
            imagePath: 'assets/images/consultancy_services.png',
          )
        ],
      ),
    );
  }
}

class TopImage extends StatelessWidget {
  const TopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          fit: BoxFit.fitWidth,
          'assets/images/home_image.png',
          // height: 114,
        ),
        const Positioned(
          top: 40,
          left: 9,
          child: CustomText(
            text: "TechLabs London",
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: blackColor,
          ),
        ),
        const Positioned(
          left: 9,
          top: 75,
          child: CustomText(
            text: "Microsoft AI Cloud Solution Partner",
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: primaryColor,
          ),
        )
      ],
    );
  }
}
