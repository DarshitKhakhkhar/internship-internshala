import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_project/screens/adddetails.dart';
import 'package:internship_project/screens/loginpage.dart';
import 'package:firebase_database/firebase_database.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late DatabaseReference dbRef;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String email = "";
  String pwd = "";

  var items = [
    'Student',
    'Faculty',
    'Alumni',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Hello",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        "Register your account",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.email),
                          hintText: 'Email',
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value.toString())) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.lock),
                          hintText: 'Password',
                        ),
                        onChanged: (value) {
                          setState(() {
                            pwd = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Enter a valid password!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Center(
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                Get.off(AddDetails(email: email, pwd: pwd));
                              }
                            },
                            child: Text("Continue to add details")),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Already have an Account? ",
                                style: TextStyle(color: Colors.grey.shade700)),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(LoginPage());
                            },
                            child: Text("Login!!"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
