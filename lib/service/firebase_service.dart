import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService{
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        if (googleSignInAuthentication.accessToken != null && googleSignInAuthentication.idToken != null) {
          final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          await _auth.signInWithCredential(authCredential);
        } else {
          throw FirebaseAuthException(
            code: 'credential-missing',
            message: 'Google sign-in credentials are missing.',
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  signOut() async{
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

}