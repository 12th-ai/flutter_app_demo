import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = '';

  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Dummy check for demonstration
    if (_usernameController.text == 'user' && _passwordController.text == 'pass') {
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', _usernameController.text);
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      setState(() {
        _message = 'Invalid username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
              ElevatedButton(
                style: kButtonStyle,
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 8),
              Text(_message, style: const TextStyle(color: Colors.red)),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Don\'t have an account? Register', style: kLinkStyle),
              ),
            ],
          ), 
        ),
      ),
    );
  }
}
