import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kopa/data/repositories/user_repositories.dart';
import 'package:kopa/domain/user.dart';

class Database {

  final db = Firestore.instance;

  Future<DocumentSnapshot> getUser()async{
    final uid = await UserRepositories().getCurrentUser();
    DocumentSnapshot documentSnapshot = await db.collection('users').document('${uid.uid}').get();
    return documentSnapshot;
  }

  Future<QuerySnapshot> getUserPhone(phone)async{
    final uid = await UserRepositories().getCurrentUser();
    QuerySnapshot querySnapshot = await db.collection('users').where('phoneNumber', isEqualTo: phone).getDocuments();
    return querySnapshot;
  }

  Future<void> createUser (User user) async{
    final uid = await UserRepositories().getCurrentUser();
    await db.collection('users').document('${uid.uid}').setData(user.toFirebase());
  }

}