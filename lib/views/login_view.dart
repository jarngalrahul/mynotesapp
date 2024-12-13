import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotesapp/constants/routes.dart';
import 'package:mynotesapp/firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotesapp/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('LogIn'),
          backgroundColor: const Color.fromARGB(255, 45, 105, 154),
          foregroundColor: Colors.white,
          shadowColor: Colors.amber,
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: true,
                      decoration: const InputDecoration(
                        hintText: "Enter your email here",
                      ),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: "Enter your password here",
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;

                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          final User? user = FirebaseAuth.instance.currentUser;
                          devtools.log(user.toString());
                          if (!context.mounted) return;
                          if (user?.emailVerified ?? false) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              notesRoute,
                              (route) => false,
                            );
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              verifyEmailRoute,
                              (route) => false,
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          devtools.log(e.message.toString());
                          await showErrorDialog(
                            context,
                            'Error ${e.code}',
                          );
                        } catch (e) {
                          devtools.log("An error occured: $e");
                          await showErrorDialog(
                            context,
                            'Error ${e.toString()}',
                          );
                        }
                      },
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Color.fromARGB(255, 45, 105, 154))),
                      child: const Text(
                        "Log In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          registerRoute,
                          (route) => false,
                        );
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 45, 105, 154),
                        ),
                      ),
                      child: const Text(
                        'Not registered yet? Register here',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              default:
                return const Text("Loading");
            }
          },
        ));
  }
}
