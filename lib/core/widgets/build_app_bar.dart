import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    title: const Text('Add Product'),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.white,
  );
}
