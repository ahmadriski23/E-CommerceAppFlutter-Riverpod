import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/themes.dart';

class AdsBannerWidget extends StatelessWidget {
  const AdsBannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Apple Store',
                    style: AppTheme.kBigTitle,
                  ),
                  Gap(8),
                  Text(
                    'Find the Apple product and accesories you`re looking for',
                    style: AppTheme.kBodyText.copyWith(color: kWhiteColor),
                  ),
                  Gap(4),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kWhiteColor,
                        foregroundColor: kSecondaryColor,
                      ),
                      onPressed: () {},
                      child: Text("Shop new year"))
                ],
              ),
            ),
          ),
          Image.asset('assets/general/landing.png')
        ],
      ),
    );
  }
}
