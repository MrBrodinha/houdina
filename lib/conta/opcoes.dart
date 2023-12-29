import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

import 'account.dart';

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

    final path = 'fotosPFP/${FirebaseAuth.instance.currentUser?.uid}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);

    try{
      Reference storageReference = FirebaseStorage.instance.refFromURL("gs://houdina-2194.appspot.com/fotosPFP/${FirebaseAuth.instance.currentUser?.uid!}");
      await storageReference.delete().then((value) => 
      print("acabei await"));
    }catch(e){
      print('erro a apagar: $e');
    }
    print("tou uauqi");
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
            "Opções",
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
              /*Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => Account()),
              );//.then((value) => {setState((){})});*/
            },
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.30,
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
              child: const Text("Mudar o nome",
                  style: TextStyle(
                    color: Color.fromRGBO(25, 95, 255, 1.0),
                    decoration: TextDecoration.none,
                    fontSize: 30
                  ),
              ),
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
                              FutureBuilder(
                                future: nomeUser(2), 
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
                              TextFormField(
                                maxLines: null,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(color: Colors.white),
                                  labelText: "Novo nome",
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
                                "Submeter",
                                style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0))
                              ),
                              onPressed: () {
                                mudar(novonomeController.text, 1);
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
            ),
            ),
            ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.60,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.70,
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
              child: const Text("Mudar palavra-passe",
              style: TextStyle(
                    color: Color.fromRGBO(25, 95, 255, 1.0),
                    decoration: TextDecoration.none,
                    fontSize: 30
                  ),),
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
                          child: Text('Clique para enviar um e-mail para mudança de palavra-passe',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      actions: [
                        Center(child: 
                          Column(children: [
                            ElevatedButton(
                              child: const Text(
                                "Enviar",
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
            ),
            ),
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.75,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.70,
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
              child: const Text("Mudar foto de perfil",
              style: TextStyle(
                    color: Color.fromRGBO(25, 95, 255, 1.0),
                    decoration: TextDecoration.none,
                    fontSize: 30
                  ),),
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
                          child: Text("Escolhe a imagem pra trocar",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      actions: [
                        Center(child: 
                          Column(children: [
                            ElevatedButton(
                              child: const Text(
                                "Procurar foto",
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
                                "Submeter",
                                style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0))
                              ),
                              onPressed: () async {
                                uploadFile();
                                setState(() {
                                });
                                
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
            ),
            ),
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

Future<Widget> obterImagemperfil(BuildContext context, String imageName) async {
  Image image = Image.asset('');
  try{
    await FireStorageService.loadImage(context, imageName).then((value){
      image = Image.network(value.toString());
    });
  }catch(e){
    try{
      // ignore: use_build_context_synchronously
      await FireStorageService.loadImage(context, "aplicacao/default.png").then((value){
        image = Image.network(value.toString());
      });
    }catch(e){
      print("EROOOOOOOOOOOOOOOOOOOOOO $e");
      return Image.asset('resources/default.png');
    }
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