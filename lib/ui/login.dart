import 'package:contact_app_gita/ui/register.dart';
import 'package:flutter/material.dart';
import '../data/SharedPrefsManager.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    bool isLoggedIn = SharedPrefsManager().signIn(username, password);

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      setState(() {
        _isError = true;
      });
      await Future.delayed(const Duration(seconds: 10));
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
            Image.asset("assets/login.png"),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                errorText: _isError ? 'Incorrect username or password' : null,
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
                errorText: _isError ? 'Incorrect username or password' : null,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: _handleLogin,
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const Register()));
              },
              child: RichText(text: const TextSpan(text:"Don’t have an account yet?  ",children: [
                TextSpan(
                  text: 'Sign up here',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey), // Bold text style
                ),
              ],style: TextStyle(color: Colors.grey)),),)
          ],
        ),
      ),
    );
  }
}
