import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:houdina/Aplicacao/Account.dart';
import 'package:houdina/Inicial/Verificar.dart';

import '../Main.dart';
import '../Carros/Carros.dart';
import '../Notificacoes.dart';

class opcoes extends StatefulWidget {
  const opcoes({super.key});

  @override
  State<opcoes> createState() => _opcoesState();
}

class _opcoesState extends State<opcoes> {

  final TextEditingController novonomeController = TextEditingController();
  final TextEditingController novoemailController = TextEditingController();
  final TextEditingController novapasseController = TextEditingController();

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
                                mudar(novonomeController.text, 1);
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
                              Text("email atual: $email_user"),
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
                                mudar(novoemailController.text, 2);
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromRGBO(25, 95, 255, 0.7),
                      scrollable: true,
                      content: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Form(
                          child: Text("clica pra mandar mail pra mudar passe"),
                        ),
                      ),
                      actions: [
                        Center(child: 
                          Column(children: [
                            ElevatedButton(
                              child: const Text(
                                "Send",
                                style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0))
                              ),
                              onPressed: () {
                                mudar("ok", 3);
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

// Funcao para dar update aos dados da bd. 1 mudar nome, 2 mudar email, 3 mudar passe
Future<void> mudar(String mudanca,int tipo) async{
  if(tipo == 1){
    try {
      User? user1 = FirebaseAuth.instance.currentUser;

      if (user1 != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user1.uid)
            .update({'Username': mudanca});

        print("Name updated successfully");
      }
    } catch (e) {
      print("Error updating name: $e");
    }
  }else if(tipo ==2){

    //alterar email

  }else if(tipo == 3){
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email_user.toString());
      print("Password reset email sent successfully");
    } catch (e) {
      print("Error sending password reset email: $e");
    }
  }else{
    //alterar imagem se metermos imagem
  }
}