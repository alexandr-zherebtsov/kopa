import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {

}


class NoAuth extends AuthState {

}


class AuthSuccess extends AuthState {

  FirebaseUser user;
  AuthSuccess({@required this.user});
}


class AuthFailed extends AuthState {

  String error;
  AuthFailed({this.error});
}

class AuthLoading extends AuthState {

}