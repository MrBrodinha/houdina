import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:houdina/agendar/classCarro.dart';

import '../Notificacoes.dart';

class Agendar extends StatefulWidget {
  const Agendar({super.key});

  @override
  State<Agendar> createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {
  bool search = false;
  String modelo = "";
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
              child: Stack(alignment: Alignment.center, children: [
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
                                                onPressed: () {
                                                  print("Premido");

                                                  setState(() {
                                                    search = true;
                                                    modelo =
                                                        searchController.text;
                                                  });
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
                                  "Agendamentos & Compras",
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
                                icon: Icon(Icons.home_repair_service,
                                    size: MediaQuery.of(context).size.height *
                                        0.05,
                                    color:
                                        const Color.fromRGBO(25, 95, 255, 1.0)),
                                onPressed: () {
                                  developer.log('Mecânico');
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
                                                    labelText: "Date:",
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                    ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextFormField(
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  decoration:
                                                      const InputDecoration(
                                                    labelStyle: TextStyle(
                                                        color: Colors.white),
                                                    labelText:
                                                        "Registration Number:",
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                    ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          Center(
                                              child: Column(
                                            children: [
                                              ElevatedButton(
                                                child: const Text("Submit",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            25, 95, 255, 1.0))),
                                                onPressed: () {
                                                  developer.log(
                                                      'Submitting, but not rll');
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
                        ),
                      ],
                    )),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.18,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(25, 95, 255, 0.7),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        search = false;
                        modelo = "";
                      });
                    },
                    child: Text(
                      "Limpar Filtros",
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
                      future:
                          search ? obterCarrosbyModelo(modelo) : obterCarros(),
                      builder: (context, snapshot) {
                        print('init State');
                        if (snapshot.connectionState == ConnectionState.done) {
                          print('Connection established');
                          List<Carro> carros = snapshot.data!;

                          //APRESENTA TDS OS CARROS
                          return ListView.builder(
                            itemCount: carros.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Handle item click here
                                  print('Item clicked: ${index}');
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
                                                padding: EdgeInsets.all(10),
                                                child: Column(children: [
                                                  Text(
                                                    "Preço Aluguer",
                                                    style: const TextStyle(
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
                                                    onPressed: () {
                                                      developer.log('Alugar');
                                                      atualizarDisponivel(
                                                          carros[index].id,
                                                          false);
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ]),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Column(children: [
                                                  Text(
                                                    "Preço Compra",
                                                    style: const TextStyle(
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
                                                    onPressed: () {
                                                      developer.log('Compra');
                                                      atualizarDisponivel(
                                                          carros[index].id,
                                                          false);
                                                      setState(() {});
                                                      Navigator.pop(context);
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
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: const CircularProgressIndicator(),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ]),
            ),
          );
        })));
  }
}
