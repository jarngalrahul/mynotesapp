import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotesapp/constants/routes.dart';
import 'package:mynotesapp/services/auth/bloc/auth_bloc.dart';
import 'package:mynotesapp/services/auth/bloc/auth_event.dart';
import 'package:mynotesapp/services/auth/bloc/auth_state.dart';
import 'package:mynotesapp/services/auth/firebase_auth_provider.dart';
import 'package:mynotesapp/views/login_view.dart';
import 'package:mynotesapp/views/notes/create_update_note_view.dart';
import 'package:mynotesapp/views/notes/notes_view.dart';
import 'package:mynotesapp/views/register_view.dart';
import 'package:mynotesapp/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmainView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthStateLoggedIn) {
        return const NotesView();
      } else if (state is AuthStateNeedsVerification) {
        return const VerifyEmainView();
      } else if (state is AuthStateLoggedOut) {
        return const LoginView();
      } else {
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    });
  }
}
