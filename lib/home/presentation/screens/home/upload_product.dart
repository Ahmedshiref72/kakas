import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakas/shared/components/toast_component.dart';

import '../../../../auth/presentation/components/MainTextFormField.dart';
import '../../../../auth/presentation/components/main_button.dart';
import '../../../../shared/local/shared_preference.dart';
import '../../../../shared/resources/app_strings.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/constants_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../../../shared/resources/text_field_validation.dart';
import '../../../../shared/resources/values_manager.dart';
import '../../../data/models/myGallery_model/product_model.dart';
import '../../controller/home_controller/home_cubit.dart';
import '../../controller/home_controller/home_states.dart';

class UploadProductScreen extends StatelessWidget {
  const UploadProductScreen({super.key});
  static final _titleController = TextEditingController();
  static final _priceController = TextEditingController();
  static final _formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.uploadProduct,style:

          TextStyle(color: Colors.white,
          fontFamily: FontConstants.fontFamilyBaloo,
          fontSize: FontSize.s20),
            ),
        backgroundColor: ColorManager.primary,
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is PostProductSuccess) {
            showToast(text: 'Product uploaded successfully', state: ToastStates.SUCCESS);
          }
        }
        ,
        builder: (context, state) {
          return Form(
            key: _formKey1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: mediaQueryHeight(context) / AppSize.s35,
                  ),
                  if (state is ImageSelectedState)
                    Image(
                      width: mediaQueryWidth(context) * .5,
                      height: mediaQueryHeight(context) * .3,
                      image: FileImage((state).imageFile),
                    )
                  ,

                  SizedBox(height: mediaQueryHeight(context) / AppSize.s30),
                  MainTextFormField(

                    controller: _titleController,
                    label: AppStrings.title,
                    hintColor: ColorManager.lightGrey,
                    inputType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.title),
                    isObsecured: false,
                    validator: (value) => validateEmail(value!),
                  ),
                  SizedBox(height: mediaQueryHeight(context) / AppSize.s30),
                  MainTextFormField(
                    controller: _priceController,
                    label: AppStrings.price,
                    hintColor: ColorManager.lightGrey,
                    inputType: TextInputType.number,
                    prefixIcon: Icon(Icons.monetization_on_outlined),
                    isObsecured: false,
                    validator: (value) => validateEmail(value!),
                  ),
                  SizedBox(height: mediaQueryHeight(context) / AppSize.s30),
                  MainButton(
                    title:  AppStrings.upload,
                    color: ColorManager.primary,
                    onPressed: () async {
                      context.read<HomeCubit>().postProduct(
                        Product(


                          title: 'title',
                          price: 1,
                          image: CacheHelper.getData(key: AppConstants.image),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: mediaQueryHeight(context) / AppSize.s30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        ColorManager.primary,
                      )
                    ),
                    onPressed: () => context.read<HomeCubit>().selectImage(),
                    child: Text('Choose Image',
                    style: TextStyle(
                      color: ColorManager.white,
                      fontSize: AppSize.s20
                    ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
