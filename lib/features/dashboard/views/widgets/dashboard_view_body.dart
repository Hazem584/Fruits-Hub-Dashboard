import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/helper/spacing.dart';
import 'package:fruits_hub_dashboard/core/theming/styles.dart';
import 'package:fruits_hub_dashboard/core/widgets/app_text_button.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/view/add_product_view.dart';
import 'package:fruits_hub_dashboard/features/orders/presentation/views/orders_view.dart';

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
          verticalSpace(18),
          AppTextButton(
            buttonText: 'View Orders',
            textStyle: TextStyles.font15WhiteBold,
            onPressed: () {
              Navigator.pushNamed(context, OrdersView.routeName);
            },
          ),
        ],
      ),
    );
  }
}
