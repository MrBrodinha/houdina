// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

final db = FirebaseFirestore.instance;

//---------------------------------
//----------CLASSES CARRO----------
//---------------------------------
class Carro {
  final String ano;
  final String kilometragem;
  final String matricula;
  final int imagemID;
  final double precoVenda;
  final double precoAluguer;
  final String modelo;
  final String id;
  final String user;

  Carro({
    required this.ano,
    required this.kilometragem,
    required this.matricula,
    required this.imagemID,
    required this.modelo,
    required this.precoVenda,
    required this.precoAluguer,
    required this.id,
    required this.user,
  });
}

//Para efeitos de apresentação na Página de Registo de Carros de Utilizador
class ElementoCarro extends StatelessWidget {
  final Carro carro;

  const ElementoCarro({super.key, required this.carro});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color.fromRGBO(25, 95, 255, 1.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Text(
                carro.modelo,
                style: const TextStyle(color: Colors.white),
              )),
          FutureBuilder(
              future: obterImagemCarro(context, "carros/${carro.imagemID}"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: snapshot.data,
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container();
              }),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Text(
                "Year: ${carro.ano} | Kilometragem: ${carro.kilometragem}",
                style: const TextStyle(color: Colors.white),
              )),
        ]));
  }
}

//----------------------------------------
//----------OBTER OS CARRO DA DB----------

Future<List<Carro>> obterCarros() async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('CarrosVenda')
        .where('Disponivel', isEqualTo: true)
        .get();

    List<Carro> carros = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();

      return Carro(
        id: doc.id,
        ano: data['Ano'] as String? ?? '',
        kilometragem: data['Kilometragem'] as String? ?? '',
        matricula: data['Matricula'] as String? ?? '',
        imagemID: data['idImagem'] as int? ?? 0,
        precoAluguer: (data['PrecoAluguer'] as num?)?.toDouble() ?? 0.0,
        precoVenda: (data['PrecoVenda'] as num?)?.toDouble() ?? 0.0,
        modelo: data['Modelo'] as String? ?? '',
        user: data['user'] as String? ?? "",
      );
    }).toList();

    return carros;
  } catch (e) {
    //LISTA CARROS VAZIO DEVIDO A ERRO
    return [];
  }
}

//----------OBTER CARRO PELO MODELO----------
Future<List<Carro>> obterCarrosbyModelo(String modelo) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('CarrosVenda')
        .where('Disponivel', isEqualTo: true)
        .get();

    List<Carro> carros = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();

      return Carro(
        id: doc.id,
        ano: data['Ano'] as String? ?? '',
        kilometragem: data['Kilometragem'] as String? ?? '',
        matricula: data['Matricula'] as String? ?? '',
        imagemID: data['idImagem'] as int? ?? 0,
        precoAluguer: (data['PrecoAluguer'] as num?)?.toDouble() ?? 0.0,
        precoVenda: (data['PrecoVenda'] as num?)?.toDouble() ?? 0.0,
        modelo: data['Modelo'] as String? ?? '',
        user: data['user'] as String? ?? "",
      );
    }).toList();
    bool flag = true;
    List<Carro> carrosModelo = [];
    for (int i = 0; i < carros.length; i++) {
      if (carros[i].modelo.toLowerCase().contains(modelo.toLowerCase())) {
        carrosModelo.add(carros[i]);
        flag = false;
      }
    }
    if (flag) {
      return [];
    }
    return carrosModelo;
  } catch (e) {
    //LISTA CARROS VAZIO DEVIDO A ERRO
    return [];
  }
}

Future<List<Carro>> obterCarrosbyUser(String userID) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('CarrosVenda')
        .where('user', isEqualTo: userID)
        .get();

    List<Carro> carros = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();

      return Carro(
        id: doc.id,
        ano: data['Ano'] as String? ?? '',
        kilometragem: data['Kilometragem'] as String? ?? '',
        matricula: data['Matricula'] as String? ?? '',
        imagemID: data['idImagem'] as int? ?? 0,
        precoAluguer: (data['PrecoAluguer'] as num?)?.toDouble() ?? 0.0,
        precoVenda: (data['PrecoVenda'] as num?)?.toDouble() ?? 0.0,
        modelo: data['Modelo'] as String? ?? '',
        user: data['user'] as String? ?? "",
      );
    }).toList();

    return carros;
  } catch (e) {
    //LISTA CARROS VAZIO DEVIDO A ERRO
    return [];
  }
}

//----------------------------------------
//--------OBTER IMAGENS DOS CARROS--------
//----------------------------------------

//----------OBTER O ID DA IMAGEM----------
Future<int> obterID_Imagem() async {
  DocumentSnapshot carro = await db.collection('Geral').doc('Carros').get();
  if (carro.exists) {
    return carro['idImagem'];
  } else {
    return -2;
  }
}

//----------ATUALIZAR O ID NO GERAL----------
Future<bool> atualizarDisponivel(
    String id, bool disponivel, String idUser) async {
  DocumentSnapshot carro = await db.collection('CarrosVenda').doc(id).get();

  if (carro['Disponivel'] == true) {
    await db.collection("CarrosVenda").doc(id).update({
      'Disponivel': disponivel,
      'user': idUser,
    });
    return true;
  } else {
    return false;
  }
}

void remove(String id, bool disponivel, String idUser) {
  db.collection("CarrosVenda").doc(id).update({
    'Disponivel': disponivel,
    'user': idUser,
  });
}

//----------OBTER IMAGENS DA FIRESTORAGE----------
Future<Widget> obterImagemCarro(BuildContext context, String imageName) async {
  Image image = Image.asset('');
  await FireStorageService.loadImage(context, imageName).then((value) {
    image = Image.network(value.toString());
  });
  return image;
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    //Obtém as Imagens apartir do link de Download
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
