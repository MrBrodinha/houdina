import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Dar import a files externos
import '../Main.dart';

final db = FirebaseFirestore.instance;

void CriarConta(BuildContext context, String username, String email, String password, String confirmPassword) async{

  // 0 -> Td bem / 1 -> User usado / 2 -> Email Usado
	int verificador = await VerificarRegisto(username, email);

	//VER SE OS DADOS DA PASSWORD CORRESPONDEM
	if (password == confirmPassword && EmailValidator.validate(email) && verificador == 0) {
		
    db.collection("Users").add({
    'Email': email,
    'Nome': username,
    'Password': password,
    });

    Navigator.push(context,
			MaterialPageRoute(builder: (context) => Main()),
		);

	} else { //-----ERROS-----
		//NOTIFICAÇÃO DE ERRO DE USERNAME ou (Verificar se ele já existe na DB)
    if(verificador == 1){
      print("Erro -> Nome em uso...");
    }
    if(verificador == 2){
      print("Erro -> Email em uso...");
    }
		//NOTIFICAÇÃO DE ERRO DE PASS
		if(password != confirmPassword ){
			print('Erro -> Palavras Passes Não Correspondentes...');
		}
		//NOTIFICAÇÃO DE ERRO DE EMAIL (Formato do Email)
		if(!EmailValidator.validate(email)){
			print('Erro -> Formato de Email Incorreto...');
		}
	}
}

void EntrarConta(BuildContext context, String username, String password) async{
  
  //Se for 0 -> Td bem / 1 -> Erro
  int verificador = await VerificarEntrada(username, password);

  //Verificar se há esse username e se a password corresponde aos valores da DB
  if(verificador == 0){
    Navigator.push(context,
			MaterialPageRoute(builder: (context) => Main()),
		);
  }else{
    print("Username ou Password Errados");
  }

}


//----------VERIFICADORES FUNÇÕES----------
Future<int> VerificarRegisto(String username, String email) async{

  final QuerySnapshot verNome = await FirebaseFirestore.instance.collection('Users').where('Nome', isEqualTo: username).get();
  final QuerySnapshot verEmail = await FirebaseFirestore.instance.collection('Users').where('Email', isEqualTo: email).get();

  if (verNome.docs.isNotEmpty || verEmail.docs.isNotEmpty) {
    if(verNome.docs.isNotEmpty){
      return 1;
    }else{
      return 2;
    }
  }else{
    return 0;
  }

}
Future<int> VerificarEntrada(String username, String password) async{

  final QuerySnapshot verNome = await FirebaseFirestore.instance.collection('Users').where('Nome', isEqualTo: username).get();
  final QuerySnapshot verPassword = await FirebaseFirestore.instance.collection('Users').where('Password', isEqualTo: password).get();

  if (verNome.docs.isNotEmpty && verPassword.docs.isNotEmpty) {
    return 0;
  }else{
    return 1;
  }

}