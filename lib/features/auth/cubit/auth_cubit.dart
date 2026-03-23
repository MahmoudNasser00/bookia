import 'package:bookia/features/auth/models/registar_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../models/login_model.dart';

class AuthCubit extends Cubit<String> {
  final ApiClient api = ApiClient();

  AuthCubit() : super("initial");

  Future<LoginModel?> login(String email, String password) async {
    emit("loading");

    try {
      final response = await api.post(
        ApiConstants.login,
        data: {"email": email, "password": password},
      );

      final user = LoginModel.fromJson(response.data);

      emit("success");
      return user;
    } catch (e) {
      emit("error");
      return null;
    }
  }

  Future<RegistarModel?> registar(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    emit("loading");

    try {
      final response = await api.post(
        ApiConstants.login,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );

      final user = RegistarModel.fromJson(response.data);

      emit("success");
      return user;
    } catch (e) {
      emit("error");
      return null;
    }
  }
}
