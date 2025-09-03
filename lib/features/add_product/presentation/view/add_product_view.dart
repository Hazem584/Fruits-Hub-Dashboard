import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboaerd/core/widgets/build_app_bar.dart';
import 'package:fruits_hub_dashboaerd/features/add_product/presentation/view/widgets/add_product_view_body.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});
  static const String routeName = 'add_product';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: AddProductViewBody(),
    );
  }
}
