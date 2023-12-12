import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Notificacoes.dart';
import '../Classes/Carro.dart';

final db = FirebaseFirestore.instance;

//----------ADICIONAR CARRO A DB----------
void adicionarCarro(BuildContext context, String matricula, String ano, String kilometros, String user, int identificador){
  if(matricula != "" && ano != "" && kilometros != "" && user != "" && identificador != -1){
    db.collection("Carros").add({
      'Ano': ano,
      'Kilometragem': kilometros,
      'Matricula': matricula,
      'UserID': user,
      'idImagem': identificador,
    });
    adicionarCarroSucesso(context);
  }else{
    if(matricula == "" || ano == "" || kilometros == "" || user == ""){
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
    //Obtém as Imagens apartir do link de Download
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}


//----------CLASSE CARRO----------
class ElementoCarro extends StatelessWidget {

  final Carro carro;

  ElementoCarro({required this.carro});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(25, 95, 255, 1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Container(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Text(carro.matricula,
              style: const TextStyle(color: Colors.white),
            )
          ),
          FutureBuilder(
            future: obterImagemCarro(context, "carros/${carro.imagemID}"),
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: snapshot.data,
                  );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: const CircularProgressIndicator(),
                  );
              }
              return Container();
            }
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Text(
              "Year: ${carro.ano}, Kilometragem: ${carro.kilometragem}, ID: ${carro.imagemID}",
              style: const TextStyle(color: Colors.white),
            )
          ),
        ]
      )
    );
  }
}