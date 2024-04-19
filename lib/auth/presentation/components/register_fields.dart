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
import '../controller/Register_controller/Register_cubit.dart';
import '../controller/register_controller/register_states.dart';
import 'MainTextFormField.dart';
import 'main_button.dart';

class FormRegisterFields extends StatelessWidget {

  const FormRegisterFields({super.key});
  static final _formKey = GlobalKey<FormState>();
  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();
  static final _confirmPassController = TextEditingController();
  static final _userController = TextEditingController();
  @override
  build(BuildContext context) {
    return  BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState)
        {
          showToast(text: AppStrings.RegSucces, state: ToastStates.SUCCESS);
          _emailController.text = '';
          _passwordController.text = '';

          showToast(text: AppStrings.pleaseLog, state: ToastStates.SUCCESS);

        } else if (state is RegisterErrorState) {
          showToast(text: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              MainTextFormField(
                controller: _userController,
                label: AppStrings.userName,
                hint: AppStrings.userName,
                hintColor: ColorManager.lightGrey,
                inputType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.person_outline_outlined),
                isObsecured: false,
                validator: (value) => validateEmail(value!),
              ),
              SizedBox(height: mediaQueryHeight(context) / AppSize.s30),
              MainTextFormField(
                controller: _emailController,
                label: AppStrings.email,
                hint: AppStrings.email,
                hintColor: ColorManager.lightGrey,
                inputType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_rounded),
                isObsecured: false,
                validator: (value) => validateEmail(value!),
              ),
              SizedBox(height: mediaQueryHeight(context) / AppSize.s30),
              MainTextFormField(
                isObsecured: RegisterCubit.get(context).isObsecured,
                suffixIcon: IconButton(
                  color: Colors.white,
                  icon: RegisterCubit.get(context).isObsecured
                      ? const Icon(
                    Icons.visibility_off,
                    color: ColorManager.blue,
                  )
                      : const Icon(
                    Icons.visibility,
                    color: ColorManager.blue,
                  ),
                  onPressed: () {
                    RegisterCubit.get(context).changeVisibility();
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
              MainTextFormField(
                isObsecured: RegisterCubit.get(context).isObsecured,
                suffixIcon: IconButton(
                  color: Colors.white,
                  icon: RegisterCubit.get(context).isObsecured
                      ? const Icon(
                    Icons.visibility_off,
                    color: ColorManager.blue,
                  )
                      : const Icon(
                    Icons.visibility,
                    color: ColorManager.blue,
                  ),
                  onPressed: () {
                    RegisterCubit.get(context).changeVisibility();
                  },
                ),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: ColorManager.blue,
                ),
                controller: _confirmPassController,
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
                condition: (state is RegisterLoadingState),
                builder: (context) => const CircularProgressIndicator(),
                fallback: (context) => MainButton(
                  title:  AppStrings.register,
                  color: ColorManager.primary,
                  onPressed: () {


                    // Perform Register action
                    RegisterCubit.get(context).userRegister(
                      email: _emailController.text.trim(),
                      password: _passwordController.text,
                    );


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

