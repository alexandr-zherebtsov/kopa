import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopa/core/bloc/user_register_bloc/user_register_bloc.dart';
import 'package:kopa/core/bloc/user_register_bloc/user_register_event.dart';
import 'package:kopa/core/bloc/user_register_bloc/user_register_state.dart';
import 'package:kopa/data/database.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/styles.dart';
import 'package:kopa/screens/screen.dart';
import 'package:toast/toast.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _textName = TextEditingController();
  final _textSurname = TextEditingController();
  final _textCity = TextEditingController();

  bool _validateName = false;
  bool _validateSurname = false;
  bool _validateCity = false;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<RegisterUserBloc>(
      create: (context) => RegisterUserBloc(Database())..add(RegisterInitialEvent()),
      child: BlocBuilder<RegisterUserBloc , RegisterUserState>(
        builder: (context, state){
          print(state);
          if(state is RegisterInitialState){
            return buildRegScreen(context);
          }
          else if(state is RegisterSuccessState){
            return KopaScreen(state.user);
          }
          else if(state is RegisterExceptionState){
            return Container(child: Text('Reg error'),);
          }
          else if(state is RegisterLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },

      ),
    );
  }

  Widget buildRegScreen(context){
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: brightTurquoise,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 215,
                      height: 115,
                      margin: const EdgeInsets.only(top: 65.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ellipse.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text('Реєстрація', style: veryBigWhiteText),
                      ),
                    ),
                    _textField(_textName, 'Ім’я', _validateName),
                    _textField(_textSurname, 'Прізвище', _validateSurname),
                    _textField(_textCity, 'Місто', _validateCity),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height - 637), //-45
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 45.0),
                  padding: const EdgeInsets.symmetric(vertical: 34.0),
                  child: MaterialButton(
                    color: brightTurquoise,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Text('Готово', style: mediumTextName),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    onPressed: ()  {
                    String pattern = r'^[a-zа-яёіїA-ZА-ЯЁІЇ\s^-]+$';
                    RegExp regex = RegExp(pattern);
                      setState(() {
                        _textName.text.isEmpty || !regex.hasMatch(_textName.text) ? _validateName = true : _validateName = false;
                        _textSurname.text.isEmpty || !regex.hasMatch(_textSurname.text) ? _validateSurname = true : _validateSurname = false;
                        _textCity.text.isEmpty || !regex.hasMatch(_textCity.text) ? _validateCity = true : _validateCity = false;
                      });
                      if (_validateName == false && _validateSurname == false && _validateCity == false) {
                        final RegBloc = BlocProvider.of<RegisterUserBloc>(context);
                        RegBloc..add(RegisterCreateUser(_textName.text, _textSurname.text, _textCity.text));
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
          ),
        ),
      ),
    );
  }
  Widget _textField(controllerText, String hintText, validate) {
    return Container(
      width: MediaQuery.of(context).size.width - 90,
      margin: const EdgeInsets.only(top: 36.0),
      child: TextField(
        controller: controllerText,
        keyboardType: TextInputType.text,
        cursorColor: brightTurquoise,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 23.0),
          errorText: validate ? 'Поле не повинне бути порожнім або містити цифри' : null,
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
      ),
    );
  }
}
