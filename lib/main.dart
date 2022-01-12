import 'package:bt_test_app/dependency_injection_container.dart';
import 'package:bt_test_app/features/top_team/domain/export.dart';
import 'package:bt_test_app/features/top_team/presentation/app_provider.dart';
import 'package:bt_test_app/features/top_team/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(
          GetIt.I<FetchMatchesUseCase>(), GetIt.I<GetTeamUseCase>()),
      child: MaterialApp(
        title: 'BT test',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const MyHomePage(title: 'BT Test'),
      ),
    );
  }
}
