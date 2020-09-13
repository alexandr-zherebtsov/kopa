import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopa/core/bloc/user_login_bloc/user_login_bloc.dart';
import 'package:kopa/core/bloc/user_login_bloc/user_login_event.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/styles.dart';
import 'package:toast/toast.dart';

class VerifyNumber extends StatefulWidget {
  @override
  _VerifyNumberState createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {

  final _textCode = TextEditingController();

  bool _validateCode = false;
  bool _validateCodeSumb = false;

  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: brightTurquoise,
                child: ListView(children: <Widget>[
                  Form(
                      key: formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                  AssetImage('assets/images/logo_big.png'),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Container(
                              width: 215,
                              height: 115,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                  AssetImage('assets/images/ellipse.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text('Вхiд', style: veryBigWhiteText),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 90,
                                  padding: const EdgeInsets.only(top: 36.0),
                                  child: TextFormField(
                                    controller: _textCode,
                                    keyboardType: TextInputType.number,
                                    cursorColor: brightTurquoise,
                                    maxLength: 6,
                                    decoration: InputDecoration(
                                      counter: Offstage(),
                                      hintText: 'Код підтвердження',
                                      contentPadding:
                                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 23.0),
                                      errorText: _validateCode ? 'Поле не повинне бути порожнім' : _validateCodeSumb ? 'Перевірте код' : null,
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
                                    onChanged: (val) {},
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 90,
                                  padding: const EdgeInsets.symmetric(vertical: 34.0),
                                  child: MaterialButton(
                                    color: brightTurquoise,
                                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                                    child: Text('Далі', style: mediumTextName),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        String pattern = r'^[0-9]+$';
                                        RegExp regex = RegExp(pattern);
                                        _textCode.text.isEmpty ? _validateCode = true : _validateCode = false;
                                        if (_validateCode == false) {
                                          !regex.hasMatch(_textCode.text) ? _validateCodeSumb = true : _validateCodeSumb = false;
                                        }
                                      });
                                      if (_validateCode == false && _validateCodeSumb == false) {
                                        final LogBloc = BlocProvider.of<LoginBloc>(context);
                                        LogBloc..add(VerifyOTPEvent(_textCode.text));
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
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                      ),
                  ),
                ]),
            ),
        ),);
  }
}
