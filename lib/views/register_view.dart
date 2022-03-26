import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  late final TextEditingController _name;
  late final TextEditingController _birthday;
  bool _obscureText = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _name = TextEditingController();
    _birthday = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...[TextFormField(
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    RegExp emailValidator = RegExp(
                      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
                    );
                    if (!emailValidator.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }

                    return null;
                  },
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Your email address',
                    labelText: 'Email',
                  ),
                ),
                  TextFormField(
                    controller: _password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Your password',
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: _obscureText ? const Icon(Icons.visibility_off) : const Icon(Icons.remove_red_eye),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _confirmPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Confirm your password',
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: _obscureText ? const Icon(Icons.visibility_off) : const Icon(Icons.remove_red_eye),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final username = _email.text;
                      final password = _password.text;

                      _formKey.currentState?.validate();
                      // TODO: Show dialog with error message
                      // _showDialog('Network Error \n Please check your network connection');

                      print('$username, $password');
                    },
                    child: const Text('Register'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text('Sign in'),
                      ),
                    ],
                  ),
                ].expand((widget) => [widget, const SizedBox(height: 20.0)]),]
          ),
        ),
      ),    );
  }
  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
