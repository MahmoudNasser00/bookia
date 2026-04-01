import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../models/edit_model.dart';

class EditCubit extends Cubit<EditModel?> {
  final ApiClient api = ApiClient();

  EditCubit() : super(null);

  Future<void> fetchProfile() async {
    try {
      final response = await api.get(ApiConstants.profile);

      final data = response.data["data"];

      emit(EditModel.fromJson(data));
    } catch (e) {
      print("Profile ERROR: $e");
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String address,
    File? image,
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "phone": phone,
      "address": address,
      if (image != null) "image": await MultipartFile.fromFile(image.path),
    });

    await api.dio.post(ApiConstants.updateProfile, data: formData);

    await fetchProfile();
  }
}
