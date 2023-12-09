import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:houdina/Inicial/Verificar.dart';

import '../Main.dart';
import 'Carros.dart';
import '../Notificacoes.dart';
import 'opcoes.dart';


String? userid = FirebaseAuth.instance.currentUser?.uid;
String? email_user = FirebaseAuth.instance.currentUser?.email;
String nome = '';

class Account extends StatefulWidget {
  const Account({super.key});
  
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {


  @override
  void initState() {
    super.initState();
    nomeUser2();
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
      home: ScaffoldMessenger(
        child: Builder(builder: (contextAccount){
          return Scaffold(
            body: Stack(
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
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                      "Account",
                      style: TextStyle(
                        color: Color.fromRGBO(25, 95, 255, 1.0),
                        decoration: TextDecoration.none,
                      ),
                      ),
                    ), 
                  ),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.15,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(25, 95, 255, 1.0),
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                      "imagem",
                      style: TextStyle(
                        color: Color.fromRGBO(25, 95, 255, 1.0),
                        decoration: TextDecoration.none,
                      ),
                      ),
                    ), 
                  ),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.50,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(25, 95, 255, 1.0),
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: TextButton(
                        child: const Text(
                          "butao testes",
                          style: TextStyle(
                            color: Color.fromRGBO(25, 95, 255, 1.0),
                            //decoration: TextDecoration.none,
                          ),
                        ),
                        onPressed: (){
                          print("ola");
                          msgVazia(contextAccount);
                        },
                      ),
                    ), 
                  ),
                ),
              ),

              /*Positioned(
                top: MediaQuery.of(context).size.height * 0.58,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  height: MediaQuery.of(context).size.height * 0.10,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(25, 95, 255, 1.0),
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "account options",//dsfffffffffffffffffffffffffffffffffffffffffffffffffffff
                      style: TextStyle(
                        color: Color.fromRGBO(25, 95, 255, 1.0),
                        decoration: TextDecoration.none,
                      ),
                      ),
                    ), 
                  ),
                ),
              ),*/


              Positioned(
                top: MediaQuery.of(context).size.height * 0.62,
                  child: TextButton(
                    child: Text("Opcoes conta",
                    style: TextStyle(fontSize: 30, color: Colors.white),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => opcoes()),);
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(25, 95, 255, 1.0) )),
                  ),
                ),



            
            Positioned(
                top: MediaQuery.of(context).size.height * 0.73,
                  child: TextButton(
                    child: Text("Apoio tecnico",
                    style: TextStyle(fontSize: 30, color: Colors.white),),
                    onPressed: () {
                      print("nome user: $nome -- email user: $email_user -- iduser: $userid");
                      showDialog(
                        context: contextAccount,
                        builder: (contextAccount) {
                          return FeedbackDialog();
                        },
                      );    
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(25, 95, 255, 1.0) )),
                  ),
                ),
            
              

              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.01,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
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
                            icon: Icon(Icons.car_crash,
                              size: MediaQuery.of(context).size.height * 0.05,
                              color: const Color.fromRGBO(25, 95, 255, 1.0),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Carros()));
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
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
                            icon: Icon(Icons.punch_clock,
                              size: MediaQuery.of(context).size.height * 0.05,
                              color: const Color.fromRGBO(25, 95, 255, 1.0),
                            ),
                            onPressed: () {
                            },
                          ),
                        ),
                      ),
                    ),
                    //Botão Central -> LOGO
                    IconButton(
                      icon: Image.asset(
                        'resources/Logo.png',
                        width: MediaQuery.of(context).size.height * 0.1,
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      onPressed: null
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                            icon: Icon(Icons.gps_fixed,
                              size: MediaQuery.of(context).size.height * 0.05,
                              color: const Color.fromRGBO(25, 95, 255, 1.0),
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
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(25, 95, 255, 1.0),
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.exit_to_app,
                              size: MediaQuery.of(context).size.height * 0.05,
                              color: const Color.fromRGBO(25, 95, 255, 1.0),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    )
    )
    );
  }
}



//Envia sempre os três dados, caso n mude algum envia os já existentes
Future<void> updateProfile(String newEmail, String newPassword, String newUsername) async {
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
  try{
    await FirebaseFirestore.instance
        .collection('feedback')
        .doc()
        .set({
          'id_user': FirebaseAuth.instance.currentUser?.uid.toString(),
          'mensagem': mensagem,
          'categoria': categoria
        // Add other user data as needed
        });
  }catch(e){
    print("erro a enviar feedback");
  }
}



void nomeUser2() async {
  DocumentSnapshot verNome2 = await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .get();

      print(verNome2['Username'].toString());
      print("OLAAA");
      nome = verNome2['Username'];
}




class FeedbackDialog extends StatefulWidget {
  @override
  _FeedbackDialogState createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  String? selectedValue;
  final TextEditingController mensagemController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(25, 95, 255, 0.7),
      scrollable: true,
      content: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Form(
          child: Column(
            children: [
              Theme(
               data: Theme.of(context).copyWith(
                canvasColor:const Color.fromRGBO(25, 95, 255, 1),
               ),
               child: DropdownButton(
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  style: const TextStyle(color: Colors.green),
                  hint: const Text("categoria", style: TextStyle(color: Colors.white, fontSize: 17)),
                  value: selectedValue,
                  items: const [
                    DropdownMenuItem(
                      value: '0',
                      child: Text("opcao 1", style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                    DropdownMenuItem(
                      value: '1',
                      child: Text("opcao 2", style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                    DropdownMenuItem(
                      value: '2',
                      child: Text("opcao 3", style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  underline: Container(height: 1,color: Colors.white,),
                ),
              ),
              TextFormField(
                maxLines: null,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: "Message",
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
                  "Submit",
                  style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0)),
                ),
                onPressed: () {
                  String mensagem = mensagemController.text;
                  if (mensagemController.text == '') {
                    print("mensagem vazia");
                    msgVazia(context);
                    Navigator.pop(context);
                  } else if (selectedValue == null) {
                    print("value vazio");
                    Navigator.pop(context);
                    categoriaVazia(context);
                  } else {
                    enviarFeedback(mensagem, selectedValue.toString());
                    mensagemController.text = '';
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}