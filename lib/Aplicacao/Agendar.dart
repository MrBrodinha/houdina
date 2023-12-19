import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

class Agendar extends StatefulWidget {
  const Agendar({super.key});

  @override
  State<Agendar> createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {
  @override
  void initState() {
    super.initState();
  }

  //para dar sign out
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      //print("User signed out successfully");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
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
                    color: const Color.fromRGBO(25, 95, 255, 1.0)),
                onPressed: () => {developer.log('Button Click')},
              ),
            ),
          ),
        ),

        //Wallpaper
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:
                  NetworkImage('https://wallpapercave.com/wp/wp10671634.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

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
                        icon: Icon(
                          Icons.search,
                          size: MediaQuery.of(context).size.height * 0.05,
                          color: const Color.fromRGBO(25, 95, 255, 1.0),
                        ),
                        onPressed: () {},
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
                        icon: Icon(Icons.home_repair_service,
                            size: MediaQuery.of(context).size.height * 0.05,
                            color: const Color.fromRGBO(25, 95, 255, 1.0)),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    const Color.fromRGBO(25, 95, 255, 0.7),
                                scrollable: true,
                                content: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Form(
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            labelText: "Date:",
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            labelText: "Registration Number:",
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
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
                                        onPressed: null,
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
      ],
    );
  }
}
