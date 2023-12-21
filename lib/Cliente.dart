import 'package:flutter/material.dart';
import 'Carros/Carros.dart';
import 'Agendar/Agendar.dart';
import 'Maps/Maps.dart';
import 'conta/Account.dart';
import 'main.dart';

class Cliente extends StatefulWidget {
  const Cliente({super.key});
  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<Cliente>{

  int index = 0;
  final files = [
    const Carros(),
    const Agendar(),
    const Maps(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: files[index],
    bottomNavigationBar: BottomNavigationBar(

      iconSize: MediaQuery.of(context).size.width * 0.08,
      //Unselected
      unselectedItemColor: Colors.white,
      unselectedLabelStyle: const TextStyle(color: Colors.white),
      showUnselectedLabels: true,
      //Selected
      selectedItemColor: const Color.fromRGBO(25, 95, 255, 1.0),
      selectedLabelStyle: const TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0)),

      currentIndex: index,
      onTap: (newIndex) {
        setState(() {
          if (newIndex == index && index == 3) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Main()),);
          } else {
            index = newIndex;
          }
        });
      },

      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.car_crash),
          label: 'Carros',
          backgroundColor: Colors.black,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'C/A',
          backgroundColor: Colors.black,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.gps_fixed),
          label: 'GPS',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: index == 3 ? const Icon(Icons.logout) : const Icon(Icons.person),
          label: 'Conta',
          backgroundColor: Colors.black,
        ),
      ],
    ),
  );
}