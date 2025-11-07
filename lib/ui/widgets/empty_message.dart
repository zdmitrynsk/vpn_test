import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message(
    String this._title,
    String this._message, {
    super.key,
  });

  final String _title;
  final String _message;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
          child: Column(
        children: [
          Text(
            _title,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            _message,
            style: theme.textTheme.bodyMedium!.copyWith(color: theme.hintColor),
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}
