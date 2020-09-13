import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AuthService {

  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  bool codeCheck = true;

  Future signInWithNumber(smsCode, verId) async {
    try {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(verificationId: verId, smsCode: smsCode);
    await signIn(authCreds);
    } catch(numberError) {
      print(numberError);
      return null;
    }
  }

  Future logOut() async{
    await _fAuth.signOut();
  }

}
