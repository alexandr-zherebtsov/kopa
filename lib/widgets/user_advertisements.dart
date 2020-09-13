import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/styles.dart';
import 'package:kopa/widgets/ads_active.dart';
import 'package:kopa/widgets/ads_archived.dart';

class FoldersNames {
  const FoldersNames({this.title});
  final String title;
}

const List<FoldersNames> foldersNames = const <FoldersNames>[
  const FoldersNames(title: 'Активні'),
  const FoldersNames(title: 'Архівовані'),
];

final int len = foldersNames.length;

class AdvertisementWidget extends StatefulWidget {
  @override
  _AdvertisementWidgetState createState() => _AdvertisementWidgetState();
}

class _AdvertisementWidgetState extends State<AdvertisementWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: len,
      child: Scaffold(
        backgroundColor: opacityColor,
        body: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.right,
            color: brightTurquoise,
            child: Stack(
              children: <Widget>[
                TabBarView(
                  children: [
                    AdsActiveWidget(),
                    AdsArchivedWidget(),
                  ],
                ),
                Positioned(
                  child: Container(
                    margin: const EdgeInsets.only(top: 34, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: darkGray,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1.0, color: grayBorder),
                      boxShadow: [
                        BoxShadow(
                          color: darkGray.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(1, 3),
                        ),
                      ],
                    ),
                    child: Theme(
                      data: ThemeData(
                        highlightColor: opacityColor,
                        splashColor: opacityColor,
                      ),
                      child: TabBar(
                        isScrollable: false,
                        unselectedLabelColor: whiteColor,
                        indicatorColor: brightTurquoise,
                        labelStyle: mediumTextName,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: brightTurquoise,
                        ),
                        tabs: foldersNames.map((FoldersNames foldersNames) {
                          return Container(
                            height: 34,
                            child: Tab(
                              text: foldersNames.title,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
