import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/profile_model.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';

class ProfileCubit extends Cubit<ProfileModel?> {
  final ApiClient api = ApiClient();

  ProfileCubit() : super(null);

  Future<void> fetchProfile() async {
    try {
      final response = await api.get(ApiConstants.profile);

      final data = response.data["data"];

      emit(ProfileModel.fromJson(data));
    } catch (e) {
      print("PROFILE ERROR: $e");
    }
  }
}
