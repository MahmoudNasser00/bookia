import 'package:bookia/features/auth/models/registar_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../models/login_model.dart';

class AuthCubit extends Cubit<String> {
  final ApiClient api = ApiClient();

  AuthCubit() : super("initial");

  // login
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

  // logout
  Future logout() async {
    await api.post(ApiConstants.logout);
  }

  // register
  Future<RegistarModel?> register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    emit("loading");

    try {
      final response = await api.post(
        ApiConstants.register,
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

  // verify email
  Future<bool> verifyEmail(String code) async {
    emit("loading");

    try {
      await api.post(ApiConstants.verifyEmail, data: {"verify_code": code});

      emit("success");
      return true;
    } catch (e) {
      emit("error");
      return false;
    }
  }

  // resend verify code
  Future<bool> resendVerifyCode() async {
    try {
      await api.get(ApiConstants.resendVerifyCode);
      print("ok");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // forget password
  Future forgetPassword(String email) async {
    emit("loading");

    try {
      await api.post(ApiConstants.forgetPassword, data: {"email": email});
      emit("success");
    } catch (e) {
      print("error is ${e}");
      emit("error");
    }
  }

  // check forget password
  Future checkForgetPassword(String email, String code) async {
    emit("loading");

    try {
      await api.post(
        ApiConstants.checkForgetPassword,
        data: {"email": email, "verify_code": code},
      );

      emit("success");
    } catch (e) {
      emit("error");
    }
  }

  // reset password
  Future resetPassword(
    String code,
    String password,
    String confirmPassword,
  ) async {
    emit("loading");

    try {
      await api.post(
        ApiConstants.resetPassword,
        data: {
          "verify_code": code,
          "new_password": password,
          "new_password_confirmation": confirmPassword,
        },
      );

      emit("success");
    } catch (e) {
      emit("error");
    }
  }
}
