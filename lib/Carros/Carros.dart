import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'classeCarro.dart';
import '../Notificacoes.dart';

class Carros extends StatefulWidget {
  const Carros({super.key});
  @override
  State<Carros> createState() => _CarrosState();
}

class _CarrosState extends State<Carros> {
  //Variáveis Relativas às Imagens
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? urDownload;

  //Variáveis Relativas à introdução de Carros na Database
  final TextEditingController matriculaController = TextEditingController();
  final TextEditingController anoController = TextEditingController();
  final TextEditingController kilometragemController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  String? userID = FirebaseAuth.instance.currentUser?.uid;

  //Variáveis Relativas à Procura de Carro por Matrícula
  bool search = false;
  Carro? carroprocurado;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScaffoldMessenger(child: Builder(builder: (context3) {
          return Scaffold(
            body: Container(
                //Estrutura Principal -> Wallpaper
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://wallpapercave.com/wp/wp10671634.jpg'),
                    //Para preencher a tela toda
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    //--------------------PARTE DE CIMA (ICON TITULO ICON)--------------------
                    Positioned(
                        //Posicionado de maneira a evitar cortar as mensagens dos SnackBars
                        top: MediaQuery.of(context).size.height * 0.10,
                        child: Row(
                          children: [
                            //ICON ESQUERDO
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromRGBO(25, 95, 255, 1.0),
                                  width: 3.0,
                                ),
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    size: MediaQuery.of(context).size.height *
                                        0.05,
                                    color:
                                        const Color.fromRGBO(25, 95, 255, 1.0),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    25, 95, 255, 0.7),
                                            scrollable: true,
                                            content: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Form(
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      decoration:
                                                          const InputDecoration(
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        labelText: "Matrícula:",
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      controller:
                                                          searchController,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              Center(
                                                child: ElevatedButton(
                                                  child: const Text("Submeter",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              25,
                                                              95,
                                                              255,
                                                              1.0))),
                                                  onPressed: () async {
                                                    String matricula =
                                                        searchController.text;
                                                    //Função Que dá return ao carro com a matricula dada
                                                    carroprocurado = await verCarro(matricula, userID!);

                                                    //Caso encontre um carro com essa matrícula sai do Dialog com search = true
                                                    if (carroprocurado != null) {
                                                      setState(() {
                                                        search = true;
                                                      });
                                                      searchController.text = "";
                                                      Navigator.pop(context);
                                                    } else {
                                                      setState(() {
                                                        search = false;
                                                      });
                                                      searchController.text = "";
                                                      procuraErro(context);
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                ),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                ),
                              ),
                            ),

                            //LETREIRO
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.60,
                              height: MediaQuery.of(context).size.height * 0.10,
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "Carros",
                                    style: TextStyle(
                                      color: Color.fromRGBO(25, 95, 255, 1.0),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //ICON DA DIREITA
                            Container(
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
                                      size: MediaQuery.of(context).size.height *
                                          0.05,
                                      color: const Color.fromRGBO(
                                          25, 95, 255, 1.0)),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: const Color.fromRGBO(
                                              25, 95, 255, 0.7),
                                          scrollable: true,
                                          content: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Form(
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    decoration:
                                                        const InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: Colors.white),
                                                      labelText: "Matrícula:",
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    controller:
                                                        matriculaController,
                                                  ),
                                                  TextFormField(
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    decoration:
                                                        const InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: Colors.white),
                                                      labelText:
                                                          "Ano:",
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    controller: anoController,
                                                  ),
                                                  TextFormField(
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    decoration:
                                                        const InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: Colors.white),
                                                      labelText: "Kilometragem:",
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    controller:
                                                        kilometragemController,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            Center(
                                                child: Column(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 10),
                                                  child: Text("Imagem do Carro: ",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                                ElevatedButton(
                                                  child: const Text(
                                                    "Procurar Imagem",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            25, 95, 255, 1.0)),
                                                  ),
                                                  onPressed: () {
                                                    selectFile();
                                                  },
                                                ),
                                                ElevatedButton(
                                                  child: const Text("Submeter",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              25,
                                                              95,
                                                              255,
                                                              1.0))),
                                                  onPressed: () async {
                                                    String matricula =
                                                        matriculaController
                                                            .text;
                                                    String ano =
                                                        anoController.text;
                                                    String kilometragem =
                                                        kilometragemController
                                                            .text;

                                                    //Vai buscar o ID do geral
                                                    int identificador =
                                                        await obterID_Imagem();
                                                    //Nome da Imagem será o ID
                                                    uploadFile(identificador);
                                                    //Caso ver seja -1 -> ERRO
                                                    int ver;
                                                    if (pickedFile != null) {
                                                      ver = identificador;
                                                      //FOTO FICA COM IDENTIFICADOR E SOMA MAIS UM PARA USAR NA PROX
                                                      identificador += 1;
                                                      atualizarID_Imagem(
                                                          identificador);
                                                    } else {
                                                      //ERRO OU FILE VAZIO
                                                      ver = -1;
                                                    }

                                                    adicionarCarro(context3, matricula, ano, kilometragem, userID!, ver);

                                                    matriculaController.text = "";
                                                    anoController.text = "";
                                                    kilometragemController.text = "";
                                                    pickedFile = null;

                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),

                    //--------------------MEIO--------------------
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.21,
                      height: MediaQuery.of(context).size.height * 0.71,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: FutureBuilder<List<Carro>>(
                          future: obterCarrosUser(userID!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done){
                              List<Carro> carrosUser = snapshot.data!;
                              //APRESENTA TDS OS CARROS
                              if (search == false) {
                                return ListView.builder(
                                  itemCount: carrosUser.length,
                                  itemBuilder: (context, index) {
                                    return ElementoCarro(
                                      carro: carrosUser[index], 
                                      eliminar: (bool isDeleted){
                                        if (isDeleted) {
                                          setState((){});
                                        }
                                    },);
                                  },
                                );
                              } else {
                                // Caso tenha Filtrado
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      child: const Text(
                                        "Limpar Filtro",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                25, 95, 255, 1.0)),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          search = false;
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          return ElementoCarro(
                                            carro: carroprocurado!, 
                                            eliminar: (bool isDeleted){
                                              if (isDeleted) {
                                                setState((){});
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const SizedBox(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          );
        })));
  }

  //FUNÇÃO DE SELEÇÃO DAS IMAGENS
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  //FUNÇÃO DE UPLOAD DAS IMAGENS
  Future uploadFile(int identificador) async {
    final path = 'carros/$identificador';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    urDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      uploadTask == null;
    });
  }
}
