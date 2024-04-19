import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/toast_component.dart';
import '../../../shared/resources/app_strings.dart';
import '../../../shared/resources/color_manager.dart';
import '../../../shared/resources/navigation.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/text_field_validation.dart';
import '../../../shared/resources/values_manager.dart';
import '../controller/login_controller/login_cubit.dart';
import '../controller/login_controller/login_states.dart';
import 'MainTextFormField.dart';
import 'main_button.dart';
class FormLoginFields extends StatelessWidget {
  const FormLoginFields({super.key});
  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();
  static final _formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState)
        {
          showToast(text: AppStrings.logSucces, state: ToastStates.SUCCESS);
          _emailController.text = '';
          _passwordController.text = '';

          navigateFinalTo(
              context: context, screenRoute: Routes.homeScreenRoute);
        } else if (state is LoginErrorState) {
          showToast(text: state.error, state: ToastStates.ERROR);
        }
        if (state is ValidateLoginSuccessState)
        {
          showToast(text: AppStrings.validateSucces, state: ToastStates.SUCCESS);

        } else if (state is ValidateLoginErrorState) {
          showToast(text: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
      return Form(
        key: _formKey1,
        child: Column(
          children: [
            MainTextFormField(
              controller: _emailController,
              label: AppStrings.email,
              hintColor: ColorManager.lightGrey,
              inputType: TextInputType.emailAddress,
              prefixIcon: Icon(Icons.email_rounded),
              isObsecured: false,
              validator: (value) => validateEmail(value!),
            ),
            SizedBox(height: mediaQueryHeight(context) / AppSize.s30),
            MainTextFormField(
              isObsecured: LoginCubit.get(context).isObsecured,
              suffixIcon: IconButton(
                color: Colors.white,
                icon: LoginCubit.get(context).isObsecured
                    ? const Icon(
                  Icons.visibility_off,
                  color: ColorManager.blue,
                )
                    : const Icon(
                  Icons.visibility,
                  color: ColorManager.blue,
                ),
                onPressed: () {
                  LoginCubit.get(context).changeVisibility();
                },
              ),
              prefixIcon: const Icon(
                Icons.lock,
                color: ColorManager.blue,
              ),
              controller: _passwordController,
              label: AppStrings.password,
              hint: AppStrings.passwordExample,
              hintColor: ColorManager.lightGrey,
              inputType: TextInputType.visiblePassword,
              validator: (value) {
                if (value!.length < AppSize.s8) {
                  return AppStrings.enterValidPassword;
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: mediaQueryHeight(context) / AppSize.s30),
            ConditionalBuilder(
              condition: (state is LoginLoadingState),
              builder: (context) => const CircularProgressIndicator(),
              fallback: (context) => MainButton(
                title:  AppStrings.submit,
                color: ColorManager.primary,
                onPressed: () {


                  // Perform login action
                  LoginCubit.get(context).userLogin(
                    email: _emailController.text.trim(),
                    password: _passwordController.text,
                  );
                  //perform validation
                  LoginCubit.get(context).validate();


                },
              ),
            ),
          ],
        ),
      );
      },
    );
  }
}



