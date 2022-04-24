import 'package:fish_cat/views/main_view.dart';
import 'package:fish_cat/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginView extends HookWidget {
  final _formKey = GlobalKey<FormState>();
  LoginView({Key? key}) : super(key: key);

  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
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
      onCompleted: (dynamic data) {
        if (data != null) {
          print(data);
          Navigator.pushNamed(context, MainView.routeName);
        }
        ;
      },
    ));

    final _areFieldsEmpty = useState<bool>(true);
    final _obscureText = useState<bool>(true);
    bool areFieldsEmpty() {
      return emailController.text.toString().isEmpty ||
          passwordController.text.toString().isEmpty;
    }

    void _toggleObscureText() {
      _obscureText.value = !_obscureText.value;
    }

    useEffect(() {
      emailController.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      passwordController.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      return null;
    }, [
      emailController,
      passwordController,
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // TODO: Add a background image for FishCat
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ...[
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address';
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
              _areFieldsEmpty.value
                  ? const ElevatedButton(onPressed: null, child: Text('Login'))
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, MainView.routeName);
                        }
                        ;
                        // TODO: Show dialog with error message
                        // _showDialog('Network Error \n Please check your network connection');
                        loginMutation.runMutation({
                          'email': emailController.text,
                          'password': passwordController.text,
                        });
                      },
                      child: const Text('Login'),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterView.routeName);
                    },
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ].expand((widget) => [widget, const SizedBox(height: 20.0)]),
          ]),
        ),
      ),
    );
  }
  // void _showDialog(String message) {
  //   showDialog<void>(
  //     builder: (context) => AlertDialog(
  //       title: Text(message),
  //       actions: [
  //         TextButton(
  //           child: const Text('OK'),
  //           onPressed: () => Navigator.of(context).pop(),
  //         ),
  //       ],
  //     ),
  //   );
}
