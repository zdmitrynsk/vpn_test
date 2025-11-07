// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class AddVpnButton extends StatelessWidget {
  const AddVpnButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(theme.primaryColor),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            minimumSize: const WidgetStatePropertyAll(Size.fromHeight(70)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
          onPressed: () {},
          child: Text('Добавить ключ',
              style: theme.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
