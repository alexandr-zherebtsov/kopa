import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:kopa/core/bloc/user_auth_bloc/user_auth_bloc.dart';
import 'package:kopa/core/bloc/user_login_bloc/user_login_event.dart';
import 'package:kopa/core/bloc/user_login_bloc/user_login_state.dart';
import 'package:kopa/data/repositories/user_repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
   UserRepositories userRepositories;
   AuthBloc authBloc;

  LoginBloc(this.userRepositories, this.authBloc) : super(LoginInitialState());

  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is AppStartLoginEvent){
      yield LoginInitialState();
    }
    if(event is SignInWithGoogle){
      yield* _mapGoogleSignIn(event);
    }
    if (event is SendOTPCodeEvent) {
      yield* _mapSendOTP(event);
    }
    if (event is VerifyOTPEvent) {
      yield* _mapVerifyOTP(event);
    }
    if(event is SignInWithPhone){
      yield SendOTPState();
    }
    if(event is SignInWithFacebook){
      yield* _mapFacebookSignIn(event);
    }

  }

  Stream<LoginState> _mapVerifyOTP(VerifyOTPEvent event) async* {
    try {
      final user = await userRepositories.OTPVerify(event.otp);
      print(user);
      if (user != null) {
        yield LoginSuccess();
      } else {
        yield LoginFaild(error: "Error");
      }
    } catch (e) {
      print('Something wrong ${e.toString()}');
    }
  }

   Stream<LoginState> _mapGoogleSignIn(SignInWithGoogle event) async* {
     print('GoogleAuth');
     yield LoginLoading();
     try{
       final user = await userRepositories.signInWithGoogle();
       yield LoginSuccess();
     }catch(e){
       print(e);
       yield LoginFaild(error: e);
     }
   }

  Stream<LoginState> _mapSendOTP(SendOTPCodeEvent event) async* {
    print('Im here');
    yield LoginLoading();
    try {
      await userRepositories.loginUserWithPhoneNumber(event.phone, event.context);
        yield VerifyOTPState();
    } catch (e) {
      print(e);
      LoginFaild(error: e ?? 'An unknown message of error ');
    }
  }

   Stream<LoginState> _mapFacebookSignIn(SignInWithFacebook event) async* {
     print('Im here');
     yield LoginLoading();
     try {
      final user = await userRepositories.loginWithFacebooke();
      if(user != null) {
        yield LoginSuccess();
      }
      else LoginFaild(error: "Юзер з таким емейлом вже існує");
     } catch (e) {
       print(e);
       LoginFaild(error: e ?? 'An unknown message of error ');
     }
   }
}
