import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopa/core/bloc/user_login_bloc/user_login_bloc.dart';
import 'package:kopa/core/bloc/user_login_bloc/user_login_event.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/styles.dart';
import 'package:toast/toast.dart';

class AuthenticationNumber extends StatefulWidget {
  @override
  _AuthenticationNumberState createState() => _AuthenticationNumberState();
}

class _AuthenticationNumberState extends State<AuthenticationNumber> {

  final _textNumber = TextEditingController()..text = '+380';
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;
  bool _validateNumber = false;
  bool _validateNumberSumb = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: brightTurquoise,
          child: ListView(
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo_big.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),

                    Container(
                      width: 215,
                      height: 115,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ellipse.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text('Вхiд', style: veryBigWhiteText),
                      ),
                    ),

                    Container(
                        width: MediaQuery.of(context).size.width - 90,
                        padding: const EdgeInsets.only(top: 36.0),
                        child: TextFormField(
                          controller: _textNumber,
                          keyboardType: TextInputType.phone,
                          maxLength: 13,
                          cursorColor: brightTurquoise,
                          decoration: InputDecoration(
                            hintText: 'Ваш номер телефона',
                            counter: Offstage(),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 23.0),
                            errorText: _validateNumber ? 'Поле повинно мати 13 символів' : _validateNumberSumb ? 'Перевірте номер' : null,
                            errorStyle: smallErrorText,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lightGrayText),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: brightTurquoise),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: errorColor),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: brightTurquoise),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              this.phoneNo = val;
                            });
                          },
                        )
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 90,
                      padding: const EdgeInsets.symmetric(vertical: 34.0),
                      child: MaterialButton(
                          color: brightTurquoise,
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Text('Верифікувати', style: mediumTextName),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          onPressed: () {
                            setState(() {
                              String pattern = r'^((\+?380)([0-9]{9}))$';
                              RegExp regex = RegExp(pattern);
                              _textNumber.text.isEmpty ? _validateNumber = true : _validateNumber = false;
                              if (_validateNumber == false) {
                                !regex.hasMatch(_textNumber.text) ? _validateNumberSumb = true : _validateNumberSumb = false;
                              }
                            });
                            if (_validateNumber == false && _validateNumberSumb == false) {
                              final LogBloc = BlocProvider.of<LoginBloc>(context);
                              LogBloc
                                ..add(SendOTPCodeEvent(_textNumber.text, context));
                            } else {
                              Toast.show(
                                'Помилка! Перевірте Ваші дані.',
                                context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.CENTER,
                                textColor: whiteColor,
                                backgroundColor: errorBgColor,
                                backgroundRadius: 20.0,
                              );
                            }
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
