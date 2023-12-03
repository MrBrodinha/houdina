import 'package:flutter/material.dart';

void seNome(BuildContext context) {

  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Nome em uso...', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.15),
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
void seEmail(BuildContext context) {
  
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Email em uso...', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.15),
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
} 
void sePNCorrespondente(BuildContext context) {
  
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Palavras Passes Não Correspondentes...', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.15),
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
void seFEmail(BuildContext context){

  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Formato de Email Incorreto...', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.15),
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
void sePLenght(BuildContext context){

  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Password necessita de ter pelo menos 6 caracteres', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.15),
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
void loginErros(BuildContext context) {

  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Email ou Password Errados...', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder( 
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.15),
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}





void adicionarCErro(BuildContext context) {

  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Dados Inseridos Vazios ou Incorretos...', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder( 
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.10),
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
void adicionarCDRFalta(BuildContext context) {

  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Documento de Prova em Falta...', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder( 
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.10),
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
void adicionarCarroSucesso(BuildContext context) {

  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Carro Registado', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder( 
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.10),
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}