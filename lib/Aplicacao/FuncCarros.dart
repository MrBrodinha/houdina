import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
Future<int> obterID_Imagem() async {
  DocumentSnapshot carro = await db.collection('Geral').doc('Carros').get();

  if(carro.exists){
    return carro['idImagem'];
  }else{
    return -2;
  }
}
//----------ATUALIZAR O ID NO GERAL----------
void atualizarID_Imagem(int novoID) async {
    db.collection("Geral").doc("Carros").update({
      'idImagem': novoID,
    });
}


//----------OBTER IMAGENS DA FIRESTORAGE----------
Future<Widget> obterImagemCarro(BuildContext context, String imageName) async {
  Image image = Image.asset('');
  await FireStorageService.loadImage(context, imageName).then((value){
    image = Image.network(value.toString());
  });
  return image;
}
class FireStorageService extends ChangeNotifier{
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async{
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}