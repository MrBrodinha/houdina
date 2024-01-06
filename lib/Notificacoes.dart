import 'package:flutter/material.dart';


void seNome(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Nome em uso', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.85,
      left: MediaQuery.of(context).size.width * 0.15,
      right: MediaQuery.of(context).size.width * 0.15,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void seEmail(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Email em uso', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.85,
      left: MediaQuery.of(context).size.width * 0.15,
      right: MediaQuery.of(context).size.width * 0.15,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void sePNCorrespondente(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Palavras Passes Não Correspondentes',
        textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.85,
      left: MediaQuery.of(context).size.width * 0.15,
      right: MediaQuery.of(context).size.width * 0.15,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void seFEmail(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content:
        const Text('Formato de Email Incorreto', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.85,
      left: MediaQuery.of(context).size.width * 0.15,
      right: MediaQuery.of(context).size.width * 0.15,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void sePLenght(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Password necessita de ter pelo menos 6 caracteres',
        textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.85,
      left: MediaQuery.of(context).size.width * 0.15,
      right: MediaQuery.of(context).size.width * 0.15,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void loginErros(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content:
        const Text('Email ou Password Errados', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.85,
      left: MediaQuery.of(context).size.width * 0.15,
      right: MediaQuery.of(context).size.width * 0.15,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/*
//-------------------------------------------------------------------------------------------------------------------------------------------
//                                                           NOTIFICACOES DOS CARROS
//-------------------------------------------------------------------------------------------------------------------------------------------
*/

void adicionarCErro(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Dados Inseridos Vazios ou Incorretos',
        textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.185),
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void adicionarImagemFalta(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content:
        const Text('Imagem do Veículo em Falta', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.185),
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
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
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.185),
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void deleteCarroSucesso(BuildContext context){
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Carro Eliminado', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.185),
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void procuraErro(BuildContext context){
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Matrícula Inválida ou Enixistente', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.185),
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

//-------------------------------------------------------------------------------------------------------------------------------------------
//                                                           NOTIFICACOES DA CONTA
//-------------------------------------------------------------------------------------------------------------------------------------------

void msgVazia(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Mensagem vazia', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.85,
      left: MediaQuery.of(context).size.width * 0.15,
      right: MediaQuery.of(context).size.width * 0.15,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void categoriaVazia(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: const Text('Categoria não foi escolhida', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.85,
      left: MediaQuery.of(context).size.width * 0.15,
      right: MediaQuery.of(context).size.width * 0.15,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void msgEnviada(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content:
        const Text('Mensagem enviada com sucesso', textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.85,
      left: MediaQuery.of(context).size.width * 0.15,
      right: MediaQuery.of(context).size.width * 0.15,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/*
//-------------------------------------------------------------------------------------------------------------------------------------------
//                                                           NOTIFICACOES DO AGENDAR
//-------------------------------------------------------------------------------------------------------------------------------------------
*/

void processoEfetuado(BuildContext context,String processo) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: Text(processo == "Aluguer" ? '$processo efetuado' : '$processo efetuada',
        textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.185),
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
void remocaoEfetuada(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: Text('Remoção efetuada',
        textAlign: TextAlign.center),
    duration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.1),
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}