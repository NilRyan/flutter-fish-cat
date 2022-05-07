import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../storage/secure_storage.dart';
import 'login_view.dart';
import 'main_view.dart';

class RegisterView extends HookWidget {
  RegisterView({Key? key}) : super(key: key);
  static const String routeName = '/register';
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: '');
    final nameController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final confirmPasswordController = useTextEditingController(text: '');
    final _birthday = useState('');

    final loginMutation = useMutation(MutationOptions(
      document: gql(
        '''
          mutation Login(\$email: String!, \$password: String!) {
            login(loginInput: {email: \$email, password: \$password}) {
              accessToken
              refreshToken
            }
          }
          ''',
      ),
      onError: (err) {
        print(err);
      },
      onCompleted: (dynamic data) async {
        if (data != null) {
          final accessToken = data['login']['accessToken'];
          await SecureStorage.setToken(accessToken);
          Navigator.pushNamed(context, MainView.routeName);
        } else {
          print('Something wrong has occured. Please try again');
        }
      },
    ));
    final registerMutation = useMutation(MutationOptions(
      document: gql(
        '''
          mutation Register(\$email: String!, \$password: String!, \$name: String!, \$birthDate: DateTime!, \$aboutMe: String!) {
            register(registerUserInput: {email: \$email, password: \$password, name: \$name, birthDate: \$birthDate, aboutMe: \$aboutMe}) {
              id
              email
              birthDate
              aboutMe
              name
            }
          }
          ''',
      ),
      onError: (err) {
        print(err);
      },
      onCompleted: (dynamic data) async {
        if (data != null) {
          final name = data['register']['name'];
          loginMutation.runMutation({
            'email': emailController.text,
            'password': passwordController.text,
          });
          print(name);
        } else {
          print('Something wrong has occured. Please try again');
        }
      },
    ));


    final _areFieldsEmpty = useState<bool>(true);
    final _obscureText = useState<bool>(true);

    bool areFieldsEmpty() {
      return emailController.text.toString().isEmpty ||
          nameController.text.toString().isEmpty ||
          passwordController.text.toString().isEmpty ||
          confirmPasswordController.text.toString().isEmpty ||
          _birthday.value.isEmpty;
    }
    useEffect(() {
      emailController.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      passwordController.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      nameController.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      confirmPasswordController.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      _birthday.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      return null;
    }, [
      emailController,
      passwordController,
      nameController,
      confirmPasswordController,
      _birthday
    ]);



    void _toggleObscureText() {
      _obscureText.value = !_obscureText.value;
    }


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
                ...[ TextFormField(
                  controller: emailController,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Your name',
                      labelText: 'Name',
                    ),
                  ),
                  InputDatePickerFormField(
                      onDateSaved: (value) {
                        _birthday.value = value.toIso8601String();
                      },
                      firstDate: DateTime.utc(1903), lastDate: DateTime.now()),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscureText.value,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Your password',
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: _obscureText.value
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.remove_red_eye),
                        onPressed: _toggleObscureText,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }

                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscureText.value,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Confirm your password',
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: _obscureText.value ? const Icon(Icons.visibility_off) : const Icon(
                            Icons.remove_red_eye),
                        onPressed: _toggleObscureText,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState?.validate();
                      _formKey.currentState?.save();

                      registerMutation.runMutation({
                        'email': emailController.text,
                        'password': passwordController.text,
                        'birthDate': _birthday.value,
                        'name': nameController.text,
                        'aboutMe': 'Default aboutMe cause I made a mistake making this field required'
                      });

                      // TODO: Show dialog with error message
                      // _showDialog('Network Error \n Please check your network connection');

                      // print('$username, $password, $birthday, $name');
                    },
                    child: const Text('Register'),
                  ),
                  signIn(context),
                ].expand((widget) => [widget, const SizedBox(height: 20.0)]),
              ]
          ),
        ),
      ),);
  }

  // NOTE: Still unsure if using functional widgets is the best way to do this
  Row signIn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?'),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, LoginView.routeName);
          },
          child: const Text('Sign in'),
        ),
      ],
    );
  }





}
