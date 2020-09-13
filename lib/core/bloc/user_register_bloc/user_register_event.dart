import 'package:equatable/equatable.dart';

abstract class RegisterUserEvent extends Equatable {

}

class RegisterInitialEvent extends RegisterUserEvent {

}

class RegisterCreateUser extends RegisterUserEvent{

  String name;
  String surname;
  String city;

  RegisterCreateUser(this.name, this.surname, this.city);
}

