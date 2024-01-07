// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:houdina/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Inicializar o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  // Initialize Firebase App Check with the Play Integrity provider
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Main()));
}

class Main extends StatefulWidget {
  const Main({super.key});
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            //Dar set ao Carousel para o comprimento total do ecrã
            height: MediaQuery.of(context).size.height,
            //Dar set ao Carousel para a largura total do ecrã
            viewportFraction: 1.0,
            //Não permitir dar mais dq um Slide
            enableInfiniteScroll: false,
          ),
          items: [
            //Widget que permite vários widgets -> Dar overlay do nome da aplicação sobre o wallpaper
            Stack(
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
                //Nome da Aplicação
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.20,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(25, 95, 255, 1.0),
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(0.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "Houdina",
                          style: TextStyle(
                            color: Color.fromRGBO(25, 95, 255, 1.0),
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            //Prox Página -> Login Pag
            const Login(),
          ],
        ),
      ),
    );
  }
}




//---------------------------------------
//------------OBTER BACKGROUND-----------
//---------------------------------------
class FireStorageService extends ChangeNotifier{
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async{
    //Obtém as Imagens apartir do link de Download
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
Future<Widget> obterFundo(BuildContext context) async {
  Container ima = Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('resources/Background.jpg'),
        fit: BoxFit.cover,
      ),
    ),
  );
  try{
    await FireStorageService.loadImage(context, "aplicacao/Background.jpg").then((value){
      ima = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(value.toString()),
            fit: BoxFit.cover,
          ),
        ),
      );
    });
  }catch(e){
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('resources/Background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  return ima;
}