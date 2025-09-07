import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub_dashboard/core/helper/spacing.dart';
import 'package:fruits_hub_dashboard/core/theming/styles.dart';
import 'package:fruits_hub_dashboard/core/widgets/app_text_button.dart';
import 'package:fruits_hub_dashboard/features/add_product/domain/entities/add_product_input_entity.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/manger/cubit/add_product_cubit.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/view/widgets/app_text_form_filed.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/view/widgets/image_filed.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/view/widgets/is_featured_check_box.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/view/widgets/is_orgainc_check.dart';

class AddProductViewBody extends StatefulWidget {
  const AddProductViewBody({super.key});

  @override
  State<AddProductViewBody> createState() => _AddProductViewBodyState();
}

class _AddProductViewBodyState extends State<AddProductViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isFileAccepted = false;
  late String name, code, description;
  late num price;
  File? image;
  late int expirationMonths;
  late int numberOfCalories;
  late num unitAmount;
  bool isOrganic = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              AppTextFormFiled(
                onSaved: (value) {
                  name = value!;
                },
                hintText: 'Product Name',
                keyboardType: TextInputType.text,
              ),
              verticalSpace(16),
              AppTextFormFiled(
                onSaved: (value) {
                  price = num.parse(value!);
                },
                hintText: 'Product Price',
                keyboardType: TextInputType.number,
              ),
              verticalSpace(16),
              AppTextFormFiled(
                onSaved: (value) {
                  code = value!.toLowerCase();
                },
                hintText: 'Product Code',
                keyboardType: TextInputType.text,
              ),
              verticalSpace(16),
              AppTextFormFiled(
                onSaved: (value) {
                  expirationMonths = int.parse(value!);
                },
                hintText: 'Expiration Months',
                keyboardType: TextInputType.number,
              ),
              verticalSpace(16),
              AppTextFormFiled(
                onSaved: (value) {
                  numberOfCalories = int.parse(value!);
                },
                hintText: 'Number Of Calories',
                keyboardType: TextInputType.number,
              ),
              verticalSpace(16),
              AppTextFormFiled(
                onSaved: (value) {
                  unitAmount = num.parse(value!);
                },
                hintText: 'Unit Amount',
                keyboardType: TextInputType.number,
              ),
              verticalSpace(16),
              AppTextFormFiled(
                onSaved: (value) {
                  expirationMonths = int.parse(value!);
                },
                hintText: 'Expiration Months',
                keyboardType: TextInputType.number,
              ),
              verticalSpace(16),
              AppTextFormFiled(
                onSaved: (value) {
                  description = value!;
                },
                hintText: 'Product Description',
                maxLines: 5,
                keyboardType: TextInputType.text,
              ),
              verticalSpace(16),
              IsFeaturedCheckBox(
                isAccepted: isFileAccepted,
                onChanged: (value) {
                  setState(() {
                    isFileAccepted = value;
                  });
                },
              ),
              verticalSpace(16),
              IsOrganicCheckBox(
                isOrganic: isOrganic,
                onChanged: (value) {
                  setState(() {
                    isOrganic = value;
                  });
                },
              ),
              verticalSpace(10),
              ImageFiled(
                onFileChanged: (image) {
                  this.image = image;
                },
              ),
              verticalSpace(30),
              AppTextButton(
                buttonText: 'Add Product',
                textStyle: TextStyles.font15WhiteBold,
                onPressed: () {
                  if (image != null) {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      AddProductInputEntity input = AddProductInputEntity(
                        name: name,
                        description: description,
                        price: price,
                        code: code,
                        isFeatured: isFileAccepted,
                        imagePath: image!,
                        expirationMonths: expirationMonths,
                        numberOfCalories: numberOfCalories,
                        unitAmount: unitAmount.toInt(),
                        isOrganic: isOrganic,
                      );
                      context.read<AddProductCubit>().addProduct(input);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select an image')),
                    );
                  }
                },
              ),
              verticalSpace(50),
            ],
          ),
        ),
      ),
    );
  }
}
