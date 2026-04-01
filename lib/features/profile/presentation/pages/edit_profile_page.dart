import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/core/helpers/validations/app_form_validations.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:bookia/core/widget/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/generated/locale_keys.g.dart';
import '../../../../core/widget/custom_appbar.dart';
import '../../cubit/edit_cubit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../cubit/edit_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? selectedImage;

  Future<File> compressImage(File file) async {
    final targetPath =
        "${file.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg";

    final result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 70,
      minWidth: 800,
      minHeight: 800,
    );

    if (result == null) return file;

    return File(result.path);
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (image != null) {
      File compressed = await compressImage(File(image.path));

      setState(() {
        selectedImage = compressed;
      });
    }
  }

  Future<void> pickImageSource() async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditCubit>().fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditCubit, EditState>(
      listener: (context, state) {
        if (state is EditSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        }

        if (state is EditError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomAppBar(
              onBackPressed: () => Navigator.pop(context),
              title: LocaleKeys.edit_profile.tr(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: .max,
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .center,
                    children: [
                      SizedBox(height: 54.h),

                      InkWell(
                        onTap: pickImageSource,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60.w,
                              backgroundImage: selectedImage != null
                                  ? FileImage(selectedImage!)
                                  : null,
                              backgroundColor: Colors.grey.shade200,
                              child: selectedImage == null
                                  ? Icon(Icons.person, size: 40.sp)
                                  : null,
                            ),
                            Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.primary_button_color,
                              size: 21.sp,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 54.h),
                      // name
                      CustomTextfield(
                        hintText: LocaleKeys.full_name.tr(),
                        controller: nameController,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 12.h),
                      // phone
                      CustomTextfield(
                        hintText: LocaleKeys.phone.tr(),
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: AppFormValidations.phoneFormatter,
                        validator: AppFormValidations.phoneValidator,
                      ),
                      SizedBox(height: 12.h),
                      // address
                      CustomTextfield(
                        hintText: LocaleKeys.address.tr(),
                        controller: addressController,
                        keyboardType: TextInputType.streetAddress,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 22.h, left: 26.w, right: 26.w),
          child: BlocBuilder<EditCubit, EditState>(
            builder: (context, state) {
              return CustomButton(
                text: state is EditLoading
                    ? "Updating..."
                    : LocaleKeys.update_profile.tr(),
                color: AppColors.primary_button_color,
                textColor: AppColors.white,
                width: 331.w,
                height: 56.h,
                onPressed: state is EditLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          context.read<EditCubit>().updateProfile(
                            name: nameController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                            image: selectedImage,
                          );
                        }
                      },
              );
            },
          ),
        ),
      ),
    );
  }
}
