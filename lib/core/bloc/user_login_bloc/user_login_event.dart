import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable{

}

class AppStartLoginEvent extends LoginEvent{

}

class SignInWithFacebook extends LoginEvent{

}

class SignInWithGoogle extends LoginEvent{

}

class SignInWithPhone extends LoginEvent{

}

class SendOTPCodeEvent extends LoginEvent{

  String phone;
  BuildContext context;
  SendOTPCodeEvent(this.phone, this.context);
}

class VerifyOTPEvent extends LoginEvent{

  String otp;
  VerifyOTPEvent( this.otp );
}

class LoginExceptionnEvent extends LoginEvent{

  String messege;

  LoginExceptionnEvent(this.messege);
}