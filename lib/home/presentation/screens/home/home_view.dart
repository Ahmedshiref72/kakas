import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakas/home/data/models/myGallery_model/product_model.dart';
import 'package:kakas/home/presentation/screens/home/upload_product.dart';
import 'package:kakas/shared/components/toast_component.dart';
import 'dart:io';
import 'package:kakas/shared/local/shared_preference.dart';
import 'package:kakas/shared/resources/app_strings.dart';
import 'package:kakas/shared/resources/assets_manager.dart';
import 'package:kakas/shared/resources/color_manager.dart';
import 'package:kakas/shared/resources/constants_manager.dart';
import 'package:kakas/shared/resources/font_manager.dart';
import 'package:kakas/shared/resources/navigation.dart';
import 'package:kakas/shared/resources/routes_manager.dart';
import 'package:kakas/shared/resources/values_manager.dart';

import '../../components/button_component.dart';
import '../../controller/home_controller/home_cubit.dart';
import '../../controller/home_controller/home_states.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            // Handle state changes if needed
            if (state is ProductDeleteSuccess) {
              showToast(text: 'Product deleted successfully', state: ToastStates.WARNING);
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Welcome ${CacheHelper.getData(key: AppConstants.userName)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    fontFamily: FontConstants.fontFamilyBaloo,
                                  ),
                            ),
                            const Spacer(),
                            const CircleAvatar(
                              radius: AppSize.s35,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                ImageAssets.profilePic,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mediaQueryHeight(context) / AppSize.s35,
                        ),
                        Row(
                          children: [
                            // Log out button
                            DynamicButton(
                              baseColor: ColorManager.white,
                              name: AppStrings.logOut,
                              firstColor: ColorManager.darkRed,
                              shadowColor: ColorManager.lightRed,
                              endColor: ColorManager.lightRed,
                              icon: ImageAssets.leftArrowIcon,
                              onTap: () {
                                // Handle log out
                                navigateFinalTo(context: context, screenRoute: Routes.loginRoute);
                              },
                              borderRadius: AppSize.s25,
                            ),
                            const Spacer(),
                            // Upload image button
                            DynamicButton(
                              name: AppStrings.upload,
                              firstColor: ColorManager.darkYellow,
                              shadowColor: ColorManager.lightYellow,
                              endColor: ColorManager.lightYellow,
                              icon: ImageAssets.upArrowIcon,
                              borderRadius: AppSize.s25,
                              onTap: () {
                                navigateTo(
                                    context: context,
                                    screenRoute: Routes.uploadscreenRoute);
                              },
                              baseColor: ColorManager.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mediaQueryHeight(context) / AppSize.s35,
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is ProductLoadSuccess)
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = state.products[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager.lightGrey,
                            ),
                            borderRadius: BorderRadius.circular(AppSize.s10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor:
                                              Colors.white.withOpacity(0.8),
                                          title: Text('Confirm Deletion'),
                                          content: Text(
                                              'Are you sure you want to delete this product?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the alert dialog
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: ColorManager.primary,
                                                    fontSize: FontSize.s14),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                // Perform the delete action
                                                context
                                                    .read<HomeCubit>()
                                                    .deleteProduct(product.id);
                                                Navigator.of(context)
                                                    .pop(); // Close the alert dialog
                                              },
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: ColorManager.primary,
                                                    fontSize: FontSize.s14),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    size: 35,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: product.image.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(AppSize.s10),
                                        ),
                                        child: Image.network(
                                          product.image,
                                          fit: BoxFit.fill,
                                        ))
                                    : Icon(
                                        Icons.image,
                                        size: 35,
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: state.products.length,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
