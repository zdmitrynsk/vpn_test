import 'package:flutter/material.dart';

class SubtitleVpnList extends StatelessWidget {
  final String _text;

  const SubtitleVpnList({
    super.key,
    required String text,
  }) : _text = text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _text,
                style: const TextStyle(color: Colors.white38),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
