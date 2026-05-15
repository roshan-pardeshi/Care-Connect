import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _phone = '';
  bool _isOTPLogin = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CareConnect Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to CareConnect',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => _isOTPLogin = false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_isOTPLogin ? Colors.blue : Colors.grey,
                    ),
                    child: const Text('Child Login'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => setState(() => _isOTPLogin = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isOTPLogin ? Colors.blue : Colors.grey,
                    ),
                    child: const Text('Parent Login'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (!_isOTPLogin) ...[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => value!.isEmpty ? 'Enter email' : null,
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? 'Enter password' : null,
                  onSaved: (value) => _password = value!,
                ),
              ] else ...[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
                  onSaved: (value) => _phone = value!,
                ),
              ],
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _login,
                  child: Text(_isOTPLogin ? 'Send OTP' : 'Login'),
                ),
              TextButton(
                onPressed: _isOTPLogin ? null : () => Navigator.pushNamed(context, '/signup'),
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isLoading = true);
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (_isOTPLogin) {
        await authProvider.signInWithOTP(_phone);
      } else {
        await authProvider.signInWithEmail(_email, _password);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
    setState(() => _isLoading = false);
  }
}