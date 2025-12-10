import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'landing.dart';
import 'homepage.dart';
import 'homepage2.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // User is not logged in
        if (!snapshot.hasData || snapshot.data == null) {
          return const LandingPage();
        }

        // User is logged in, check user type
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(snapshot.data!.uid)
              .get(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (userSnapshot.hasError || !userSnapshot.hasData) {
              return const Scaffold(
                body: Center(child: Text('Error loading user data')),
              );
            }

            // Get user type from Firestore
            final userData = userSnapshot.data!.data() as Map<String, dynamic>?;
            final userType = userData?['userType'] ?? 'type1';

            // Route based on user type
            if (userType == 'type1') {
              return const HomePage();
            } else {
              return const HomePage2();
            }
          },
        );
      },
    );
  }
}
