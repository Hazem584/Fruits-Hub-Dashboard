import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboaerd/core/helper/spacing.dart';
import 'package:fruits_hub_dashboaerd/core/theming/styles.dart';
import 'package:fruits_hub_dashboaerd/features/add_product/presentation/view/widgets/custom_check_box.dart';

class IsFeaturedCheckBox extends StatelessWidget {
  final bool isAccepted;
  final ValueChanged<bool> onChanged;

  const IsFeaturedCheckBox({
    super.key,
    required this.isAccepted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(value: isAccepted, onChanged: onChanged),
        horizontalSpace(8),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Is Featured Item ?',
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
