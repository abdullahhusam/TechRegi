import 'package:flutter/material.dart';
import 'package:techlab/shared/colors/colors.dart';
import 'package:techlab/shared/components/custom_text.dart';

class CustomContainer extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  final String body;

  const CustomContainer(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subTitle,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
      width: double.infinity,
      height: 120,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 0,
            color: Color(0x15000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  imagePath,
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      textAlign: TextAlign.start,
                      text: title,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: blackColor,
                    ),
                    CustomText(
                      fontWeight: FontWeight.w400,
                      fontSize: 8,
                      textAlign: TextAlign.start,
                      text: subTitle,
                      color: tileIconColor,
                    )
                  ],
                )
              ],
            ),
            CustomText(
                marginTop: 8,
                textAlign: TextAlign.start,
                fontSize: 7,
                fontWeight: FontWeight.w400,
                text: body)
          ],
        ),
      ),
    );
  }
}
