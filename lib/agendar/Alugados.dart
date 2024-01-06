import 'package:flutter/material.dart';
import 'package:houdina/agendar/classCarro.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Notificacoes.dart';
import "../Main.dart";

class Alugado extends StatefulWidget {
  const Alugado({super.key});

  @override
  State<Alugado> createState() => _AlugadosState();
}

class _AlugadosState extends State<Alugado> {
  String? userID = FirebaseAuth.instance.currentUser?.uid;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScaffoldMessenger(child: Builder(builder: (contextAlugado) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              alignment: Alignment.center,
              children: [
                FutureBuilder(
                  future: obterFundo(context),
                  builder: (context, snapshot){
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
                                  Icons.arrow_back,
                                  size:
                                      MediaQuery.of(context).size.height * 0.05,
                                  color: const Color.fromRGBO(25, 95, 255, 1.0),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ),
                        //LETREIRO
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.80,
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  "Os Meus Alugueres & Compras",
                                  style: TextStyle(
                                    color: Color.fromRGBO(25, 95, 255, 1.0),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                //--------------------MEIO--------------------
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.24,
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: FutureBuilder<List<Carro>>(
                      future: obterCarrosbyUser(userID!),
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
                                            child: ElevatedButton(
                                              child: const Text("Remover",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          25, 95, 255, 1.0))),
                                              onPressed: () {
                                                
                                                atualizarDisponivel(
                                                    carros[index].id,
                                                    true,
                                                    "None");
                                                setState(() {});
                                                
                                                remocaoEfetuada(contextAlugado);
                                                
                                                Navigator.pop(context);
                                              },
                                            ),
                                          )
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
                          return const Center(child: CircularProgressIndicator());
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ]),
            );
          })));
        }
  }

