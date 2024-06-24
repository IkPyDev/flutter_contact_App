import 'package:contact_app_gita/bloc/register/register_bloc.dart';
import 'package:contact_app_gita/ui/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/login_bloc.dart';
import '../home.dart';

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
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Future<void> _handleLogin() async {
  //   String username = _usernameController.text;
  //   String password = _passwordController.text;
  //
  //   var logins = login(username, password);
  //   bool isLoggedIn = SharedPrefsManager().signIn(username, password);
  //
  //   if (isLoggedIn) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const Home()),
  //     );
  //   } else {
  //     setState(() {
  //       _isError = true;
  //     });
  //     await Future.delayed(const Duration(seconds: 10));
  //     setState(() {
  //       _isError = false;
  //     });
  //   }
  // }
  // Future<void> _handleLogin() async {
  //   String username = _usernameController.text;
  //   String password = _passwordController.text;
  //
  //   bool isError = await login(username, password);
  //   setState(() {
  //     _isError = isError;
  //   });
  //
  //   if (!isError) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const Home()),
  //     );
  //   } else {
  //     await Future.delayed(const Duration(seconds: 10));
  //     setState(() {
  //       _isError = false;
  //     });
  //   }
  // }

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
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                } else if (state is LoginError) {
                  setState(() async {
                    _isError = true;

                    await Duration(seconds: 10);
                    setState(() {
                      _isError = false;
                    });
                  });
                }
              },
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    _loginBloc.add(
                          LoginButtonPressed(_usernameController.text,
                              _passwordController.text),
                        );
                  },
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
                );
              },
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (BuildContext context) => RegisterBloc(),
                      child: const Register(),
                    ),
                  ),
                );
              },
              child: RichText(
                text: const TextSpan(
                    text: "Don’t have an account yet?  ",
                    children: [
                      TextSpan(
                        text: 'Sign up here',
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
//
// Future<bool> login(String login, String password) async {
//   try {
//     var user = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: login, password: password);
//     return false;
//   } catch (e) {
//     print("Error $e");
//     return true;
//   }
// }
