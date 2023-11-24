import 'package:flutter/material.dart';

//Dar import a files externos
import 'Signup.dart';
import 'Verificar.dart';

class Login extends StatelessWidget {

	final TextEditingController usernameController = TextEditingController();
	final TextEditingController passwordController = TextEditingController();

  Login({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: Scaffold(
				body: Container(
					alignment: Alignment.center,
					decoration: BoxDecoration(
						image: DecorationImage(
							image: AssetImage('resources/Background.jpg'),
							//Para preencher a tela toda
							fit: BoxFit.cover,
						),
					),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							//----------USERNAME----------
							Padding(
							//Definir os Paddings laterais
								padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
								child: TextField(
									textAlign: TextAlign.center,
									decoration: InputDecoration(
										hintText: 'Username',
										hintStyle: TextStyle(
											color: Color.fromRGBO(25, 95, 255, 1.0),
										),
										//FILL AO TEXTFIELD
										filled: true,
										fillColor: Colors.white,
										//BORDA
										enabledBorder: OutlineInputBorder(
											borderSide: BorderSide(color: Color.fromRGBO(25, 95, 255, 1.0), width: 2.5,),
											borderRadius: BorderRadius.circular(35.0),
										),
										//Para não desformatar qnd está FOCUSED
										focusedBorder: OutlineInputBorder(
											borderSide: BorderSide(color: Color.fromRGBO(25, 95, 255, 1.0), width: 2.5,),
											borderRadius: BorderRadius.circular(35.0),
										),
									),
                  controller: usernameController,
								),
							),

							//----------SENHA----------
							Padding(
							//Definir os Paddings laterais
								padding: EdgeInsets.fromLTRB(35, 30, 35, 0),
								child: TextField(
									textAlign: TextAlign.center,
									//De modo a não se ver enquato se escreve
									obscureText: true,
									decoration: InputDecoration(
										hintText: 'Password',
										hintStyle: TextStyle(
											color: Color.fromRGBO(25, 95, 255, 1.0),
										),
										//FILL AO TEXTFIELD
										filled: true,
										fillColor: Colors.white,
										//BORDA
										enabledBorder: OutlineInputBorder(
											borderSide: BorderSide(color: Color.fromRGBO(25, 95, 255, 1.0), width: 2.5,),
											borderRadius: BorderRadius.circular(35.0),
										),
										//Para não desformatar qnd está FOCUSED
										focusedBorder: OutlineInputBorder(
											borderSide: BorderSide(color: Color.fromRGBO(25, 95, 255, 1.0), width: 2.5,),
											borderRadius: BorderRadius.circular(35.0),
										),
									),
                  controller: passwordController,
								),
							),

							//----------REDIRECIONAMENTO SIGNUP----------
							Padding(
								// Definir os Paddings laterais 
								padding: EdgeInsets.fromLTRB(35, 20, 35, 0),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										Text("If you don't have an account yet click", style: TextStyle(color: Colors.white),),
										//TextButton tinha espaço dentro - InkWell não tem
										InkWell(
											onTap: () {
												Navigator.push(context,
													MaterialPageRoute(builder: (context) => Signup()),
												);
											},
											child: Text(" here",
												style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0)),
											),
										)
									],
								),
							),

							//----------BOTÃO ENTRAR----------
							Padding(
								// Definir os Paddings laterais 
								padding: EdgeInsets.fromLTRB(35, 15, 35, 0),
								child: Column(
									children: [
										ElevatedButton(
											onPressed: () {
												String username = usernameController.text;
												String pass = passwordController.text;
												//Necessário passar o context da página Signup, isto pq o Verificar vai ser um file sem widgets
												EntrarConta(context, username, pass);
											},
											child: Text("Submit",
												style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0)),
											),
											style: ButtonStyle(
												backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
												shape: MaterialStateProperty.all<RoundedRectangleBorder>(
													RoundedRectangleBorder(
														borderRadius: BorderRadius.circular(35.0),
														side: BorderSide(color: Color.fromRGBO(25, 95, 255, 1.0), width: 2.5),
													),
												),
											),
										)
									],
								),
							),
						],
					),
				),
			),
		);
	}
}