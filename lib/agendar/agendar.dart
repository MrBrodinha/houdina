// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:houdina/agendar/classCarro.dart';
import 'package:firebase_auth/firebase_auth.dart';

import "../Main.dart";
import "Alugados.dart";
import '../Notificacoes.dart';

class Agendar extends StatefulWidget {
  const Agendar({super.key});

  @override
  State<Agendar> createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {
  bool needRefresh = false;
  bool search = false;
  String modelo = "";
  final TextEditingController searchController = TextEditingController();
  String? userID = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
        child: Builder(builder: (context3) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: Stack(alignment: Alignment.center, children: [
                FutureBuilder(
                  future: obterFundo(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        child: snapshot.data,
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('resources/Background.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                //--------------------PARTE DE CIMA (ICON TITULO ICON)--------------------
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.10,
                    child: Row(
                      children: [
                        //ICON ESQUERDO
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                icon: Icon(
                                  Icons.search,
                                  size:
                                      MediaQuery.of(context).size.height * 0.05,
                                  color: const Color.fromRGBO(25, 95, 255, 1.0),
                                ),
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
                                                      labelText:
                                                          "Marca ou modelo:",
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
                                                            25, 95, 255, 1.0))),
                                                onPressed: () async {
                                                  List<Carro> carros = await obterCarrosbyModelo(searchController.text);

                                                  if(carros.isEmpty || searchController.text == ""){
                                                    procuraInvalida(context);
                                                    search=false;
                                                  }else{
                                                    search = true;
                                                  }

                                                  setState(() {
                                                    modelo = searchController.text;
                                                  });
                                                  searchController.text="";
                                                  Navigator.pop(context);
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
                                  "Alugueres & Compras",
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
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                icon: Icon(Icons.shopping_cart,
                                    size: MediaQuery.of(context).size.height *
                                        0.05,
                                    color:
                                        const Color.fromRGBO(25, 95, 255, 1.0)),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).clearSnackBars();
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const Alugado()))
                                      .then((_) => setState(() {}));
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.18,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(25, 95, 255, 0.7),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        search = false;
                        modelo = "";
                      });
                    },
                    child: const Text(
                      "Atualizar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                //--------------------MEIO--------------------
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.24,
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: FutureBuilder<List<Carro>>(
                      future: search ? obterCarrosbyModelo(modelo) : obterCarros(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          List<Carro> carros = snapshot.data!;

                          //APRESENTA TDS OS CARROS
                          return ListView.builder(
                            itemCount: carros.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Handle item click here
                                  // You can perform any other action here
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: const Color.fromRGBO(
                                            25, 95, 255, 0.7),
                                        scrollable: true,
                                        content: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: ListBody(
                                            children: [
                                              Text(
                                                "Ano: ${carros[index].ano}",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "Kilometros: ${carros[index].kilometragem} km",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "Modelo: ${carros[index].modelo}",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Column(children: [
                                                  const Text(
                                                    "Preço Aluguer",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "${carros[index].precoAluguer}",
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    child: const Text("Alugar",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    25,
                                                                    95,
                                                                    255,
                                                                    1.0))),
                                                    onPressed: () async {
                                                      bool flag =
                                                          await atualizarDisponivel(
                                                              carros[index].id,
                                                              false,
                                                              userID!);

                                                      if (flag) {
                                                        setState(() {});
                                                        Navigator.pop(context);
                                                        processoEfetuado(
                                                            context, "Compra");
                                                      } else {
                                                        setState(() {});
                                                        Navigator.pop(context);
                                                        processoEfetuado(
                                                            context,
                                                            "Processo não");
                                                      }
                                                    },
                                                  ),
                                                ]),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Column(children: [
                                                  const Text(
                                                    "Preço Compra",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "${carros[index].precoVenda}",
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    child: const Text("Comprar",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    25,
                                                                    95,
                                                                    255,
                                                                    1.0))),
                                                    onPressed: () async {
                                                      bool flag =
                                                          await atualizarDisponivel(
                                                              carros[index].id,
                                                              false,
                                                              userID!);

                                                      if (flag) {
                                                        setState(() {});
                                                        Navigator.pop(context);
                                                        processoEfetuado(
                                                            context, "Compra");
                                                      } else {
                                                        setState(() {});
                                                        Navigator.pop(context);
                                                        processoEfetuado(
                                                            context,
                                                            "Processo não");
                                                      }
                                                    },
                                                  ),
                                                ]),
                                              ),
                                            ],
                                          ))
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: ElementoCarro(carro: carros[index]),
                              );
                            },
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ]));
        }),
      ),
    );
  }
}
