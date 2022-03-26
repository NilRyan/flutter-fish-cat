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
  DateTime? _birthday;
  bool _obscureText = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _name.dispose();
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
                ...[emailFormField(),
                  nameFormField(),
                  birthdayFormField(),
                  passwordFormField(),
                  confirmPasswordFormField(),
                  registerButton(),
                  signIn(context),
                ].expand((widget) => [widget, const SizedBox(height: 20.0)]),]
          ),
        ),
      ),    );
  }

  Row signIn(BuildContext context) {
    return Row(
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
                );
  }

  ElevatedButton registerButton() {
    return ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.validate();
                    _formKey.currentState?.save();
                    final username = _email.text;
                    final password = _password.text;
                    final birthday = _birthday?.toUtc().toIso8601String();
                    final name = _name.text;
                    print(_formKey.currentState);
                    // TODO: Show dialog with error message
                    // _showDialog('Network Error \n Please check your network connection');

                    print('$username, $password, $birthday, $name');
                  },
                  child: const Text('Register'),
                );
  }

  TextFormField confirmPasswordFormField() {
    return TextFormField(
                  controller: _confirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }

                    if (value != _password.text) {
                      return 'Passwords do not match';
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
                );
  }

  TextFormField passwordFormField() {
    return TextFormField(
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
                );
  }

  InputDatePickerFormField birthdayFormField() {
    return InputDatePickerFormField(
                  onDateSaved: (value) {
                    _birthday = value;
                  },
                    firstDate: DateTime.utc(1903), lastDate: DateTime.now());
  }

  TextFormField nameFormField() {
    return TextFormField(
                 controller: _name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Your name',
                    labelText: 'Name',
                  ),
                );
  }

  TextFormField emailFormField() {
    return TextFormField(
                controller: _email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid email';
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
              );
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
