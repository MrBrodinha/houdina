import 'package:flutter/material.dart';

//Dar import a files externos
import 'signup.dart';
import 'verificar.dart';
import '../Main.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
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

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //----------Email----------
              Padding(
                //Definir os Paddings laterais
                padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(25, 95, 255, 0.7),
                    ),
                    //FILL AO TEXTFIELD
                    filled: true,
                    fillColor: Colors.white,
                    //BORDA
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(25, 95, 255, 1.0),
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    //Para não desformatar qnd está FOCUSED
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(25, 95, 255, 1.0),
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                  controller: emailController,
                ),
              ),

              //----------SENHA----------
              Padding(
                //Definir os Paddings laterais
                padding: const EdgeInsets.fromLTRB(35, 30, 35, 0),
                child: TextField(
                  textAlign: TextAlign.center,
                  //De modo a não se ver enquato se escreve
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Palavra Passe',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(25, 95, 255, 0.7),
                    ),
                    //FILL AO TEXTFIELD
                    filled: true,
                    fillColor: Colors.white,
                    //BORDA
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(25, 95, 255, 1.0),
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    //Para não desformatar qnd está FOCUSED
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(25, 95, 255, 1.0),
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                  controller: passwordController,
                ),
              ),

              //----------REDIRECIONAMENTO SIGNUP----------
              Padding(
                // Definir os Paddings laterais
                padding: const EdgeInsets.fromLTRB(35, 20, 35, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Se ainda não tem conta clique",
                      style: TextStyle(color: Colors.white),
                    ),
                    //TextButton tinha espaço dentro - InkWell não tem
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      child: const Text(
                        " aqui",
                        style:
                            TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0)),
                      ),
                    )
                  ],
                ),
              ),

              //----------BOTÃO ENTRAR----------
              Padding(
                // Definir os Paddings laterais
                padding: const EdgeInsets.fromLTRB(35, 15, 35, 0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        String email = emailController.text;
                        String pass = passwordController.text;
                        //Necessário passar o context da página Signup, isto pq o Verificar vai ser um file sem widgets
                        logIn(context, email, pass);
                        //Limpar os campos no fim de dar erro
                        emailController.text = '';
                        passwordController.text = '';
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                            side: const BorderSide(
                                color: Color.fromRGBO(25, 95, 255, 1.0),
                                width: 2.5),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Entrar",
                        style:
                            TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }
}
