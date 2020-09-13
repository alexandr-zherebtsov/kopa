import 'package:flutter/material.dart';
import 'package:kopa/models/user_model.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/styles.dart';
import 'package:toast/toast.dart';

class ProfileEditing extends StatefulWidget {
  @override
  _ProfileEditingState createState() => _ProfileEditingState();
}

class _ProfileEditingState extends State<ProfileEditing> {

  final controllerName = TextEditingController()..text = '$profileName';
  final controllerSurname = TextEditingController()..text = '$profileSurname';
  final controllerNumber = TextEditingController()..text = '$profileNumber';
  final controllerCity = TextEditingController()..text = '$profileCity';

  bool _validateName = false;
  bool _validateSurname = false;
  bool _validateNumber = false;
  bool _validateCity = false;
  bool _validateNumberSign = false;

  Widget _textField(String titleText, keyboardType, controller, validate, maxLength) {
    return Column(
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
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: brightTurquoise,
          maxLength: maxLength,
          decoration: InputDecoration(
            counter: Offstage(),
            errorText: validate ? 'Поле не повинне бути порожнім' : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: lightGrayText),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: brightTurquoise),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: errorColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: brightTurquoise),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: brightTurquoise,
          child: ListView(
            padding: const EdgeInsets.only(top: 61, left: 31, right: 31),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 45.5,
                            backgroundColor: mediumGray,
                            backgroundImage: AssetImage('$profileImage'),
                          ),
                          Positioned(
                            top: 59,
                            left: 53,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: brightTurquoise,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: IconButton(
                                splashColor: Color(0x00FFFFFF),
                                highlightColor: Color(0x00FFFFFF),
                                padding: const EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.add,
                                  color: whiteColor,
                                  size: 26,
                                ),
                                tooltip: 'Змінити аватаку',
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 170,
                        child: Text(
                          '$profileName $profileSurname',
                          style: bigWhiteBoldText,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text('$profileCity', style: mediumGrayBoldText),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 35),
              _textField('Ваше ім\'я', TextInputType.text, controllerName, _validateName, 50),
              SizedBox(height: 22),
              _textField('Ваше прізвище', TextInputType.text, controllerSurname, _validateSurname, 50),
              SizedBox(height: 22),
              _textField('Контактний номер', TextInputType.phone, controllerNumber, _validateNumber, 13),
              SizedBox(height: 22),
              _textField('Місто', TextInputType.text, controllerCity, _validateCity, 50),
              SizedBox(height: 40),

              Center(
                child: MaterialButton(
                  color: brightTurquoise,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Text('Змінити', style: mediumTextName),
                  onPressed: () {
                    String pattern = r'^((\+?380)([0-9]{9}))$';
                    RegExp regex = RegExp(pattern);
                    setState(() {
                      controllerName.text.isEmpty ? _validateName = true : _validateName = false;
                      controllerSurname.text.isEmpty ? _validateSurname = true : _validateSurname = false;
                      controllerNumber.text.isEmpty ? _validateNumber = true : _validateNumber = false;
                      controllerCity.text.isEmpty ? _validateCity = true : _validateCity = false;
                      !regex.hasMatch(controllerNumber.text) ? _validateNumberSign = true : _validateNumberSign = false;
                    });
                    if (_validateName == false && _validateSurname == false && _validateNumber == false && _validateCity == false) {
                      if (_validateNumberSign) {
                        Toast.show(
                          'Помилка! Перевірте Ваш номер телефона.',
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.CENTER,
                          textColor: whiteColor,
                          backgroundColor: errorBgColor,
                          backgroundRadius: 20.0,
                        );
                      }
                    }
                  },
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
