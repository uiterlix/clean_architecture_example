import 'package:clean_architecture_example/main.config.dart';
import 'package:clean_architecture_example/user/interface_adapters/presentation/user_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => getIt.init();

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List',
      home: UserListWidget(),
    );
  }
}