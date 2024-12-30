import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotesapp/services/auth/auth_service.dart';
import 'package:mynotesapp/services/auth/bloc/auth_bloc.dart';
import 'package:mynotesapp/services/auth/bloc/auth_event.dart';

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
              "If you haven't receieved email yet, click 'Send verif  ication email' button below."),
          TextButton(
            onPressed: () async {
              context
                  .read<AuthBloc>()
                  .add(const AuthEventSendEmailVerification());
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
              context.read<AuthBloc>().add(const AuthEventLogOut());
              await AuthService.firebase().logOut();
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
