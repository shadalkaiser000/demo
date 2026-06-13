import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthService {


  // Connecting with Firebase Authentication

  final FirebaseAuth _auth =
      FirebaseAuth.instance;


  // Connecting with Firestore Database

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;



  // ===========================
  // REGISTER USER
  // ===========================


  Future<User?> register(
      String email,
      String password,
      String role
      ) async {


    try {


      // Create account in Firebase Authentication

      UserCredential result =
      await _auth.createUserWithEmailAndPassword(

        email: email,

        password: password,

      );



      // Getting the newly created user's information

      User? user = result.user;



      // Saving extra information in Firestore

      await _firestore
          .collection("users")
          .doc(user!.uid)
          .set({

            "email": email,

            "role": role,

            "createdAt":
            DateTime.now()


          });



      return user;



    }


    catch(e){

      print(e);

      return null;

    }

  }





  // ===========================
  // LOGIN USER
  // ===========================


  Future<User?> login(
      String email,
      String password
      ) async {


    try{


      UserCredential result =

      await _auth.signInWithEmailAndPassword(

          email: email,

          password: password

      );



      return result.user;


    }


    catch(e){


      print(e);


      return null;


    }


  }





  // ===========================
  // LOGOUT USER
  // ===========================


  Future<void> logout() async{


    await _auth.signOut();


  }





  // ===========================
  // GET USER ROLE
  // ===========================


  Future<String?> getUserRole(String uid) async{


    DocumentSnapshot userData =

    await _firestore

        .collection("users")

        .doc(uid)

        .get();



    return userData["role"];


  }



}
