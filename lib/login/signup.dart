import 'package:flutter/material.dart';

//Dar import a files externos
import 'verificar.dart';
import '../Main.dart';

//ACREDITO QUE TODAS AS NOSSAS ABAS CONVEM ESTAREM EM STATEFUL PQ MUDAM DE PARAMETROS CONSTANTEMENTE

//É MESMOOOOOO

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
        //Para efeitos da notificação (snackbar)
        child: Builder(builder: (context2) {
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
                    //----------USERNAME----------
                    Padding(
                      //Definir os Paddings laterais
                      padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Nome',
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
                        controller: usernameController,
                      ),
                    ),

                    //----------EMAIL----------
                    Padding(
                      //Definir os Paddings laterais
                      padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(25, 95, 255, 0.70),
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
                      padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        //De modo a não se ver enquato se escreve
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Palavra Passe',
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(25, 95, 255, 0.70),
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

                    //----------CONFIRMAR SENHA----------
                    Padding(
                      //Definir os Paddings laterais
                      padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        //De modo a não se ver enquato se escreve
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirmar Palavra Passe',
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(25, 95, 255, 0.70),
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
                        controller: confirmPasswordController,
                      ),
                    ),

                    //----------REDIRECIONAMENTO LOGIN----------
                    Padding(
                      // Definir os Paddings laterais
                      padding: const EdgeInsets.fromLTRB(35, 20, 35, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Se já tem conta registada clique",
                            style: TextStyle(color: Colors.white),
                          ),
                          //TextButton tinha espaço dentro - InkWell não tem
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              " aqui",
                              style: TextStyle(
                                  color: Color.fromRGBO(25, 95, 255, 1.0)),
                            ),
                          )
                        ],
                      ),
                    ),

                    //----------BOTÃO DE CRIAR CONTA----------
                    Padding(
                      // Definir os Paddings laterais
                      padding: const EdgeInsets.fromLTRB(35, 15, 35, 0),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              String username = usernameController.text;
                              String email = emailController.text;
                              String pass = passwordController.text;
                              String confpass = confirmPasswordController.text;
                              //Necessário passar o context da página Signup, isto pq o Verificar vai ser um file sem widgets
                              criarConta(context2, username, email, pass, confpass);
                              //Limpar os campos no fim de dar erro
                              usernameController.text = '';
                              emailController.text = '';
                              passwordController.text = '';
                              confirmPasswordController.text = '';
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
                              "Criar Conta",
                              style: TextStyle(
                                  color: Color.fromRGBO(25, 95, 255, 1.0)),
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
        }),
      )
    );
  }
}
