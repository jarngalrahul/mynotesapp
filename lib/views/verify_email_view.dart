import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerifyEmainView extends StatefulWidget {
  const VerifyEmainView({super.key});

  @override
  State<VerifyEmainView> createState() => _VerifyEmainViewState();
}

class _VerifyEmainViewState extends State<VerifyEmainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn'),
        backgroundColor: const Color.fromARGB(255, 45, 105, 154),
        foregroundColor: Colors.white,
        shadowColor: Colors.amber,
      ),
      body: Column(
        children: [
          const Text("Please verify your email!"),
          TextButton(
            onPressed: () async {
              final User? user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            style: const ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Color.fromARGB(255, 45, 105, 154))),
            child: const Text(
              "Send Verification Email",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
