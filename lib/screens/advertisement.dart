import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:kopa/models/advertisement_model.dart';
import 'package:kopa/models/user_model.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/styles.dart';
import 'package:url_launcher/url_launcher.dart';

bool num = true;

class Advertisement extends StatefulWidget {
  @override
  _AdvertisementState createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: brightTurquoise,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      decoration: BoxDecoration(
                        color: mediumGray,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: <Widget>[
                          Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              SizedBox(
                                height: MediaQuery.of(context).size.width,
                                width: MediaQuery.of(context).size.width,
                                child: ScrollConfiguration(
                                  behavior: ScrollBehavior(),
                                  child: GlowingOverscrollIndicator(
                                    axisDirection: AxisDirection.right,
                                    color: brightTurquoise,
                                    child: Carousel(
                                      autoplay: false,
                                      dotBgColor: opacityColor,
                                      borderRadius: true,
                                      radius: Radius.circular(20),
                                      images: [
                                        ExactAssetImage('$adsIcon01'),
                                        ExactAssetImage('assets/images/kopa_id0.png'),
                                        ExactAssetImage('assets/images/kopa_id1.png'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 74,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: cashYellow,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text('$adsPrice', style: mediumTextCash),
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 32,
                                      icon: Icon(Icons.favorite, color: whiteColor),
                                      onPressed: null,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6, bottom: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '$adsBrand',
                                      style: bigWhiteBoldText,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Розміри стопи:', style: smallText, textAlign: TextAlign.start),
                                ),
                                SizedBox(height: 9),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text('$adsSize', style: bigTurquoiseText),
                                        Text('EU', style: smallText),
                                      ],
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      children: <Widget>[
                                        Text('$adsLength', style: mediumWhiteText),
                                        Text('Довжина / см', style: smallText),
                                      ],
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      children: <Widget>[
                                        Text('$adsWidth', style: mediumWhiteText),
                                        Text('Ширина / см', style: smallText),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Матеріал: $adsMaterial.',
                                      style: smallTextSub,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Text(adsDescription, style: mediumGrayText,),
                                SizedBox(height: 23)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(top: 20, left: 16, right: 20, bottom: 16),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: mediumGray,
                        backgroundImage: AssetImage('$profileImage'),
                      ),
                      title: Text(
                        '$profileName $profileSurname',
                        style: bigWhiteBoldText,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      subtitle: Text(
                        '$profileCity',
                        style: mediumWhiteText,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      trailing: Transform.rotate(
                        angle: 0.8,
                        child: MaterialButton(
                            padding: const EdgeInsets.all(0),
                            height: 55,
                            minWidth: 55,
                            color: callingColor,
                            child: Transform.rotate(
                              angle: -0.8,
                              child: Icon(
                                Icons.phone,
                                size: 30,
                                color: darkGray,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {
                              setState(() {
                                if (num) {
                                  launch('tel://$profileNumber');
                                  num = false;
                                  print('First click');
                                } else {
                                  print('Excess click');
                                }
                                Future.delayed(const Duration(seconds: 2), () {
                                  num = true;
                                  print('Did new click');
                                });
                              });
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 30,
                left: 5,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [darkGray.withOpacity(0.6), darkGray.withOpacity(0.0)],
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    iconSize: 36,
                    splashColor: opacityColor,
                    highlightColor: opacityColor,
                    alignment: Alignment.topLeft,
                    tooltip: 'Повернутися',
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
