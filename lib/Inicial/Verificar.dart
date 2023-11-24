import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Dar import a files externos
import '../Main.dart';

final db = FirebaseFirestore.instance;
/*
//exemplo para ir buscar
  await db.collection("users").get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  });*/

void CriarConta(BuildContext context, String username, String email, String password, String confirmPassword){

	int verificador = 0;

	//FAZER UM CHECK NA DATABASE PARA VERIFICAR SE HÁ DADOS REPETIDOS

	//VER SE OS DADOS DA PASSWORD CORRESPONDEM
	if (password == confirmPassword && EmailValidator.validate(email)) {
		
    db.collection("Users").add({
    'Email': email,
    'Nome': username,
    'Password': password,
    });

    verificador = 1;

	} else {
		//NOTIFICAÇÃO DE ERRO DE USERNAME (Verificar se ele já existe na DB)
		//NOTIFICAÇÃO DE ERRO DE PASS
		if(password != confirmPassword ){
			print('Erro -> Palavras Passes Erradas');
		}
		//NOTIFICAÇÃO DE ERRO DE EMAIL (Formato do Email)
		if(!EmailValidator.validate(email)){
			print('Erro -> Formato de Email Incorreto');
		}
	}


	if (verificador == 1){
		Navigator.push(context,
			MaterialPageRoute(builder: (context) => Main()),
		);
	}
}

void EntrarConta(BuildContext context, String username, String password){
  
  int verificador = 0;

  //Verificar se há esse username e se a password corresponde aos valores da DB
  if(username == "asd" && password == "asd"){
    verificador = 1;
  }else{
    print("Username ou Password Errados");
  }

  if(verificador == 1){
    //Se for Funcionário
    //Se for Cliente
    Navigator.push(context,
			MaterialPageRoute(builder: (context) => Main()),
		);
  }
}