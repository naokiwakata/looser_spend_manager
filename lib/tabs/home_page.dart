import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../app_router.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Home Page',
            ),
            ElevatedButton(
                onPressed: () {
                  context.router.push(const SettingsRoute());
                },
                child: const Text("data"))
          ],
        ),
      ),
    );
  }
}
