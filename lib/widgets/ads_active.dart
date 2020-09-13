import 'package:flutter/material.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/widgets/kops_ads.dart';

class AdsActiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: brightTurquoise,
        child: KopsAdsWidget(),
      ),
    );
  }
}
