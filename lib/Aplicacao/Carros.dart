import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'Account.dart';
import 'Default.dart';

class Carros extends StatefulWidget{
  const Carros({super.key});
  @override
  State<Carros> createState() => _CarrosState();
}

class _CarrosState extends State<Carros> {

  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if(result == null) return;

    setState((){
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async{
    final path = 'carros/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    
    setState((){
      uploadTask = ref.putFile(file);
    });
    
    final snapshot = await uploadTask!.whenComplete((){});
    final urDownload = await snapshot.ref.getDownloadURL();
    print("Download Link: $urDownload");

    setState((){
      uploadTask == null;
    });
  }

	@override
	Widget build(BuildContext context) {
    return 
    Stack(
      alignment: Alignment.center,
      children: [
        //Wallpaper
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://wallpapercave.com/wp/wp10671634.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.08,
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
                      icon: Icon(Icons.search,
                        size: MediaQuery.of(context).size.height * 0.05,
                        color: const Color.fromRGBO(25, 95, 255, 1.0),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              content: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Form(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: "Brand name of Model:",
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: "Year of the Car:",
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: "Mileage:",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            actions: [
                              Center(child: 
                                Column(children: [
                                  //SE A FOTO JÁ TIVER SIDO SELECIONADA
                                  if (pickedFile != null)
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color.fromRGBO(25, 95, 255, 1.0),
                                            width: 3.0,
                                          ),
                                          borderRadius: BorderRadius.circular(35.0),
                                        ),
                                        width: MediaQuery.of(context).size.width * 0.50,
                                        height: MediaQuery.of(context).size.height * 0.06,
                                        child: ElevatedButton(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              pickedFile!.name,
                                              style: const TextStyle(
                                                color: Color.fromRGBO(25, 95, 255, 1.0),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                          onPressed: (){
                                            selectFile();
                                          },
                                        ),
                                      ),
                                    ),
                                  if (pickedFile == null)
                                    ElevatedButton(
                                      child: const Text("Attach Files"),
                                      onPressed: () {
                                        selectFile();
                                      },
                                    ),
                                  ElevatedButton(
                                    child: const Text("Submit"),
                                    onPressed: () {
                                      uploadFile();
                                    },
                                  ),
                                  buildProgress(),
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
                      "Vehicles",
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
                      icon: Icon(Icons.plus_one_outlined,
                        size: MediaQuery.of(context).size.height * 0.05,
                        color: const Color.fromRGBO(25, 95, 255, 1.0)
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Carros()),);
                      },
                    ),
                  ),
                ),
              ),
          ],
          )
        ),

        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.01,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(25, 95, 255, 1.0),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.car_crash,
                        size: MediaQuery.of(context).size.height * 0.05,
                        color: Colors.white
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Carros()),);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(25, 95, 255, 1.0),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.punch_clock,
                        size: MediaQuery.of(context).size.height * 0.05,
                        color: Colors.white
                      ),
                      onPressed: () {
                      },
                    ),
                  ),
                ),
              ),
              //Botão Central -> LOGO
              IconButton(
                icon: Image.asset('resources/Logo.png', 
                  width: MediaQuery.of(context).size.height * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Default()),);
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(25, 95, 255, 1.0),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.gps_fixed,
                        size: MediaQuery.of(context).size.height * 0.05,
                        color: Colors.white
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
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(25, 95, 255, 1.0),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.person,
                        size: MediaQuery.of(context).size.height * 0.05,
                        color: Colors.white
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Account()),);
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

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
    stream: uploadTask?.snapshotEvents,
    builder: (context, snapshot){
      if(snapshot.hasData){
        final data = snapshot.data!;
        double progresso = data.bytesTransferred / data.totalBytes;

        return SizedBox(
          height: 50,
          child: Stack(
            fit: StackFit.expand,
            children: [
              LinearProgressIndicator(
                value: progresso,
                backgroundColor: const Color.fromRGBO(25, 95, 255, 1.0),
                color: Colors.white,
              ),
              Center(
                child: Text(
                  '${(100*progresso).roundToDouble()}%',
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        );
      }else{
        return const SizedBox(height: 50);
      }
    },
  
  );

}
