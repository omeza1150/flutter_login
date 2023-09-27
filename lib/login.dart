import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginrState();
}

class LoginrState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();

  Future<void> signin(BuildContext context) async {
    try {
      String url = "http://143.198.223.14/login.php";
      final response = await http.post(Uri.parse(url), body: {
        'email': email.text,
        'password': pass.text,
      });
      var data = json.decode(response.body);
      if (data == "Error") {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Email หรือรหัสผ่านไม่ถูกต้อง'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, 'home');
        }
      }
    } catch (error) {
      print(error);
      // Handle any error that occurred during signup
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 60),
                child: const FlutterLogo(
                  size: 100,
                ),
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Empty';
                    }
                    return null;
                  },
                  controller: email,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Empty';
                    }
                    return null;
                  },
                  controller: pass,
                ),
              ),
              const SizedBox(height: 16.0),
              // Sign In Button
              ElevatedButton(
                onPressed: () {
                  bool pass = formKey.currentState!.validate();
                  if (pass) {
                    signin(
                        context); // Pass the BuildContext to the signup function
                  }
                },
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 16.0),
              // Sign Up Text
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: const Text(
                  'Don\'t have an account? Sign up here.',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
