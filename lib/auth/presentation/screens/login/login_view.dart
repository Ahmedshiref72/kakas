import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/presentation/controller/login_controller/login_cubit.dart';
import '../../../../shared/resources/app_strings.dart';
import '../../../../shared/resources/values_manager.dart';
import '../../components/divider_with_text.dart';
import '../../components/login_fields.dart';
import '../../components/register_fields.dart';
import '../../components/signwith.dart';
import '../../components/text_of_dont_have_account.dart';
import '../../controller/login_controller/login_states.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    AppStrings.appTitle,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(
                    height: mediaQueryHeight(context) * .04,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    AppStrings.login,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w800, color: Colors.black),
                  ),
                  SizedBox(height: mediaQueryHeight(context) / AppSize.s30),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 500),
                    firstChild:FormRegisterFields(),
                    secondChild: FormLoginFields(),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                  ),


                  const DividerWithText(
                    text: AppStrings.orSingUp,
                  ),
                  SizedBox(height: mediaQueryHeight(context) / AppSize.s100),
                  const SignWithOther(),
                  TextOfDontHaveAccount(
                    text: AppStrings.register,
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
