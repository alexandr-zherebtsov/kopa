import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopa/core/bloc/user_auth_bloc/user_auth_bloc.dart';
import 'package:kopa/core/bloc/user_login_bloc/user_login_bloc.dart';
import 'package:kopa/core/bloc/user_login_bloc/user_login_event.dart';
import 'package:kopa/core/bloc/user_login_bloc/user_login_state.dart';
import 'package:kopa/data/repositories/user_repositories.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/resources/kopa_app_icons.dart';
import 'package:kopa/resources/styles.dart';
import 'package:kopa/screens/auth_number.dart';
import 'package:kopa/screens/reg.dart';
import 'package:kopa/screens/verify_number.dart';

class AuthenticationScreen extends StatefulWidget {

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(UserRepositories(), AuthBloc()),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          print(state);
          if (state is LoginInitialState)
            return buildLoginScreen(context);
          else if (state is SendOTPState)
            return AuthenticationNumber();
          else if (state is VerifyOTPState)
            return VerifyNumber();
          else if (state is LoginLoading)
            return Center(child: CircularProgressIndicator());
          else if (state is LoginFaild)
            return Text("Error");
          else if (state is LoginSuccess) {
            return Registration();
          }
          return Container();
        },
      ),
    );
  }
  Widget buildLoginScreen(context){
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: brightTurquoise,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 52),
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
                SizedBox(height: 30),
                Container(
                  width: 281,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buttonNumber(context),
                      _buttonFacebook(context),
                      _buttonGmail(context),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buttonNumber(context){
    return FloatingActionButton(
        heroTag: 'buttonNumber',
        backgroundColor: telephoneColor,
        child: Icon(Icons.phone, color: whiteColor),
        onPressed: () {
          final LogBloc = BlocProvider.of<LoginBloc>(context);
          LogBloc..add(SignInWithPhone());
        }

    );
  }

  Widget _buttonFacebook(context){
    return FloatingActionButton(
      heroTag: 'buttonFacebook',
      backgroundColor: facebookColor,
      child: Icon(KopaAppIcons.facebook, color: whiteColor),
      onPressed: () {
        final LogBloc = BlocProvider.of<LoginBloc>(context);
        LogBloc..add(SignInWithFacebook());
      },
    );
  }

  Widget _buttonGmail(context){
    return FloatingActionButton(
        heroTag: 'buttonGmail',
        backgroundColor: gmailColor,
        child: Icon(KopaAppIcons.gmail, color: whiteColor),
        onPressed: ()
        {
          final LogBloc = BlocProvider.of<LoginBloc>(context);
          LogBloc..add(SignInWithGoogle());
        }

    );
  }

}
