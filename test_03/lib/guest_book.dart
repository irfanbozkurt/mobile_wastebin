import 'dart:async';

import 'package:flutter/material.dart';

import 'src/widgets.dart';

import 'guest_book_message.dart';

class GuestBook extends StatefulWidget {
  const GuestBook(
      {required this.addMessage, required this.messages, super.key});

  final FutureOr<void> Function(String message) addMessage;
  final List<GuestBookMessage> messages;

  @override
  State<GuestBook> createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Leave a message',
                    ),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Enter your message to continue'
                        : null,
                  ),
                ),
                const SizedBox(width: 8),
                StyledButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;
                    await widget.addMessage(_controller.text);
                    _controller.clear();
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.send),
                      SizedBox(width: 4),
                      Text('SEND'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ...widget.messages
            .map((msg) => Paragraph('${msg.name}: ${msg.message}')),
        const SizedBox(
          width: 8,
        )
      ],
    );
  }
}
