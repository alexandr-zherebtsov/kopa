import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvents extends Equatable {
  AuthEvents([List props = const []]) : super(props);
}


class AppStartEvent extends AuthEvents {

}

class UserLoggedIn extends AuthEvents{

  FirebaseUser user;
  UserLoggedIn(this.user);
}