import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Notificacoes.dart';

final db = FirebaseFirestore.instance;

void adicionarCarro(BuildContext context, String marcamodelo, String ano, String kilometros, String user, String filename){
  if(marcamodelo != "" && ano != "" && kilometros != "" && user != "" && filename != ""){
    db.collection("Carros").add({
    'Ano': ano,
    'Kilometragem': kilometros,
    'Modelo/Marca': marcamodelo,
    'UserID': user,
    'Imagem': filename,
    });
    adicionarCarroSucesso(context);
  }else{
    if(marcamodelo == "" || ano == "" || kilometros == "" || user == ""){
      adicionarCErro(context);
    }else{
      adicionarCDRFalta(context);
    }
  } 
}