import 'package:flutter/material.dart';

class StarButton extends StatefulWidget {
  const StarButton({super.key});

  @override
  State<StarButton> createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> {
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: state ? 1 : 0,
      curve: Curves.decelerate,
      duration: const Duration(milliseconds: 300),
      child: FloatingActionButton(
        elevation: 0,
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.surface,
        onPressed: () => setState(() {
          state = !state;
        }),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            state ? Icons.star : Icons.star_outline,
            color: Colors.grey,
            size: 20,
          ),
        ),
      ),
    );
  }
}
