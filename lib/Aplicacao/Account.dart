import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Default.dart';
import '../Main.dart';

class Account extends StatefulWidget {
  const Account({super.key});
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    super.initState();
  }

  //para dar sign out
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      //print("User signed out successfully");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        //Wallpaper
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:
                  NetworkImage('https://wallpapercave.com/wp/wp10671634.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.01,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(25, 95, 255, 1.0),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.car_crash,
                          size: MediaQuery.of(context).size.height * 0.05,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(25, 95, 255, 1.0),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.punch_clock,
                          size: MediaQuery.of(context).size.height * 0.05,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              //Botão Central -> LOGO
              IconButton(
                icon: Image.asset(
                  'resources/Logo.png',
                  width: MediaQuery.of(context).size.height * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Default()),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(25, 95, 255, 1.0),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.gps_fixed,
                          size: MediaQuery.of(context).size.height * 0.05,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(25, 95, 255, 1.0),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.exit_to_app,
                          size: MediaQuery.of(context).size.height * 0.05,
                          color: Colors.white),
                      onPressed: () {
                        signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Main()),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//Envia sempre os três dados, caso n mude algum envia os já existentes
Future<void> updateProfile(
    String newEmail, String newPassword, String newUsername) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Update email and password in Firebase Authentication
      await user.updateEmail(newEmail);
      await user.updatePassword(newPassword);

      // Update username in Firestore (adjust the collection and field names accordingly)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'username': newUsername});

      //print("Profile updated successfully");
    }
  } catch (e) {
    print("Error updating profile: $e");
    // Handle the error accordingly
  }
}

Future<void> resetPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    print("Password reset email sent successfully");
  } catch (e) {
    print("Error sending password reset email: $e");
    // Handle the error accordingly
  }
}

