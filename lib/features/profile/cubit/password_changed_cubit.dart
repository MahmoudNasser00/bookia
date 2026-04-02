import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'password_changed_state.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';

class PasswordChangedCubit extends Cubit<PasswordChangedState> {
  PasswordChangedCubit() : super(PasswordChangedInitial());

  final ApiClient apiClient = ApiClient();

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(PasswordChangedLoading());

    try {
      final response = await apiClient.post(
        ApiConstants.updatePassword,
        data: {
          "current_password": currentPassword,
          "new_password": newPassword,
          "new_password_confirmation": confirmPassword,
        },
      );

      emit(
        PasswordChangedSuccess(
          response.data["message"] ?? "Password updated successfully",
        ),
      );
    } on DioException catch (e) {
      emit(
        PasswordChangedError(
          e.response?.data["message"] ?? "Something went wrong",
        ),
      );
    } catch (e) {
      emit(PasswordChangedError(e.toString()));
    }
  }
}
