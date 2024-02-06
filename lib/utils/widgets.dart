import 'package:flutter/material.dart';

class ShowMore extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const ShowMore({super.key, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: const Text('See all'),
        )
      ],
    );
  }
}
