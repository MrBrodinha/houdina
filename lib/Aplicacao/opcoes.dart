import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:houdina/Aplicacao/Account.dart';
import 'package:houdina/Inicial/Verificar.dart';

import '../Main.dart';
import 'Carros.dart';
import '../Notificacoes.dart';

class opcoes extends StatefulWidget {
  const opcoes({super.key});

  @override
  State<opcoes> createState() => _opcoesState();
}

class _opcoesState extends State<opcoes> {

  final TextEditingController novonomeController = TextEditingController();
  final TextEditingController novoemailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
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

        Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          right: 100,
          child: const Text(
            "Opcoes",
            style: TextStyle(
              color: Color.fromRGBO(25, 95, 255, 1.0),
              decoration: TextDecoration.none,
            ),
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          right: 320,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
              size: MediaQuery.of(context).size.height * 0.05,
              color: const Color.fromRGBO(25, 95, 255, 1.0),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.40,
            child: TextButton(
              child: Text("mudar nome",
              style: TextStyle(fontSize: 30, color: Colors.white),),
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
                              Text("nome atual: $nome"),
                              TextFormField(
                                maxLines: null,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(color: Colors.white),
                                  labelText: "novo nome",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                controller: novonomeController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        Center(child: 
                          Column(children: [
                            ElevatedButton(
                              child: const Text(
                                "Submit",
                                style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0))
                              ),
                              onPressed: () {
                                mudarNome(novonomeController.text);
                                nomeUser2();
                                setState(() {
                                  novonomeController.text = '';
                                });
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
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(25, 95, 255, 1.0) )),
            ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.50,
            child: TextButton(
              child: Text("mudar email",
              style: TextStyle(fontSize: 30, color: Colors.white),),
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
                              Text("email atual: $email"),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(color: Colors.white),
                                  labelText: "novo email",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                controller: novoemailController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        Center(child: 
                          Column(children: [
                            ElevatedButton(
                              child: const Text(
                                "Submit",
                                style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0))
                              ),
                              onPressed: () {
                                mudarEmail(novoemailController.text);
                                setState(() {
                                  novoemailController.text = '';
                                });
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
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(25, 95, 255, 1.0) )),
            ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.60,
            child: TextButton(
              child: Text("mudar passe",
              style: TextStyle(fontSize: 30, color: Colors.white),),
              onPressed: () {

              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(25, 95, 255, 1.0) )),
            ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.70,
            child: TextButton(
              child: Text("mudar imagem",
              style: TextStyle(fontSize: 30, color: Colors.white),),
              onPressed: () {

              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(25, 95, 255, 1.0) )),
            ),
        ),


      ],
    );
  }
}














/*
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
              Text("Nome: $nome2", style: TextStyle(color: Colors.white), ),
              Text("Email: $email", style: TextStyle(color: Colors.white),),
              Text("ola", style: TextStyle(color: Colors.white),),
              ElevatedButton(
                child: Text("Mudar nome", style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0))), 
                onPressed: null,
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(255, 255, 255, 1.0))),
                ),
              ElevatedButton(
                child: Text("Mudar email", style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0))),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(255, 255, 255, 1.0))),
                onPressed: (){
                },                              
                ),
              ElevatedButton(
                child: Text("Mudar passe", style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0))), 
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(255, 255, 255, 1.0))),
                onPressed: () {
                  resetPassword(email.toString());
                }
                ),
            ],
          ),
        ),
      ),
  );
  },
);  
*/

Future<void> mudarNome(String novoNome) async{
    try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'Username': novoNome});

      print("Profile updated successfully");
    }
  } catch (e) {
    print("Error updating profile: $e");
  }
}

Future<void> mudarEmail(String novoEmail) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.updateEmail(novoEmail);
      await user.sendEmailVerification();

      print("Profile updated successfully");
    }
  } catch (e) {
    print("Error updating profile: $e");
  }
}