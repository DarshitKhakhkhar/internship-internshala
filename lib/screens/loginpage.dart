import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_project/services/auth.dart';
import 'package:internship_project/screens/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String mail = "";
  String passwd = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
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
                      "Sign in to your account",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Empty Mail Not Allowed!';
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          mail = value;
                        });
                      },
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.email),
                        hintText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Empty Password Not Allowed!';
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          passwd = value;
                        });
                      },
                      autofocus: true,
                      obscureText: true,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.lock),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 100.0),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              Authentication.login(mail, passwd);
                            }
                          },
                          child: Text("Login")),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: "Don't have an Account? ",
                              style: TextStyle(color: Colors.grey.shade700)),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(const SignupPage());
                          },
                          child: const Text("Register Here"),
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
    );
  }
}
