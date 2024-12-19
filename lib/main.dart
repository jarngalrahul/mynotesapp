import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotesapp/constants/routes.dart';
// import 'package:mynotesapp/services/auth/auth_service.dart';
// import 'package:mynotesapp/services/auth/auth_user.dart';
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
      home: const HomePage(),
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

//Commented it out to use blocs in program
//=========================================
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: AuthService.firebase().initialize(),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.done:
//             final AuthUser? user = AuthService.firebase().currentUser;
//             if (user != null) {
//               if (user.isEmailVerified) {
//                 return const NotesView();
//               } else {
//                 return const VerifyEmainView();
//               }
//             } else {
//               return const LoginView();
//             }
//           default:
//             return const CircularProgressIndicator();
//         }
//       },ddddddd
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Testing Bloc'),
        ),
        body:
            BlocConsumer<CounterBloc, CounterState>(builder: (context, state) {
          final invalidValue =
              (state is CounterStateInvalidNumber) ? state.invalidValue : '';
          return Column(
            children: [
              Text('Current value => ${state.value}'),
              Visibility(
                visible: state is CounterStateInvalidNumber,
                child: Text('Invalid input: $invalidValue'),
              ),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter a number here',
                ),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context
                          .read<CounterBloc>()
                          .add(DecrementEvent(_controller.text));
                    },
                    child: const Text('-'),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<CounterBloc>()
                          .add(IncrementEvent(_controller.text));
                    },
                    child: const Text('+'),
                  ),
                ],
              )
            ],
          );
        }, listener: (context, state) {
          _controller.clear();
        }),
      ),
    );
  }
}

@immutable
abstract class CounterState {
  final int value;
  const CounterState(this.value);
}

class CounterstateValid extends CounterState {
  const CounterstateValid(super.value);
}

class CounterStateInvalidNumber extends CounterState {
  final String invalidValue;
  const CounterStateInvalidNumber({
    required this.invalidValue,
    required int previousVlaue,
  }) : super(previousVlaue);
}

@immutable
abstract class CounterEvent {
  final String value;
  const CounterEvent(this.value);
}

class IncrementEvent extends CounterEvent {
  const IncrementEvent(super.value);
}

class DecrementEvent extends CounterEvent {
  const DecrementEvent(super.value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterstateValid(0)) {
    on<IncrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(
          CounterStateInvalidNumber(
            invalidValue: event.value,
            previousVlaue: state.value,
          ),
        );
      } else {
        emit(CounterstateValid(state.value + integer));
      }
    });
    on<DecrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(
          CounterStateInvalidNumber(
            invalidValue: event.value,
            previousVlaue: state.value,
          ),
        );
      } else {
        emit(CounterstateValid(state.value - integer));
      }
    });
  }
}
