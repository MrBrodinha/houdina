import 'package:flutter/material.dart';

void SENome(BuildContext context) {
  final snackBar = SnackBar(
    content:Text('Nome em uso...', textAlign: TextAlign.center),
    duration: Duration(seconds: 4),
    backgroundColor: Color.fromRGBO(25, 95, 255, 1.0),
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

void SEEmail(BuildContext context) {
  final snackBar = SnackBar(
    content:Text('Email em uso...', textAlign: TextAlign.center),
    duration: Duration(seconds: 4),
    backgroundColor: Color.fromRGBO(25, 95, 255, 1.0),
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
    
void SEPNCorrespondente(BuildContext context) {
  final snackBar = SnackBar(
    content:Text('Palavras Passes Não Correspondentes...', textAlign: TextAlign.center),
    duration: Duration(seconds: 4),
    backgroundColor: Color.fromRGBO(25, 95, 255, 1.0),
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

void SEFEmail(BuildContext context){
  final snackBar = SnackBar(
    content:Text('Formato de Email Incorreto...', textAlign: TextAlign.center),
    duration: Duration(seconds: 4),
    backgroundColor: Color.fromRGBO(25, 95, 255, 1.0),
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

void LoginErros(BuildContext context) {
  final snackBar = SnackBar(
    content: Text('Username ou Password Errados...', textAlign: TextAlign.center),
    duration: Duration(seconds: 4),
    backgroundColor: Color.fromRGBO(25, 95, 255, 1.0),
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