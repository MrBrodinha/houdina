import 'package:cloud_firestore/cloud_firestore.dart';

class Carro{
  final String ano;
  final String kilometragem;
  final String marcamodelo;
  final int imagemID;

  Carro({
    required this.ano,
    required this.kilometragem,
    required this.marcamodelo,
    required this.imagemID,
  });
}

//----------OBTER CARROS DE UM CERTO UTILIZADOR----------
Future<List<Carro>> obterCarrosUser(String userID) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Carros')
        .where('UserID', isEqualTo: userID)
        .get();

    List<Carro> carrosUtilizador = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Carro(
        ano: data['Ano'] as String? ?? "",
        kilometragem: data['Kilometragem'] as String? ?? "",
        marcamodelo: data['Modelo/Marca'] as String? ?? "",
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