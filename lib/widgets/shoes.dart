import 'package:flutter/material.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/kopa_app_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kopa/widgets/filter.dart';
import 'package:kopa/widgets/kops_ads.dart';

class ShoesWidget extends StatefulWidget {
  @override
  _ShoesWidgetState createState() => _ShoesWidgetState();
}

class _ShoesWidgetState extends State<ShoesWidget> {
  String id;
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: opacityColor,
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: brightTurquoise,
          child: Stack(children: <Widget>[
            KopsAdsWidget(),
            Positioned(
              child: Container(
                margin: const EdgeInsets.only(top: 30, left: 7),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [darkGray.withOpacity(0.6), darkGray.withOpacity(0.0)],
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                  icon: Icon(KopaAppIcons.filter, color: whiteColor),
                  iconSize: 16,
                  splashColor: opacityColor,
                  highlightColor: opacityColor,
                  tooltip: 'Фільтр',
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: opacityColor,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: BottomFilter(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
