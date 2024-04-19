import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/data/models/login_model/login_model.dart';
import '../../../../shared/local/shared_preference.dart';
import '../../../../shared/network/api_constants.dart';
import '../../../../shared/network/dio_helper.dart';
import '../../../../shared/resources/app_strings.dart';

import '../../../../shared/resources/constants_manager.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      final response = await DioHelper.postDataFromFormData(
        url: ApiConstants.login,
        data: {
          'username': email,
          'password': password,
        },
      );

      // Assuming your API response contains a token
      final token = response.data['token'];
      // Create a login model using the email, password, and token
      final loginModel = LoginModel(
        username: email,
        password: password,
        token: token,
      );
    // Save the username and token
    await CacheHelper.setData(key: AppConstants.userName, value: email);
    await CacheHelper.setData(key: AppConstants.token, value: token);

      emit(LoginSuccessState(loginModel));
    } catch (error) {
      print('error.toString()');
      print(error.toString());
      emit(LoginErrorState(AppStrings.loginError));
    }
  }

  void validate() {
    emit(ValidateLoadingState());
    DioHelper.getData(url: ApiConstants.validate,
      token: CacheHelper.getData(key: AppConstants.token),
    ).then((value) {
      print(value.data);
      emit(ValidateLoginSuccessState());
    }).catchError((error) {
      emit(ValidateLoginErrorState(AppStrings.loginError));
    });
  }

  bool isObsecured = true;
  bool isExpanded = true;

  void changeVisibility() {
    isObsecured = !isObsecured;
    emit(ChangeVisibilityState(isObsecured));
  }

  void changeExpanded() {
    isExpanded = !isExpanded;
    emit(ChangeExpandedState(isExpanded));
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState(isPassword));
  }
}
