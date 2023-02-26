import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:internship_project/services/auth.dart';

class dashboard extends StatelessWidget {
  const dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text("Welcome!!"),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Authentication.logout();
                },
                child: Text('Log Out'))
          ],
        ),
      ),
    );
  }
}
