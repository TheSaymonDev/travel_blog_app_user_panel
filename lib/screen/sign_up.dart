
import 'package:blog_app/mydb/mydb_helper.dart';
import 'package:blog_app/screen/sign_in_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp Page'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: 'Please enter your email'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: 'Please enter your password'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {
              MyDbHelper helper=MyDbHelper();
              helper.signUp(emailController.text, passwordController.text);
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignInPage()));
            }, child: Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
