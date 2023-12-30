import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../notificacoes.dart';
import 'opcoes.dart';


String? userid = FirebaseAuth.instance.currentUser?.uid;
String? email_user = FirebaseAuth.instance.currentUser?.email;
int ola = 0;

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late Future<Widget> imageFuture;

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        home: ScaffoldMessenger(child: Builder(builder: (contextAccount) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                //Wallpaper
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://wallpapercave.com/wp/wp10671634.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: FutureBuilder(
                          future: nomeUser(1), 
                          builder: (context, snapshot){
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Container(
                                  //padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: snapshot.data,
                                );
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.1,
                                  height: MediaQuery.of(context).size.height * 0.1,
                                  child: const CircularProgressIndicator(),
                                );
                            }
                            return Container();
                            /*if (snapshot.connectionState == ConnectionState.done) {
                                  return snapshot.data as Widget;
                                } else {
                                  return CircularProgressIndicator();
                                }*/
                          },
                        ),
                      ),
                    ),
                  ),
                ),

            Positioned(
              top: MediaQuery.of(context).size.height * 0.13,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                height: MediaQuery.of(context).size.height * 0.25,
                /*decoration: BoxDecoration( //BORDA NAO APAGAR PODE DAR JEITO
                  border: Border.all(
                    color: const Color.fromRGBO(25, 95, 255, 1.0),
                    width: 4.0,
                  ),
                  borderRadius: BorderRadius.circular(35),
                ),*/
                child: FutureBuilder(
                  future: obterImagemperfil(context, "fotosPFP/${FirebaseAuth.instance.currentUser?.uid}"),
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                          //padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: snapshot.data,
                        );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: const CircularProgressIndicator(),
                        );
                    }
                    return Container();
                    /*if (snapshot.connectionState == ConnectionState.done) {
                          return snapshot.data as Widget;
                        } else {
                          return CircularProgressIndicator();
                        }*/
                  },
                ),
              ),
            ),

          Positioned(
          top: MediaQuery.of(context).size.height * 0.62,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.height * 0.085,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(25, 95, 255, 1.0),
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(35),
            ),
            child: FittedBox(
                fit: BoxFit.contain,
                child: TextButton(
                  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => opcoes()),
                      ).then((value) => {setState((){})});
                    },
                  child: const Text(
                    "Opções da conta",
                  style: TextStyle(
                    color: Color.fromRGBO(25, 95, 255, 1.0),
                    decoration: TextDecoration.none,
                    fontSize: 30
                  ),
                  ),
              ),
              ), 
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.73,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.height * 0.085,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(25, 95, 255, 1.0),
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(35),
            ),
            child: FittedBox(
                fit: BoxFit.contain,
                child: TextButton(
                  onPressed: () {
                    print("nome user: esquece -- email user: $email_user -- iduser: $userid ${FirebaseAuth.instance.currentUser?.uid}");
                    showDialog(
                      context: contextAccount,
                      builder: (contextAccount) {
                        return FeedbackDialog();
                      },
                    ).then((value) => {
                        if (ola == 1)
                          {msgVazia(contextAccount), ola = 0}
                        else if (ola == 2)
                          {categoriaVazia(contextAccount), ola = 0}
                        else if (ola == 3)
                          {msgEnviada(contextAccount), ola = 0}
                      });
                  },
                  child: const Text(
                    "Apoio técnico",
                  style: TextStyle(
                    color: Color.fromRGBO(25, 95, 255, 1.0),
                    decoration: TextDecoration.none,
                    fontSize: 30
                  ),
                  ),
              ),
              ), 
          ),
        ),

                /*Positioned(
                  top: MediaQuery.of(context).size.height * 0.62,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => opcoes()),
                      ).then((value) => {setState((){})});
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(25, 95, 255, 1.0))),
                    child: const Text(
                      "Opcoes conta",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),*/

                /*Positioned(
                  top: MediaQuery.of(context).size.height * 0.73,
                  child: TextButton(
                    onPressed: () {
                      print(
                          "nome user: esquece -- email user: $email_user -- iduser: $userid ${FirebaseAuth.instance.currentUser?.uid}");
                      showDialog(
                        context: contextAccount,
                        builder: (contextAccount) {
                          return FeedbackDialog();
                        },
                      ).then((value) => {
                            if (ola == 1)
                              {msgVazia(contextAccount), ola = 0}
                            else if (ola == 2)
                              {categoriaVazia(contextAccount), ola = 0}
                            else if (ola == 3)
                              {msgEnviada(contextAccount), ola = 0}
                          });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(25, 95, 255, 1.0))),
                    child: const Text(
                      "Apoio tecnico",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),*/
              ],
            ),
          );
        })));
  }
}

//Envia sempre os três dados, caso n mude algum envia os já existentes
Future<void> updateProfile(
    String newEmail, String newPassword, String newUsername) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Update email and password in Firebase Authentication
      await user.updateEmail(newEmail);
      await user.updatePassword(newPassword);

      // Update username in Firestore (adjust the collection and field names accordingly)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'username': newUsername});

      //print("Profile updated successfully");
    }
  } catch (e) {
    print("Error updating profile: $e");
    // Handle the error accordingly
  }
}

Future<void> enviarFeedback(String mensagem, String categoria) async {
  try {
    await FirebaseFirestore.instance.collection('feedback').doc().set({
      'id_user': FirebaseAuth.instance.currentUser?.uid.toString(),
      'mensagem': mensagem,
      'categoria': categoria
      // Add other user data as needed
    });
  } catch (e) {
    print("erro a enviar feedback");
  }
}

Future<Widget> nomeUser(int valor) async{
  Text texto = Text("Erro a dar load ao nome");
  try{
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) =>{
      if(valor == 1){
      texto = Text(value['Username'], 
                  style: const TextStyle(
                    color: Color.fromRGBO(25, 95, 255, 1.0),
                    decoration: TextDecoration.none,
                  ),)
      }else{
              texto = Text("Nome atual: ${value['Username']}", 
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    decoration: TextDecoration.none,
                    fontSize: 16
                  ),)
      }
      
    });
  }catch(e){
    print("erro a dar load ao nome");
    return texto;
  }
  return texto;
}

class FeedbackDialog extends StatefulWidget {
  @override
  _FeedbackDialogState createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  String? selectedValue;
  final TextEditingController mensagemController = TextEditingController();

  @override
  Widget build(contextAccount) {
    //return MaterialApp(
    //home: ScaffoldMessenger(
    //child: Builder(builder: (context2){
    //return Scaffold(*/
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(25, 95, 255, 0.7),
      scrollable: true,
      content: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Form(
          child: Column(
            children: [
              Theme(
                data: Theme.of(contextAccount).copyWith(
                  canvasColor: const Color.fromRGBO(25, 95, 255, 1),
                ),
                child: DropdownButton(
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  style: const TextStyle(color: Colors.green),
                  hint: const Text("Categoria",
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  value: selectedValue,
                  items: const [
                    DropdownMenuItem(
                      value: '0',
                      child: Text("Comunicar Erro",
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                    DropdownMenuItem(
                      value: '1',
                      child: Text("Ajuda",
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                    DropdownMenuItem(
                      value: '2',
                      child: Text("Reportar anomalia",
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                    DropdownMenuItem(
                      value: '3',
                      child: Text("Outra",
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  underline: Container(
                    height: 1,
                    color: Colors.white,
                  ),
                ),
              ),
              TextFormField(
                maxLines: null,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: "Mensagem",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: mensagemController,
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
                child: const Text(
                  "Enviar",
                  style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0)),
                ),
                onPressed: () {
                  String mensagem = mensagemController.text;
                  if (mensagemController.text == '') {
                    // ignore: avoid_print
                    print("Mensagem vaiza");
                    ola = 1;
                    Navigator.pop(contextAccount);
                    //msgVazia(contextAccount);
                  } else if (selectedValue == null) {
                    // ignore: avoid_print
                    print("Categoria nao escolhida");
                    ola = 2;
                    Navigator.pop(contextAccount);
                    //categoriaVazia(contextAccount);
                  } else {
                    enviarFeedback(mensagem, selectedValue.toString());
                    mensagemController.text = '';
                    ola = 3;
                    Navigator.pop(contextAccount);
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
    /*);
         }
         )
         )
           );*/
  }
}
