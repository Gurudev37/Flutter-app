import 'package:chat_application/constants.dart';
import 'package:chat_application/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_application/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
class RegisterScreen extends StatefulWidget {
  static const String id="register_screen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth=FirebaseAuth.instance;
  bool showSpinner=false;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('assets/logo.jpg'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password=value;
                },
                decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colour: Colors.blueAccent,
                title: 'Register',
                onPressed: () async{
                  setState(() {
                    showSpinner=true;
                  });
                  try{
                    final newUser=await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if(newUser!=null){
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context,ChatScreen.id);
                      setState(() {
                        showSpinner=false;
                      });
                    }
                  }
                  catch(e){
                    print("Error something went wrong");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}