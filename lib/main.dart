import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckPassword(),
    );
  }
}

class CheckPassword extends StatefulWidget {
  const CheckPassword({super.key});

  @override
  State<CheckPassword> createState() => _CheckPasswordState();
}

class _CheckPasswordState extends State<CheckPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  // Color unAbleToConfirmButtonColor = Colors.lightBlueAccent;
  // Color ableToConfirmButtonColor = Colors.blue;
  String password = '';
  String repeatPassword = '';
  bool isPasswordsGood(String password, String checkPassword) {
    return password.length >= 8 &&
        // checkPassword.length >= 8 &&
        password == checkPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
        children: [
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            hintText: 'Enter your password',
          ),
          onSubmitted: (value) {  // Без этого свойства у меня не передергивался build и кнопка не становилась активная.
            setState(() {
              password = value;
            });
          },
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Repeat your password',
          ),
          controller: passwordConfirmController,
          onSubmitted: (value) {
            setState(() {
              repeatPassword = value;
            });
          },
        ),
        const SizedBox(height: 20,),
        ElevatedButton(
          onPressed: isPasswordsGood(password, repeatPassword) // Без onSubmitted здесь передавала параметры passwordConfirmController.text and passwordController.text
              ? () {
                  setState(() {
                    showOK(context);
                  });
                }
              : null,
          child: const Text(
            'Confirm',
            style: TextStyle(fontSize: 25),
          ),
        ),
        ],
      ),
      ),
    );
  }

  Future<AlertDialog?> showOK(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('The password is correct'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                passwordController.clear();
                passwordConfirmController.clear();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}
