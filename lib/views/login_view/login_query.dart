import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginQuery extends StatelessWidget {
  const LoginQuery({Key? key, required String email, required String password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(options: QueryOptions(
      document: gql(
        '''
          query Login(\$email: String!, \$password: String!) {
            login(email: \$email, password: \$password) {
              token
            }
          }
        ''',
      ),
      ),
      builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
        return ElevatedButton(
          onPressed: () {
            if (result.isLoading) {

            }


            // TODO: Show dialog with error message
            // _showDialog('Network Error \n Please check your network connection');


          },
          child: const Text('Login'),
        );
      },
    );
  }
}
