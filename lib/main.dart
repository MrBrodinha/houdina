import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:houdina/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //inicilizar o firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  final db = FirebaseFirestore.instance;

  final user = <String, dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };

//exemplo para adicionar
  db.collection("users").add(user).then((DocumentReference doc) =>
    print('DocumentSnapshot added with ID: ${doc.id}'));

//exemplo para ir buscar
  await db.collection("users").get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  });
}
