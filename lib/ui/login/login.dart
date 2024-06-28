import 'package:contact_app_gita/bloc/register/register_bloc.dart';
import 'package:contact_app_gita/ui/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/login_bloc.dart';
import '../home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isError = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                border: const OutlineInputBorder(),
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
                  setState(() {
                    _isError = true;
                  });
                  Future.delayed(const Duration(seconds: 10), () {
                    setState(() {
                      _isError = false;
                    });
                  });
                } else if (state is LoginInitial) {
                  setState(() {
                    _isError = false;
                  });
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Builder(
                      builder: (context) {
                        if (state is LoginLoading) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          );
                        } else if (state is LoginInitial) {
                          return InkWell(
                            onTap: () {
                              context.read<LoginBloc>().add(
                                    LoginButtonPressed(
                                      _usernameController.text,
                                      _passwordController.text,
                                    ),
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
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              context.read<LoginBloc>().add(
                                    LoginButtonPressed(
                                      _usernameController.text,
                                      _passwordController.text,
                                    ),
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
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
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
                        color: Colors.grey,
                      ),
                    ),
                  ],
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
