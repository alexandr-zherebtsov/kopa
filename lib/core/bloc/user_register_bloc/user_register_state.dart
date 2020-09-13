import 'package:equatable/equatable.dart';
import 'package:kopa/domain/user.dart';

abstract class RegisterUserState extends Equatable{

}

class RegisterInitialState extends RegisterUserState{

}

class RegisterSuccessState extends RegisterUserState {

  User user;
  RegisterSuccessState(this.user);

}

class RegisterExceptionState extends RegisterUserState {

  String error;
  RegisterExceptionState({this.error});
}

class RegisterLoading extends RegisterUserState{

}

