import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kopa/domain/user.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/kopa_app_icons.dart';
import 'package:kopa/screens/add_ads.dart';
import 'package:kopa/widgets/user_advertisements.dart';
import 'package:kopa/widgets/liked.dart';
import 'package:kopa/widgets/shoes.dart';
import 'package:kopa/widgets/profile.dart';

class KopaScreen extends StatefulWidget {

  User user ;
  KopaScreen(this.user);
  @override
  _KopaScreenState createState() => _KopaScreenState();
}

class _KopaScreenState extends State<KopaScreen> {

  int _selectedIndex = 0;


  void _onTappedHome() {
    setState(() {
      _selectedIndex = 0;
      _iconColor0 = brightTurquoise;
      _iconColor1 = grayIcon;
      _iconColor2 = grayIcon;
      _iconColor3 = grayIcon;
    });
  }

  void _onTappedList() {
    setState(() {
      _selectedIndex = 1;
      _iconColor0 = grayIcon;
      _iconColor1 = brightTurquoise;
      _iconColor2 = grayIcon;
      _iconColor3 = grayIcon;
    });
  }

  void _onTappedLiked() {
    setState(() {
      _selectedIndex = 2;
      _iconColor0 = grayIcon;
      _iconColor1 = grayIcon;
      _iconColor2 = brightTurquoise;
      _iconColor3 = whiteColor;
    });
  }

  void _onTappedSettings() {
    setState(() {
      _selectedIndex = 3;
      _iconColor0 = grayIcon;
      _iconColor1 = grayIcon;
      _iconColor2 = grayIcon;
      _iconColor3 = brightTurquoise;
    });
  }

  Color _iconColor0 = brightTurquoise;
  Color _iconColor1 = grayIcon;
  Color _iconColor2 = grayIcon;
  Color _iconColor3 = grayIcon;

  @override
  Widget build(BuildContext context) {
     final List<Widget> _widgetOptions = <Widget>[
      ShoesWidget(),
      AdvertisementWidget(),
      LikedWidget(),
      ProfileWidget(user: widget.user),
    ];

    return Container(
      decoration: BoxDecoration(
        color: darkGray,
        image: DecorationImage(
          image: AssetImage('assets/images/bg_screen.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: opacityColor,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomAppBar(
          color: mediumGray,
          child: Container(
            padding: const EdgeInsets.all(0),
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(),
                Container(
                  height: double.infinity,
                  padding: _selectedIndex == 0 ? const EdgeInsets.only(top: 0.0) : const EdgeInsets.only(top: 2.0),
                  decoration: BoxDecoration(
                    border: _selectedIndex == 0 ? Border(top: BorderSide(width: 2.0, color: brightTurquoise)) : Border(),
                  ),
                  child: IconButton(
                    icon: Icon(
                      KopaAppIcons.main,
                      color: _iconColor0,
                      size: 22,
                    ),
                    onPressed: _onTappedHome,
                  ),
                ),
                Container(
                  height: double.infinity,
                  padding: _selectedIndex == 1 ? const EdgeInsets.only(top: 0.0) : const EdgeInsets.only(top: 2.0),
                  decoration: BoxDecoration(
                    border: _selectedIndex == 1 ? Border(top: BorderSide(width: 2.0, color: brightTurquoise)) : Border(),
                  ),
                  child: IconButton(
                    icon: Icon(
                      KopaAppIcons.kopa,
                      color: _iconColor1,
                      size: 28,
                    ),
                    onPressed: _onTappedList,
                  ),
                ),
                SizedBox(width: 60),
                Container(
                  height: double.infinity,
                  padding: _selectedIndex == 2 ? const EdgeInsets.only(top: 0.0) : const EdgeInsets.only(top: 2.0),
                  decoration: BoxDecoration(
                    border: _selectedIndex == 2 ? Border(top: BorderSide(width: 2.0, color: brightTurquoise)) : Border(),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: _iconColor2,
                      size: 28,
                    ),
                    onPressed: _onTappedLiked,
                  ),
                ),
                Container(
                  height: double.infinity,
                  padding: _selectedIndex == 3 ? const EdgeInsets.only(top: 0.0) : const EdgeInsets.only(top: 2.0),
                  decoration: BoxDecoration(
                    border: _selectedIndex == 3 ? Border(top: BorderSide(width: 2.0, color: brightTurquoise)) : Border(),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.person,
                      color: _iconColor3,
                      size: 30,
                    ),
                    onPressed: _onTappedSettings,
                  ),
                ),
                SizedBox(),
              ],
            ),
          ),
        ),
        floatingActionButton: Transform.rotate(
          angle: 0.8,
          child: FloatingActionButton(
            heroTag: 'buttonAddAds',
            backgroundColor: brightTurquoise,
            child: Transform.rotate(
              angle: -0.8,
              child: Icon(
                Icons.add,
                color: whiteColor,
              ),
            ),
            onPressed: ()  =>
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (_) =>
                      AddAds(),
                  ),
                ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                  color: mediumGray,
                  width: 4,
                )
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
