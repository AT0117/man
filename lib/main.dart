import 'package:flutter/material.dart';
import 'package:man/home.dart';

void main() {
  runApp(const ModelDemo());
}

class ModelDemo extends StatefulWidget {
  const ModelDemo({super.key});

  @override
  State<ModelDemo> createState() => _ModelDemoState();
}

class _ModelDemoState extends State<ModelDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3D Model Demo',
      home: HomePage(),
    );
  }
}
