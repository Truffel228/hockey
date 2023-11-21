// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ContainerPrediction extends StatelessWidget {
  final double index;
  final Color colorBack;
  final Color colorText;

  const ContainerPrediction(
      {super.key,
      required this.index,
      required this.colorBack,
      required this.colorText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * .3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: colorBack,
        ),
        child: Center(
          child: Text(
            index.toStringAsFixed(2),
            style: TextStyle(color: colorText, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
