import 'package:flutter/material.dart';
import '../data/SharedPrefsManager.dart';
import 'home.dart';
import 'login.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conPasswordController = TextEditingController();
  bool _isObscure = true;
  bool _isError = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _conPasswordController.dispose();
    super.dispose();
  }

  // Future<void> _handleRegister() async {
  //   String username = _usernameController.text;
  //   String password = _passwordController.text;
  //   String conPassword = _conPasswordController.text;
  //
  //   if (password == conPassword) {
  //     await SharedPrefsManager().login(username, password, '');
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => Home()),
  //     );
  //   } else {
  //     setState(() {
  //       _isError = true;
  //     });
  //     await Future.delayed(Duration(seconds: 10));
  //     setState(() {
  //       _isError = false;
  //     });
  //   }
  // }

  Future<void> _handleRegister() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String conPassword = _conPasswordController.text;

    bool isError = await register(username, password);
    setState(() {
      _isError  = isError;
    });
    if (!isError) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      setState(() {
        _isError = true;
      });
      await Future.delayed(Duration(seconds: 10));
      setState(() {
        _isError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/register.png"),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: _isObscure,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                errorText: _isError ? 'Passwords do not match' : null,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _conPasswordController,
              obscureText: _isObscure,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                errorText: _isError ? 'Passwords do not match' : null,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _handleRegister,
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const Login()));
              },
              child: RichText(
                text: const TextSpan(
                    text: "Already have an account? ",
                    children: [
                      TextSpan(
                        text: 'Login here',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey), // Bold text style
                      ),
                    ],
                    style: TextStyle(color: Colors.grey)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<bool> register(String login, String password) async {
  try {
    var user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: login, password: password);
    return false;
  } catch (e) {
    print("Error $e");
    return true;
  }
}
