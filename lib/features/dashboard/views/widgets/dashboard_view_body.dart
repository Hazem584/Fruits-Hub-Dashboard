import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboaerd/core/theming/styles.dart';
import 'package:fruits_hub_dashboaerd/core/widgets/app_text_button.dart';
import 'package:fruits_hub_dashboaerd/features/add_product/presentation/view/add_product_view.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextButton(
            buttonText: "Add Data",
            textStyle: TextStyles.font15WhiteBold,
            onPressed: () {
              Navigator.pushNamed(context, AddProductView.routeName);
            },
          ),
        ],
      ),
    );
  }
}
