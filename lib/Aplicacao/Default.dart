import 'package:flutter/material.dart';

import 'Account.dart';
import 'Carros.dart';

class Default extends StatefulWidget{
  const Default({super.key});
  @override
  State<Default> createState() => _DefaultState();
}

class _DefaultState extends State<Default> {

  @override
  void initState(){
    super.initState();
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
                        color: const Color.fromRGBO(25, 95, 255, 1.0)
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
                        color: const Color.fromRGBO(25, 95, 255, 1.0)
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
                        color: const Color.fromRGBO(25, 95, 255, 1.0)
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
                      icon: Icon(Icons.person,
                        size: MediaQuery.of(context).size.height * 0.05,
                        color: const Color.fromRGBO(25, 95, 255, 1.0)
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
}
