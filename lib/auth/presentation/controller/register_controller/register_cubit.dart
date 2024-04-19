import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakas/auth/presentation/controller/register_controller/register_states.dart';
import '../../../../shared/network/api_constants.dart';
import '../../../../shared/network/dio_helper.dart';



class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  Future<void> userRegister({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    await DioHelper.postDataFromFormData(
      url: ApiConstants.register,
      data: {
        'username': email,
        'password': password
      },
    ).then((value) {
      print(value.data.toString());
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
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
