import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Notificacoes.dart';

final db = FirebaseFirestore.instance;

void adicionarCarro(BuildContext context, String marcamodelo, String ano, String kilometros, String user, int identificador){
  if(marcamodelo != "" && ano != "" && kilometros != "" && user != "" && identificador != -1){
    db.collection("Carros").add({
      'Ano': ano,
      'Kilometragem': kilometros,
      'Modelo/Marca': marcamodelo,
      'UserID': user,
      'idImagem': identificador,
    });
    adicionarCarroSucesso(context);
  }else{
    if(marcamodelo == "" || ano == "" || kilometros == "" || user == ""){
      adicionarCErro(context);
    }else{
      adicionarImagemFalta(context);
    }
  } 
}

//----------OBTER O ID DA IMAGEM----------
Future<int> obterImagem() async {
  DocumentSnapshot carro = await db.collection('Geral')
    .doc('Carros')
    .get();

  if(carro.exists){
    return carro['idImagem'];
  }else{
    return -2;
  }
}

//----------ATUALIZAR O ID NO GERAL----------
void atualizarImagemID(int novoID) async {
    db.collection("Geral").doc("Carros").update({
      'idImagem': novoID,
    });
}
