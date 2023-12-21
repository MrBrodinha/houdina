import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../notificacoes.dart';

final db = FirebaseFirestore.instance;

//---------------------------------
//----------CLASSES CARRO----------
//---------------------------------
class Carro{
  final String ano;
  final String kilometragem;
  final String matricula;
  final int imagemID;

  Carro({
    required this.ano,
    required this.kilometragem,
    required this.matricula,
    required this.imagemID,
  });
}
//Para efeitos de apresentação na Página de Registo de Carros de Utilizador
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
              "Year: ${carro.ano} | Kilometragem: ${carro.kilometragem}",
              style: const TextStyle(color: Colors.white),
            )
          ),
        ]
      )
    );
  }
}




//----------------------------------------
//----------ADICIONAR CARRO A DB----------
//----------------------------------------
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




//----------------------------------------
//----------OBTER OS CARRO DA DB----------
//----------------------------------------
//----------OBTER LISTA DE CARROS DE UM CERTO UTILIZADOR----------
Future<List<Carro>> obterCarrosUser(String userID) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Carros')
        .where('UserID', isEqualTo: userID)
        .get();

    List<Carro> carrosUtilizador = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Carro(
        ano: data['Ano'] as String,
        kilometragem: data['Kilometragem'] as String,
        matricula: data['Matricula'] as String,
        imagemID: data['idImagem'] as int,
      );
    }).toList();

    return carrosUtilizador;
  } catch (e) {
    print("Error fetching car data: $e");
    //LISTA CARROS VAZIO DEVIDO A ERRO
    return [];
  }
}
//----------OBTER CARRO PELA MATRÍCULA----------
Future<Carro?> verCarro(String matricula, String userID) async {
  try {
    QuerySnapshot<Map<String, dynamic>> carro = await FirebaseFirestore.instance
      .collection('Carros')

      .where('Matricula', isEqualTo: matricula)
      .get();

    if (carro.docs.isNotEmpty) {
      Map<String, dynamic> data = carro.docs.first.data();
      return Carro(
        ano: data['Ano'] as String,
        kilometragem: data['Kilometragem'] as String,
        matricula: data['Matricula'] as String,
        imagemID: data['idImagem'] as int,
      );
    } else {
      return null;
    }
  } catch (e) {
    print("Error fetching car data: $e");
    return null;
  }
}




//----------------------------------------
//--------OBTER IMAGENS DOS CARROS--------
//----------------------------------------
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