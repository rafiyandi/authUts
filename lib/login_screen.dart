import 'package:flutter/material.dart';
import 'package:mobilecomputing/auth_repository.dart';
import 'package:mobilecomputing/register_screen.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  //form key
  final _formKey = GlobalKey<FormState>();
  //editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthRepository _authRepository = AuthRepository();

  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.email), //tampilan supaya nampak icon email
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true, //biar nampak password ...

        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.vpn_key), //tampilan supaya nampak kunci vpn_key
            contentPadding: EdgeInsets.fromLTRB(
                20, 15, 20, 15), // padding adalah pemisah/spasi
            hintText:
                "password", //biar kelihatan tulisan password sebelum di tulis
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    //tombol login
    final loginButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.redAccent,
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            try {
              _authRepository
                  .signIn(emailController.text, passwordController.text)
                  .then((value) => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("berhasil Login"),
                          )));
            } catch (e) {
              AlertDialog(
                title: Text(e.toString()),
              );
            }

            //Navigator.push(
            //  context, MaterialPageRoute(builder: (context) => HomeScreen()));

            // signIn(emailController.text, passwordController.text);
          },
          // color: Colors.redAccent,
          child: Text(
            "login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // SizedBox(
                        //   height: 200,
                        //   child: Image.asset(
                        //     "assets/LoginPage.png",
                        //     fit: BoxFit.scaleDown,
                        //   ),
                        // ),
                        SizedBox(height: 45),
                        emailField,
                        SizedBox(height: 50),
                        passwordField,
                        SizedBox(height: 45),
                        loginButton,
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text("Dont have an account? "),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => RegisterScreen())),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.deepOrangeAccent[400],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ));
  }
}
