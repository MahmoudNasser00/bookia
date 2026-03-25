import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:bookia/core/app_routes/app_routes_name.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:bookia/core/widget/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/app_themes/app_text_styles.dart';
import '../../../../core/app_themes/colors/app_colors.dart';
import '../../../../core/helpers/validations/app_form_validations.dart';
import '../../cubit/order_cubit.dart';
import '../../models/governorate_model.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  List<GovernorateModel> governorates = [];
  GovernorateModel? selectedGovernorate;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadGovernorates();
  }

  Future<void> loadGovernorates() async {
    try {
      final cubit = context.read<OrderCubit>();

      final data = await cubit.getGovernorates();

      setState(() {
        governorates = data;
        if (governorates.isNotEmpty) {
          selectedGovernorate = governorates.first;
        }
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> submitOrder() async {
    if (!_formKey.currentState!.validate()) return;
    if (selectedGovernorate == null) return;

    final success = await context.read<OrderCubit>().placeOrder(
      governorateId: selectedGovernorate!.id,
      name: nameController.text,
      phone: phoneController.text,
      address: addressController.text,
      email: emailController.text,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order placed successfully")),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to place order")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(onBackPressed: () => Navigator.pop(context)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 29.h),
              child: Skeletonizer(
                enabled: isLoading,
                ignoreContainers: true,
                switchAnimationConfig: SwitchAnimationConfig(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 12.h,
                    mainAxisSize: .max,
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .center,
                    children: [
                      Text(
                        LocaleKeys.Place_Your_Order.tr(),
                        style: AppTextStyles.playfairDisplayLarge(
                          context,
                          fontSize: 30.sp,
                          color: AppColors.black,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      CustomTextfield(
                        hintText: LocaleKeys.full_name.tr(),
                        controller: nameController,
                        keyboardType: TextInputType.name,
                      ),

                      CustomTextfield(
                        hintText: LocaleKeys.email.tr(),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: AppFormValidations.emailValidator,
                        inputFormatters: AppFormValidations.emailFormatter,
                      ),

                      CustomTextfield(
                        hintText: LocaleKeys.address.tr(),
                        controller: addressController,
                        keyboardType: TextInputType.streetAddress,
                      ),

                      CustomTextfield(
                        hintText: LocaleKeys.phone.tr(),
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: AppFormValidations.phoneValidator,
                        inputFormatters: AppFormValidations.phoneFormatter,
                      ),

                      SizedBox(height: 15.h),

                      CustomDropdown<GovernorateModel>(
                        hintText: LocaleKeys.governorate.tr(),
                        items: isLoading
                            ? [GovernorateModel(id: 0, name: "Loading...")]
                            : governorates,
                        initialItem:
                            selectedGovernorate ??
                            (governorates.isNotEmpty
                                ? governorates.first
                                : null),

                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(item.name),
                              );
                            },

                        headerBuilder: (context, item, enabled) {
                          return Text(item.name);
                        },

                        onChanged: (value) {
                          if (governorates.isNotEmpty) {
                            selectedGovernorate = value;
                          }
                        },
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 22.w,
          right: 22.w,
          top: 29.h,
          bottom: 25.h,
        ),
        child: CustomButton(
          text: LocaleKeys.submit_order.tr(),
          color: AppColors.primary_button_color,
          textColor: AppColors.white,
          width: 331.w,
          height: 50.h,
          onPressed: governorates.isEmpty ? null : submitOrder,
        ),
      ),
    );
  }
}
