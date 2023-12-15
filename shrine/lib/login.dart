import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TODO: Add text editing controllers (101)
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  void clearForm() {
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: [
              const SizedBox(height: 80.0),
              Column(
                children: [
                  Image.asset('assets/diamond.png'),
                  const SizedBox(height: 16.0),
                  const Text('SHRINE'),
                ],
              ),
              const SizedBox(height: 120.0),
              // TODO: Remove filled: true values (103)
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12.0),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                children: [
                  TextButton(child: const Text('CANCEL'), onPressed: clearForm),
                  ElevatedButton(
                    child: const Text('NEXT'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
