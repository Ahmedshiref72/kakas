import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakas/auth/presentation/components/main_button.dart';
import 'package:kakas/home/data/models/myGallery_model/data_model.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/values_manager.dart';
import '../../controller/home_controller/home_cubit.dart';

class EditProductScreen extends StatelessWidget {
  final ProductData product;
  static final _titleController = TextEditingController();
  static final _priceController = TextEditingController();

  const EditProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _titleController.text = product.title.toString();
    _priceController.text = product.price.toString();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Text(
          'Edit Product',
          style: TextStyle(color: ColorManager.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title'),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: mediaQueryHeight(context) / AppSize.s60,
                      horizontal: mediaQueryWidth(context) / AppSize.s20),
                  alignLabelWithHint: true,
                  isCollapsed: true,
                  filled: true,
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  focusedBorder: _outlineInputBorder(),
                  enabledBorder: _outlineInputBorderStyle(),
                  errorBorder: _outlineInputBorderErrorStyle(),
                ),
              ),
              Text('Price'),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: mediaQueryHeight(context) / AppSize.s60,
                      horizontal: mediaQueryWidth(context) / AppSize.s20),
                  alignLabelWithHint: true,
                  isCollapsed: true,
                  filled: true,
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  focusedBorder: _outlineInputBorder(),
                  enabledBorder: _outlineInputBorderStyle(),
                  errorBorder: _outlineInputBorderErrorStyle(),
                ),
              ),
              Text('Image'),
              GestureDetector(
                onTap: () {

                  context.read<HomeCubit>().selectImage();
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      width: mediaQueryWidth(context) * .9,
                      height: mediaQueryHeight(context) * .3,
                      image: NetworkImage(
                        product.image,
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(height: 16),
              MainButton(
                onPressed: () {
                  context.read()<HomeCubit>().updateProduct(
                    title: _titleController.text,
                    price: _priceController.text,
                    image: product.image,
                    id: product.id.toString(),
                  );
                },
                title: 'Update Product',
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorManager.blue,
        width: AppSize.s0_5,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(AppSize.s22),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorderStyle() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorManager.primary,
        width: AppSize.s0_5,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(AppSize.s22),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorderErrorStyle() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorManager.red,
        width: AppSize.s0,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(AppSize.s22),
      ),
    );
  }
}
