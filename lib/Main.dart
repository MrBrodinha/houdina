import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:houdina/firebase_options.dart';

import 'Inicial/Login.dart';

void main() async{
	WidgetsFlutterBinding.ensureInitialized();
  //Inicializar o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(MaterialApp(home: Main())); 
}

class Main extends StatelessWidget{
	@override
	Widget build(BuildContext context) {
		return Scaffold(
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
                //Wallpaper
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://wallpapercave.com/wp/wp10671634.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //Nome da Aplicação
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.20,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.15, 
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(25, 95, 255, 1.0),
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Center(
                      child: Text('Houdina',
                        style: TextStyle(
                          fontSize: 80,
                          color: Color.fromRGBO(25, 95, 255, 1.0),
                        ),
                      ),
                    ),
                  ),
                )
                
              ],
            ),
            //Prox Página -> Login Page
            Container(
              child: Login(),
            ),
          ],
        ),
      ),
		);
	}
}
