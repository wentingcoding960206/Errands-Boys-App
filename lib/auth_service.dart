import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {

      // sign user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // save user info if it does not already exist
      _firestore.collection('Users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid, 
          'email': email
        }
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      // create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // save user info in a separate doc
      _firestore.collection('Users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid, 
          'email': email
        }
      );


      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> signOut() async {
    print("sign out");
    return await _auth.signOut();
  }

  // errors

  // Google Sign In
  signInWithGoogle() async {
    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );

    // finally, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
