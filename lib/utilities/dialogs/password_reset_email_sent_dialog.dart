import 'package:flutter/material.dart';
import 'package:mynotesapp/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) async {
  return showGenericDialog(
    context: context,
    title: 'Passowrd Reset',
    content:
        'We have now sent you a password reset email. Please check your email for more information.',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
