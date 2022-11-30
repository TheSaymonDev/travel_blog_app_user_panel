import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class MyDbHelper{
  signUp(email, password) async{
    try{
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      User? auth=credential.user;
      if(auth!.uid.isNotEmpty){
        return 'Data Added';
      }
      else{
        return 'Something is wrong';
      }
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
    catch(e){}
  }
  signIn(email, password) async{
    try{
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      User? auth=credential.user;
      if(auth!.uid.isNotEmpty){
        return 'SignIn Successful';
      }
      else{
        return 'Error';
      }
    }

    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    catch(e){}
  }
}