import 'package:flutter/material.dart';
import 'package:techlab/shared/colors/colors.dart';

import '../../../shared/components/custom_icon_button.dart';
import '../../../shared/components/custom_text.dart';

class TileComponent extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const TileComponent({
    super.key,
    this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              color: tileTextColor,
              // marginLeft: 13,
              text: text,
              fontSize: 14,
            ),
            const Icon(
              Icons.chevron_right_outlined,
              color: tileIconColor,
              size: 25,
            )
          ],
        ),
      ),
    );
  }
}
