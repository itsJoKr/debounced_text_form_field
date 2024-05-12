import 'package:debounced_text_form_field/debounced_text_form_field.dart';
import 'package:example/validator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Debounce Text Form Field'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: DebouncedFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter email',
                  prefixIcon: Icon(Icons.mail),
                ),
                validator: Validator.mustBeEmail(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
