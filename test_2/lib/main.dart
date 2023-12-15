import 'package:flutter/material.dart';

void main() => runApp(const SignUpApp());

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SignUp(),
        '/welcome': (context) => const WelcomeScreen(),
      },
    );
  }
}

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: const Center(
        child: SizedBox(width: 200, child: SignUpForm()),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  // Manage form progress
  double _formProgress = 0;
  void _updateFormProgress() {
    final controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _usernameTextController
    ];
    setState(() {
      _formProgress = controllers
          .map((e) => e.value.text.isNotEmpty ? (1 / controllers.length) : 0.0)
          .reduce((value, element) => value + element);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedProgressIndicator(value: _formProgress),
          Text(
            'Sign Up',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _firstNameTextController,
              decoration: const InputDecoration(hintText: 'First name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: const InputDecoration(hintText: 'Last name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: const InputDecoration(hintText: 'Username'),
            ),
          ),
          TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.white;
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : _formProgress == 1
                          ? Colors.blue
                          : Colors.grey;
                }),
              ),
              onPressed: () => _formProgress == 1
                  ? Navigator.of(context).pushNamed('/welcome')
                  : null,
              child: const Text("Sign Up"))
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Text('Welcome!', style: Theme.of(context).textTheme.displayMedium),
      ),
    );
  }
}

class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  const AnimatedProgressIndicator({super.key, required this.value});

  @override
  State<StatefulWidget> createState() => _AnimatedProgressIndicatorState();
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController = AnimationController(
      duration: const Duration(milliseconds: 1200), vsync: this);
  late final Animation<Color?> _colorAnimation =
      _animController.drive(TweenSequence([
    TweenSequenceItem(
      tween: ColorTween(begin: Colors.red, end: Colors.orange),
      weight: 1,
    ),
    TweenSequenceItem(
      tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
      weight: 1,
    ),
    TweenSequenceItem(
      tween: ColorTween(begin: Colors.yellow, end: Colors.green),
      weight: 1,
    ),
  ]));
  late final Animation<double> _curveAnimation =
      _animController.drive(CurveTween(curve: Curves.easeIn));

  @override
  void didUpdateWidget(covariant AnimatedProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animController.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        backgroundColor: _colorAnimation.value?.withOpacity(0.2),
        valueColor: _colorAnimation,
      ),
    );
  }
}
