import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Dar import a files externos
import '../Notificacoes.dart';
import '../Aplicacao/Default.dart';

final db = FirebaseFirestore.instance;

void criarConta(BuildContext context, String username, String email,
    String password, String confirmPassword) async {
  // 0 -> Td bem / 1 -> User usado / 2 -> Email Usado
  int verificador = await verificarRegisto(username, email);

  //VER SE OS DADOS DA PASSWORD CORRESPONDEM
  if (password == confirmPassword &&
      EmailValidator.validate(email) &&
      verificador == 0) {
    /* temporário
    db.collection("Users").add({
    'Email': email,
    'Nome': username,
    'Password': password,
    });
    */

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add username to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'Username': username,
        // Add other user data as needed
      });
      logIn(context, email, password);

      //print("Account created successfully: ${userCredential.user}");
    } catch (e) {
      print("Error creating account: $e");
    }
  } else {
    //-----ERROS-----
    //NOTIFICAÇÃO DE ERRO DE USERNAME (Verificar se ele já existe na DB)
    if (verificador == 1) {
      //Para fechar o Teclado smp q dá erro
      FocusScope.of(context).requestFocus(FocusNode());
      seNome(context);
    }
    //NOTIFICAÇÃO DE ERRO FORMATO DE EMAIL ou (Verificar se ele já existe na DB)
    if (verificador == 2) {
      //Para fechar o Teclado smp q dá erro
      FocusScope.of(context).requestFocus(FocusNode());
      seEmail(context);
    }
    //NOTIFICAÇÃO DE ERRO DE PASS
    if (password != confirmPassword) {
      //Para fechar o Teclado smp q dá erro
      FocusScope.of(context).requestFocus(FocusNode());
      sePNCorrespondente(context);
    }
    //NOTIFICAÇÃO DE ERRO DE EMAIL (Formato do Email)
    if (!EmailValidator.validate(email)) {
      //Para fechar o Teclado smp q dá erro
      FocusScope.of(context).requestFocus(FocusNode());
      seFEmail(context);
    }
  }
}

Future<void> logIn(BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    //print("User logged in successfully: ${userCredential.user}");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Default()),
    );
  } catch (e) {
    print("Error logging in: $e");
  }
}

//----------VERIFICADORES FUNÇÕES----------
Future<int> verificarRegisto(String username, String email) async {
  final QuerySnapshot verNome = await FirebaseFirestore.instance
      .collection('Users')
      .where('Nome', isEqualTo: username)
      .get();
  final QuerySnapshot verEmail = await FirebaseFirestore.instance
      .collection('Users')
      .where('Email', isEqualTo: email)
      .get();

  if (verNome.docs.isNotEmpty || verEmail.docs.isNotEmpty) {
    if (verNome.docs.isNotEmpty) {
      return 1;
    } else {
      return 2;
    }
  } else {
    return 0;
  }
}

Future<int> verificarEntrada(String username, String password) async {
  final QuerySnapshot verNome = await FirebaseFirestore.instance
      .collection('Users')
      .where('Nome', isEqualTo: username)
      .get();
  final QuerySnapshot verPassword = await FirebaseFirestore.instance
      .collection('Users')
      .where('Password', isEqualTo: password)
      .get();

  if (verNome.docs.isNotEmpty && verPassword.docs.isNotEmpty) {
    return 0;
  } else {
    return 1;
  }
}
