import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotesapp/constants/routes.dart';
import 'package:mynotesapp/firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotesapp/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
          title: const Text('Register'),
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
                          final UserCredential credential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          devtools.log("$credential");
                          final User? user = FirebaseAuth.instance.currentUser;
                          await user?.sendEmailVerification();
                          if (!context.mounted) return;
                          Navigator.of(context).pushNamed(
                            verifyEmailRoute,
                          );
                        } on FirebaseAuthException catch (e) {
                          devtools.log('An error occured: ${e.code}');
                          if (!context.mounted) return;
                          if (e.code == 'weak-password') {
                            await showErrorDialog(
                              context,
                              'Weak password',
                            );
                          } else if (e.code == 'invalid-email') {
                            await showErrorDialog(
                              context,
                              'invalid-email',
                            );
                          } else {
                            await showErrorDialog(
                              context,
                              'An error occured: ${e.code}',
                            );
                          }
                        } catch (e) {
                          devtools.log("An error occured: $e");
                          if (!context.mounted) return;
                          await showErrorDialog(
                            context,
                            'An error occured: $e',
                          );
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 45, 105, 154),
                        ),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute,
                          (route) => false,
                        );
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 45, 105, 154),
                        ),
                      ),
                      child: const Text(
                        "Already registered? Login here!",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                );
              default:
                return const Text("Loading");
            }
          },
        ));
  }
}


//need to add create new ssh key and then we will add it to the github and only then we  can modify the repository for the current project