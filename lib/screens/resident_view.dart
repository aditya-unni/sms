import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResidentView extends StatefulWidget {
  const ResidentView({Key? key}) : super(key: key);

  @override
  State<ResidentView> createState() => _ResidentViewState();
}

class _ResidentViewState extends State<ResidentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("Resident"),
    );
  }
}
