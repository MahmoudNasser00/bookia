import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../models/edit_model.dart';
import 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  final ApiClient api = ApiClient();

  EditCubit() : super(EditInitial());

  EditModel? profile;

  Future<void> fetchProfile() async {
    try {
      final response = await api.get(ApiConstants.profile);

      final data = response.data["data"];

      profile = EditModel.fromJson(data);

      emit(EditInitial());
    } catch (e) {
      emit(EditError("Failed to load profile"));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String address,
    File? image,
  }) async {
    try {
      emit(EditLoading());

      FormData formData = FormData.fromMap({
        "name": name,
        "phone": phone,
        "address": address,
        if (image != null) "image": await MultipartFile.fromFile(image.path),
      });

      await api.dio.post(ApiConstants.updateProfile, data: formData);

      emit(EditSuccess());
    } catch (e) {
      emit(EditError("Update failed"));
    }
  }
}
