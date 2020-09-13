import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kopa/domain/user.dart';
import 'package:kopa/models/user_model.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/kopa_app_icons.dart';
import 'package:kopa/resources/styles.dart';
import 'package:kopa/screens/profile_editing.dart';
import 'package:kopa/services/logging.dart';

class ProfileWidget extends StatelessWidget {
  User user;
  ProfileWidget({this.user});

  Widget _profileInfo(String titleText, String infoText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(
                color: brightTurquoise,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            SizedBox(width: 7),
            Text(titleText, style: mediumGrayText),
          ],
        ),
        SizedBox(height: 10),
        Text(infoText, style: mediumTextName),
        Divider(color: lightGrayText),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: brightTurquoise,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 61, left: 31, right: 31),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        radius: 45.5,
                        backgroundColor: mediumGray,
                        backgroundImage: AssetImage('$profileImage'),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width - 190,
                              child: Text(
                                '${user.name} ${user.surname}',
                                style: bigWhiteBoldText,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text('${user.city}', style: mediumGrayBoldText),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          height: 20,
                          width: 20,
                          alignment: Alignment.topRight,
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            icon: Icon(KopaAppIcons.pen, color: brightTurquoise, size: 20,),
                            tooltip: 'Редагувати профіль',
                            onPressed: () =>
                                Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (_) =>
                                      ProfileEditing(),
                                ),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 35),

                _profileInfo('Контактний номер', '${user.phoneNumber}'),
                SizedBox(height: 22),
                _profileInfo('Технічна підтримка', 'Telegram'),

                SizedBox(height: 40),
                Center(
                  child: MaterialButton(
                    color: brightTurquoise,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Text('Вийти', style: mediumTextName),
                    onPressed: () {
                      AuthService().logOut();
                      SystemNavigator.pop();
                    },
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
