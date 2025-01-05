import 'package:flutter/material.dart';
import 'package:meals/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  //sign up button pressed

  void signUp() async {
//prepare data
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    //check if passwords match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    //atempt sign up..
    try {
      await authService.signUpWithEmailPassword(email, password);

      //pop the register page
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      backgroundColor: Colors.white, // Set the background color to white
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        children: [
          //email
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),

          //password
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: "Password"),
          ),

          //confirm password
          TextField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
                labelText: "Confirm Password"), // Corrected controller
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: signUp,
            child: const Text("Sign Up"),
          ),
          const SizedBox(height: 16),
          //go to register page to sign up
        ],
      ),
    );
  }
}
