import 'package:flutter/material.dart';

class ProductDataModel extends ChangeNotifier {
  final String? id;
  final String? name;
  final String? price;
  final String? image;

  ProductDataModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.image});
}
