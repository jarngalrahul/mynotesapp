import 'package:flutter/material.dart';
import 'package:mynotesapp/constants/routes.dart';
import 'package:mynotesapp/services/auth/auth_service.dart';

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
        title: const Text('Verify email'),
        backgroundColor: const Color.fromARGB(255, 45, 105, 154),
        foregroundColor: Colors.white,
        shadowColor: Colors.amber,
      ),
      body: Column(
        children: [
          const Text(
            "We've sent you an email verification. Please open it to verify your account.",
          ),
          const Text(
              "If you haven't receieved email yet, click 'Send verification email' button below."),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Color.fromARGB(255, 45, 105, 154),
              ),
            ),
            child: const Text(
              "Send Verification Email",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              if (!context.mounted) return;
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
              'Restart',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
