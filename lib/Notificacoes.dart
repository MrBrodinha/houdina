import 'package:flutter/material.dart';

void seNome(BuildContext context) {
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
      bottom: MediaQuery.of(context).size.height - 500,
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void seEmail(BuildContext context) {
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
      bottom: MediaQuery.of(context).size.height - 500,
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
    
void sePNCorrespondente(BuildContext context) {
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
      bottom: MediaQuery.of(context).size.height - 500,
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void seFEmail(BuildContext context){
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
      bottom: MediaQuery.of(context).size.height - 500,
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void loginErros(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('Username ou Password Errados...', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder( 
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 100,
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}