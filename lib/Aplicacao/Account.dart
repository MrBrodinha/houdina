import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:houdina/Inicial/Verificar.dart';

import '../Main.dart';
import 'Carros.dart';
import '../Notificacoes.dart';
import 'opcoes.dart';




var acs = ActionCodeSettings(
      // URL you want to redirect back to. The domain (www.example.com) for this
      // URL must be whitelisted in the Firebase Console.
      url: 'https://houdina-2194.firebaseapp.com',
      // This must be true
      handleCodeInApp: true,
      iOSBundleId: 'com.company.app',
      // androidPackageName: 'com.example.android',
      // installIfNotAvailable
      // androidInstallApp: true,
      // minimumVersion
      // androidMinimumVersion: '12'
    );
String? userid = FirebaseAuth.instance.currentUser?.uid;
String? email = FirebaseAuth.instance.currentUser?.email;
String nome = '';

class Account extends StatefulWidget {
  const Account({super.key});
  
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  
  final TextEditingController mensagemController = TextEditingController();
  String? selectedValue;
  String opcao = "Select subject";


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
                print(selectedValue);
                print(opcao);
                print("nome user: $nome");
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
                                                DropdownButton(
                                                    hint: Text(
                                                      selectedValue != null ? 'Subject $selectedValue' : 'Select subject2',
                                                      ),
                                                    value: selectedValue,
                                                    items: const [
                                                      DropdownMenuItem(
                                                        child: Text('subject 1'),
                                                        value: '1',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('subject 2'),
                                                        value: '2',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('subject 3'),
                                                        value: '3',
                                                      ),
                                                    ],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        print(selectedValue);
                                                        selectedValue = value as String?;
                                                        print(selectedValue);
                                                        opcao ='Subject $selectedValue';
                                                        print(opcao);
                                                      });
                                                    },
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
                                        Center(child: 
                                          Column(children: [
                                            ElevatedButton(
                                              child: const Text(
                                                "Submit",
                                                style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0))
                                              ),
                                              onPressed: () {
                                                String mensagem = mensagemController.text;
                                                //print(mensagem);
                                                //print(selectedValue);
                                                if(mensagemController.text == ''){
                                                  print("mensagem vaiza");
                                                }else if (selectedValue == null){
                                                  print("value vazio");
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                  sePNCorrespondente(context);
                                                }else{
                                                  enviarFeedback(mensagem, selectedValue.toString());
                                                  mensagemController.text = ''; 
                                                  print(selectedValue);
                                                  setState(() {
                                                    selectedValue = null;
                                                    opcao = "Select subject";
                                                  });
                                                  Navigator.pop(context);
                                                }
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
          bottom: MediaQuery.of(context).size.height * 0.01,
          child: Row(
            children: [
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

Future<void> resetPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    print("Password reset email sent successfully");
  } catch (e) {
    print("Error sending password reset email: $e");
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

      //print("OLAAA");
     // nome = verNome['Username']; 
      print(verNome2['Username'].toString());
      print("OLAAA");
      nome = verNome2['Username'];
}