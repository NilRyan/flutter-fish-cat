import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginMutation extends HookWidget {
  const LoginMutation({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginMutation = useMutation(
      MutationOptions(
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
          print(data);
        },
        )
      );
    return ElevatedButton(
      onPressed: () => loginMutation.runMutation({
      'email': 'philipz@gmail.com',
      'password': 'HAHAHA123',
      }),
      child: const Text('Login'),
    );

  }
}
