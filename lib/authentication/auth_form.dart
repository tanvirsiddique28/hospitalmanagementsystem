
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_system/home_screen.dart';
import 'package:hospital_management_system/widgets/my_buttons.dart';
import 'package:hospital_management_system/widgets/my_textField.dart';
import 'package:google_fonts/google_fonts.dart';
class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //variables--------------
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';
  bool _isLogInPage = false;
  //functions___________________

  void startSignUp(){
    final validate = _formKey.currentState?.validate();
    if(validate!){
      _formKey.currentState?.save();
      submitForm(_username, _email, _password);
    }
  }
  void submitForm(String username,String email,String password)async{
      FirebaseAuth auth = FirebaseAuth.instance;

      try{
        if(_isLogInPage){
        final authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
        }else{
          final authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
          String?uid = authResult.user?.uid;
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'username':_username,
            'email':_email,
          });
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
        }
      }catch(e){
        print(e);
      }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mainback.png'),
            fit: BoxFit.fill,
          )
      ),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(!_isLogInPage)
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('username'),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Incorrect Username';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: new BorderSide(),
                        ),
                        labelText: "Enter Username",
                        labelStyle: GoogleFonts.roboto(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      validator: (String? value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Incorrect Email';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: new BorderSide(),
                        ),
                        labelText: "Enter Email",
                        labelStyle: GoogleFonts.roboto(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('password'),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Incorrect Password';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: new BorderSide(),
                        ),
                        labelText: "Enter Password",
                        labelStyle: GoogleFonts.roboto(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyButtons(title:_isLogInPage?'Log In':'Sign Up',width:double.infinity,height:45.0, onPress:(){
                        startSignUp();
                    },),
                    SizedBox(height: 10,),
                    _isLogInPage?TextButton(onPressed: (){
                      setState(() {
                        _isLogInPage = false;
                      });
                    },child:Text('Not a member?',style: GoogleFonts.roboto(color: Colors.black),)):
                    TextButton(onPressed: (){
                      setState(() {
                        _isLogInPage = true;
                      });
                    },child:Text('Already a member?',style: GoogleFonts.roboto(color: Colors.black),))
                  ],
                ),
              ),
            )
          ],
        ),
    );
  }
}

