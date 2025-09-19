import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/helper/spacing.dart';
import 'package:fruits_hub_dashboard/core/theming/styles.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          const Icon(Icons.filter),
          horizontalSpace(16),
          Text("Filters", style: TextStyles.font23BlackBold),
        ],
      ),
    );
  }
}
