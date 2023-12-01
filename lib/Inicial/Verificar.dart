import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Dar import a files externos
import '../Notificacoes.dart';
import '../Aplicacao/Default.dart';

final db = FirebaseFirestore.instance;

void criarConta(BuildContext context, String username, String email,String password, String confirmPassword) async {

  // 0 -> Td bem / 1 -> User usado / 2 -> Email Usado
  int verificador = await verificarRegisto(username, email);

  //NOTIFICAÇÃO DE ERRO DE PASS
  if (password != confirmPassword) {
    //Para fechar o Teclado smp q dá erro
    FocusScope.of(context).requestFocus(FocusNode());
    sePNCorrespondente(context);
  } else if(verificador == 1){
    //NOTIFICAÇÃO DE ERRO DE USERNAME (Verificar se ele já existe na DB)
    FocusScope.of(context).requestFocus(FocusNode());
    seNome(context);
  } else if(verificador == 0){
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
    } on FirebaseAuthException catch (e) {
      //PASSWORD TEM QUE TER 6 CARACTERES
      if(e.code == 'weak-password'){
        //Para fechar o Teclado smp q dá erro
        FocusScope.of(context).requestFocus(FocusNode());
        sePLenght(context);
      }
      //NOTIFICAÇÃO DE ERRO DE EMAIL (Formato do Email)
      if (!EmailValidator.validate(email)){
        //Para fechar o Teclado smp q dá erro
        FocusScope.of(context).requestFocus(FocusNode());
        seFEmail(context);
      }
      //NOTIFICAÇÃO DE ERRO DE EMAIL (Verificar se ele já existe na DB)
      if (e.code == 'email-already-in-use') {
        //Para fechar o Teclado smp q dá erro
        FocusScope.of(context).requestFocus(FocusNode());
        seEmail(context);
      }
    } catch (e) {
      print("Error creating account: $e");
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => Default()),);
  } catch (e) {
    //Tirar o foco do teclado
    FocusScope.of(context).requestFocus(FocusNode());
    print("Error logging in: $e");
    loginErros(context);
  }
}

//----------VERIFICADORES FUNÇÕES----------
Future<int> verificarRegisto(String username, String email) async {
  final QuerySnapshot verNome = await FirebaseFirestore.instance
      .collection('users')
      .where('Username', isEqualTo: username)
      .get();

  if (verNome.docs.isNotEmpty){
    return 1;
  } else {
    return 0;
  }
}