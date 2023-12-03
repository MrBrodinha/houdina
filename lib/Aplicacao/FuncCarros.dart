import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Notificacoes.dart';

final db = FirebaseFirestore.instance;

void adicionarCarro(BuildContext context, String marcamodelo, String ano, String kilometros, String user){
  if(marcamodelo != "" && ano != "" && kilometros != "" && user != ""){
    db.collection("Carros").add({
    'Ano': ano,
    'Kilometragem': kilometros,
    'Modelo/Marca': marcamodelo,
    'UserID': user,
  });
  }else{
    adicionarCErro(context);
  } 
}