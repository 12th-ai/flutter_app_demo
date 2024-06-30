import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles/style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _message = '';

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _message = 'Passwords do not match';
      });
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Dummy registration for demonstration
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('username', _usernameController.text);
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: kTextFieldDecoration.copyWith(labelText: 'Username'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: kTextFieldDecoration.copyWith(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                decoration: kTextFieldDecoration.copyWith(labelText: 'Confirm Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: kButtonStyle,
                onPressed: _register,
                child: const Text('Register'),
              ),
              const SizedBox(height: 8),
              Text(_message, style: const TextStyle(color: Colors.red)),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Already have an account? Login', style: kLinkStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
