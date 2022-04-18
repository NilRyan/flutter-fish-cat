

import 'package:fish_cat/graphql/graphql_provider.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ClientProvider extends StatelessWidget {
  ClientProvider({Key? key,
    required this.child,
    required String this.uri,
    String? subscriptionUri,
}) : client = clientFor(uri: uri, subscriptionUri: subscriptionUri), super(key: key);
  final String uri;
  final Widget child;
  final ValueNotifier<GraphQLClient> client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: child,
    );
  }
}
