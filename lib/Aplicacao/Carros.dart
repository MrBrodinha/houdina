import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Account.dart';
import 'Default.dart';
import 'FuncCarros.dart';

class Carros extends StatefulWidget{
  const Carros({super.key});
  @override
  State<Carros> createState() => _CarrosState();
}

class _CarrosState extends State<Carros> {

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? urDownload;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if(result == null) return;

    setState((){
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async{
    final path = 'carros/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    
    setState((){
      uploadTask = ref.putFile(file);
    });
    
    final snapshot = await uploadTask!.whenComplete((){});
    urDownload = await snapshot.ref.getDownloadURL();

    setState((){
      uploadTask == null;
    });
  }

  final TextEditingController marcamodeloController = TextEditingController();
  final TextEditingController anoController = TextEditingController();
  final TextEditingController kilometragemController = TextEditingController();

	@override
	Widget build(BuildContext context) {
    return MaterialApp(
      home: ScaffoldMessenger(
        child: Builder(builder: (context3){
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://wallpapercave.com/wp/wp10671634.jpg'),
                  //Para preencher a tela toda
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [

                  //--------------------PARTE DE CIMA (ICON TITULO ICON)--------------------
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.10,
                    child: Row(
                      children: [
                        //ICON ESQUERDO
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromRGBO(25, 95, 255, 1.0),
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.search,
                                  size: MediaQuery.of(context).size.height * 0.05,
                                  color: const Color.fromRGBO(25, 95, 255, 1.0),
                                ),
                                onPressed: () {
                                },
                              ),
                            ),
                          ),
                        ),
                        //LETREIRO
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                "Vehicles",
                                style: TextStyle(
                                  color: Color.fromRGBO(25, 95, 255, 1.0),
                                  decoration: TextDecoration.none,
                                ),
                                ),
                              ), 
                            ),
                          ),
                        ),
                        //ICON DA DIREITA
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromRGBO(25, 95, 255, 1.0),
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.plus_one_outlined,
                                  size: MediaQuery.of(context).size.height * 0.05,
                                  color: const Color.fromRGBO(25, 95, 255, 1.0)
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: const Color.fromRGBO(25, 95, 255, 0.7),
                                        scrollable: true,
                                        content: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Form(
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  style: const TextStyle(color: Colors.white),
                                                  decoration: const InputDecoration(
                                                    labelStyle: TextStyle(color: Colors.white),
                                                    labelText: "Brand Name &/or Model:",
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.white),
                                                    ),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  controller: marcamodeloController,
                                                ),
                                                TextFormField(
                                                  style: const TextStyle(color: Colors.white),
                                                  decoration: const InputDecoration(
                                                    labelStyle: TextStyle(color: Colors.white),
                                                    labelText: "Year of the Car:",
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.white),
                                                    ),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  controller: anoController,
                                                ),
                                                TextFormField(
                                                  style: const TextStyle(color: Colors.white),
                                                  decoration: const InputDecoration(
                                                    labelStyle: TextStyle(color: Colors.white),
                                                    labelText: "Mileage:",
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.white),
                                                    ),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  controller: kilometragemController,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      actions: [
                                        Center(child: 
                                          Column(children: [
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                              child: Text(
                                                "Car Registration Documents: ",
                                                style: TextStyle(fontSize: 15, color: Colors.white)
                                              ),
                                            ),
                                            ElevatedButton(
                                              child: const Text(
                                                "Attach Files",
                                                style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0)),
                                              ),
                                              onPressed: () {
                                                selectFile();
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text(
                                                "Submit",
                                                style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0))
                                              ),
                                              onPressed: () {

                                                String marcamodelo = marcamodeloController.text;
                                                String ano = anoController.text;
                                                String kilometragem = kilometragemController.text;
                                                String? userID = FirebaseAuth.instance.currentUser?.uid;

                                                uploadFile();

                                                String imagem;
                                                if (pickedFile != null) {
                                                  imagem = pickedFile!.name;
                                                }else{
                                                  imagem = "";
                                                }

                                                adicionarCarro(context3, marcamodelo, ano, kilometragem, userID!, imagem);

                                                marcamodeloController.text = "";
                                                anoController.text = "";
                                                kilometragemController.text = "";

                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],)
                                        )
                                      ],
                                    );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),

                  

                  //--------------------PARTE DE BAIXO (ICON ICON LOGO ICON ICON)--------------------
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(25, 95, 255, 1.0),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.car_crash,
                                  size: MediaQuery.of(context).size.height * 0.05,
                                  color: Colors.white
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Carros()),);
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(25, 95, 255, 1.0),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.punch_clock,
                                  size: MediaQuery.of(context).size.height * 0.05,
                                  color: Colors.white
                                ),
                                onPressed: () {
                                },
                              ),
                            ),
                          ),
                        ),
                        //Botão Central -> LOGO
                        IconButton(
                          icon: Image.asset('resources/Logo.png', 
                            width: MediaQuery.of(context).size.height * 0.1,
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Default()),);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape:  BoxShape.circle,
                              color: Color.fromRGBO(25, 95, 255, 1.0),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.gps_fixed,
                                  size: MediaQuery.of(context).size.height * 0.05,
                                  color: Colors.white
                                ),
                                onPressed: () {
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(25, 95, 255, 1.0),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.person,
                                  size: MediaQuery.of(context).size.height * 0.05,
                                  color: Colors.white
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Account()),);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            )
          );
          }
        )
      )
    );
  }
}
