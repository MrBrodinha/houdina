import 'package:flutter/material.dart';

//Dar import a files externos
import 'Login.dart';
import 'Verificar.dart';

class Signup extends StatelessWidget{

	final TextEditingController usernameController = TextEditingController();
	final TextEditingController emailController = TextEditingController();
	final TextEditingController passwordController = TextEditingController();
	final TextEditingController confirmPasswordController = TextEditingController();

	Signup({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: Scaffold(
				body: Container(
					alignment: Alignment.center,
					decoration: BoxDecoration(
						image: DecorationImage(
							image: NetworkImage('https://wallpapercave.com/wp/wp10671634.jpg'),
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

							//----------EMAIL----------
							Padding(
							//Definir os Paddings laterais
								padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
								child: TextField(
									keyboardType: TextInputType.emailAddress,
									textAlign: TextAlign.center,
									decoration: InputDecoration(
										hintText: 'Email',
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
									controller: emailController,
								),
							),

							//----------SENHA----------
							Padding(
							//Definir os Paddings laterais
								padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
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

							//----------CONFIRMAR SENHA----------
							Padding(
							//Definir os Paddings laterais
								padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
								child: TextField(
									textAlign: TextAlign.center,
									//De modo a não se ver enquato se escreve
									obscureText: true,
									decoration: InputDecoration(
										hintText: 'Confirm Password',
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
									controller: confirmPasswordController,
								),
							),

							//----------REDIRECIONAMENTO LOGIN----------
							Padding(
								// Definir os Paddings laterais 
								padding: EdgeInsets.fromLTRB(35, 20, 35, 0),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										Text("If you already have an account click", style: TextStyle(color: Colors.white),),
										//TextButton tinha espaço dentro - InkWell não tem
										InkWell(
											onTap: () {
												Navigator.push(context,
													MaterialPageRoute(builder: (context) => Login()),
												);
											},
											child: Text(" here",
												style: TextStyle(color: Color.fromRGBO(25, 95, 255, 1.0)),
											),
										)
									],
								),
							),

							//----------BOTÃO DE CRIAR CONTA----------
							Padding(
								// Definir os Paddings laterais 
								padding: EdgeInsets.fromLTRB(35, 15, 35, 0),
								child: Column(
									children: [
										ElevatedButton(
											onPressed: () {
												String username = usernameController.text;
												String email = emailController.text;
												String pass = passwordController.text;
												String confpass = confirmPasswordController.text;
												//Necessário passar o context da página Signup, isto pq o Verificar vai ser um file sem widgets
												CriarConta(context, username, email, pass, confpass);
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