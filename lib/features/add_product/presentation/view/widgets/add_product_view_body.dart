import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboaerd/core/helper/spacing.dart';
import 'package:fruits_hub_dashboaerd/features/add_product/presentation/view/widgets/app_text_form_filed.dart';
import 'package:fruits_hub_dashboaerd/features/add_product/presentation/view/widgets/image_filed.dart';

class AddProductViewBody extends StatefulWidget {
  const AddProductViewBody({super.key});

  @override
  State<AddProductViewBody> createState() => _AddProductViewBodyState();
}

class _AddProductViewBodyState extends State<AddProductViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            children: [
              AppTextFormFiled(
                hintText: 'Product Name',
                keyboardType: TextInputType.text,
              ),
              verticalSpace(16),
              AppTextFormFiled(
                hintText: 'Product Price',
                keyboardType: TextInputType.number,
              ),
              verticalSpace(16),
              AppTextFormFiled(hintText: 'Product Code'),
              verticalSpace(16),
              AppTextFormFiled(
                hintText: 'Product Description',
                maxLines: 5,
                keyboardType: TextInputType.text,
              ),
              verticalSpace(16),
              ImageFiled(onFileChanged: (image){},),
            ],
          ),
        ),
      ),
    );
  }
}
