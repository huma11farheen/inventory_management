import 'package:flutter/material.dart';
import 'package:inventory_management/data/repositories/account_repository.dart';
import 'package:inventory_management/data/repositories/supplier/supplier_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// A provider for repositories.
class RepositoriesProvider extends SingleChildStatelessWidget {
  const RepositoriesProvider({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return MultiProvider(
      providers: [
        Provider.value(value: const AccountRepository()),
        Provider.value(value: SupplierRepository()),
      ],
      child: child,
    );
  }
}
