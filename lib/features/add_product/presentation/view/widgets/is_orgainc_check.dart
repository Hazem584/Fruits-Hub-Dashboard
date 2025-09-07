import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/helper/spacing.dart';
import 'package:fruits_hub_dashboard/core/theming/styles.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/view/widgets/custom_check_box.dart';

class IsOrganicCheckBox extends StatelessWidget {
  final bool isOrganic;
  final ValueChanged<bool> onChanged;

  const IsOrganicCheckBox({
    super.key,
    required this.isOrganic,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(value: isOrganic, onChanged: onChanged),
        horizontalSpace(8),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Is Organic Item ?',
                  style: TextStyles.font13lighterGrayBold,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
