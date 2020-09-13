import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String city;
  String surname;
  String phoneNumber;
  User({this.name, this.surname, this.city, this.phoneNumber});

  Map<String, Object> toFirebase(){
    return {
      'name' : name,
      'surname' : surname,
      'city' : city,
      'phoneNumber' : phoneNumber == null ? "Номер не вказано" : phoneNumber,
    };
  }

  User fromDocument (DocumentSnapshot snapshot){
    return User(
      name: snapshot.data['name'],
      surname: snapshot.data['surname'],
      phoneNumber: snapshot.data['phoneNumber'],
      city: snapshot.data['city'],
    );
  }
}