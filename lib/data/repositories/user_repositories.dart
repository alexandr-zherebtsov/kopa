import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepositories {

  FirebaseAuth _auth = FirebaseAuth.instance;
  String verId = '';
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> loginUserWithPhoneNumber(String phone, BuildContext context) async {

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      print('Verification Id: $verificationId');
      this.verId = verificationId;

    };
    final PhoneVerificationFailed verificationFailed = (AuthException exception) {
      return exception.message;
    };
    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout = (String verificationId){
      this.verId = verificationId;
    };

    final PhoneVerificationCompleted verificationCompleted = (AuthCredential credential) async {};

       _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted:verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
      );
}

Future<FirebaseUser> loginWithFacebooke() async{
    FacebookLogin facebookSignIn = FacebookLogin();
    final result = await facebookSignIn.logIn(['email']);
    if(result.status == FacebookLoginStatus.loggedIn){
      final credentials = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
      final user = await FirebaseAuth.instance.signInWithCredential(credentials);
      print('${user.user}');
      return user.user;
    }
    else{
      return null;
    }

}

  Future<FirebaseUser> getCurrentUser()async{

    FirebaseUser user = await _auth.currentUser();
    if(user != null){
      print(user.displayName);
      print(user.phoneNumber);
      return user ;
    }
    else{
      return null;
    }
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);
    print(user.phoneNumber);
    print(user.uid);
    print(user.displayName);
    print(user.email);
    print(user.photoUrl);

    return user;
  }

    Future<FirebaseUser> OTPVerify ( codeController) async {
      final code = codeController;
      print(this.verId);
      print(code);
      AuthCredential credential =  PhoneAuthProvider
          .getCredential(
          verificationId: this.verId, smsCode: code);
        AuthResult result = await _auth.signInWithCredential(
          credential);

        if(result.user != null){
          return result.user;
        }
        else{
          return null;
        }
    }

  Future<void> SignOut() async{
    await _auth.signOut();
  }
}
