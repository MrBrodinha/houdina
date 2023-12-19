import 'package:cloud_firestore/cloud_firestore.dart';

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

//----------VERIFICAR CARRO DE USER NA DB----------
Future<List<Carro>> verCarro(String matricula, String userID) async{
  try{
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('Carros')
      .where('Matricula', isEqualTo: matricula)
      .where('UserID', isEqualTo: userID)
      .get();

    List<Carro> carroSearched = querySnapshot.docs.map((doc){
      Map<String, dynamic> data = doc.data();
      return Carro(
        ano: data['Ano'] as String,
        kilometragem: data['Kilometragem'] as String,
        matricula: data['Matricula'] as String,
        imagemID: data['idImagem'] as int,
      );
    }).toList();

    return carroSearched;
  } catch (e) {
    print("Error fetching car data: $e");
    //LISTA CARROS VAZIO DEVIDO A ERRO
    return [];
  }
}
