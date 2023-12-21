import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:houdina/conta/Account.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

int tipo2 = 2;

class opcoes extends StatefulWidget {
  const opcoes({super.key});

  @override
  State<opcoes> createState() => _opcoesState();
}

class _opcoesState extends State<opcoes> {


  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? urDownload;

  Future  selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'fotosPFP/$userid';
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
                              onPressed: () async{
                                try{
                                  await obterImagempfp(context);
                                }catch(e){
                                  print("erro na cena $e");
                                }
                                /*mudar(novoemailController.text, 2);
                                setState(() {
                                  novoemailController.text = '';
                                });
                                tipo2 = 1;*/
                                //Navigator.pop(context);
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromRGBO(25, 95, 255, 0.7),
                      scrollable: true,
                      content: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Form(
                          child: Text("Escolhe a imagem pra trocar"),
                        ),
                      ),
                      actions: [
                        Center(child: 
                          Column(children: [
                            ElevatedButton(
                              child: const Text(
                                "Attach Files",
                                style: TextStyle(
                                    color: Color.fromRGBO(
                                        25, 95, 255, 1.0)),
                              ),
                              onPressed: () {
                                selectFile();
                              },
                            ),
                            ElevatedButton(
                              child: const Text(
                                "Procurar",
                                style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0))
                              ),
                              onPressed: () async {
                                uploadFile();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                          )
                        )
                      ],
                  );
                  },
                );
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
    
    if(tipo2 == 1){
    try {
    User? user1 = FirebaseAuth.instance.currentUser;

    if (user1 != null) {
      await user1.updateEmail(mudanca);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user1.uid)
          .update({'email': mudanca});

      print("Email updated successfully");
    }
  } catch (e) {
    print("Error updating email: $e");
  }
  }else{
    User? user = FirebaseAuth.instance.currentUser;

    user!.sendEmailVerification();
  }

  }else if(tipo == 3){
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email_user.toString());
      print("Password reset email sent successfully");
    } catch (e) {
      print("Error sending password reset email: $e");
    }
  }else if(tipo == 4){
     print("imagem mudar");
  }
}

Future<Widget> obterImagempfp(BuildContext context) async {
  /*Image image = Image.asset('resources/default.png',
                        width: MediaQuery.of(context).size.height * 0.4,
                        height: MediaQuery.of(context).size.height * 0.4,);
  await FireStorageService.loadImage(context,userid!).then((value){
    image = Image.network(value.toString());
  });
  return image;*/
    String defaultImagePath = 'resources/default.png';

  // Default image widget
  Image image = Image.asset(
    defaultImagePath,
  );

  try {
    String imageUrl = await FireStorageService.loadImage(context, userid!);

    // If the image is successfully retrieved from Firebase Storage
    if (imageUrl.isNotEmpty) {
      image = Image.network(
        imageUrl,
      );
    }
  } catch (e) {
    print('Error loading image: $e');
  }

  return image;
}

class FireStorageService extends ChangeNotifier{
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async{
    //Obtém as Imagens apartir do link de Download
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}