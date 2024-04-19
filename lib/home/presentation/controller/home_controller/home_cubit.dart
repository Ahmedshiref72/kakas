import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/local/shared_preference.dart';
import '../../../../shared/network/api_constants.dart';
import '../../../../shared/network/dio_helper.dart';
import '../../../../shared/resources/constants_manager.dart';
import '../../../data/models/myGallery_model/data_model.dart';
import '../../../data/models/myGallery_model/product_model.dart';
import 'home_states.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> getProducts() async {
    try {
      final response = await DioHelper.getData(
        url: ApiConstants.getProducts,
        token: await CacheHelper.getData(key: AppConstants.token),
      );

      if (response.statusCode == 200) {
        final List<ProductData> productsData = (response.data as List)
            .map((item) => ProductData(

          id: item['id'],
          accountID: item['accountID'],
          title: item['title'],
          price: item['price'].toDouble(),
          image: item['image'],

        ))
            .toList();

        emit(ProductLoadSuccess(productsData));
        print(response);
        print(productsData);
      } else {
        print(response.data);
        emit(ProductLoadFailure(
            'Failed to retrieve products: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ProductLoadFailure('Error retrieving products: $e'));
      print(e);
    }
  }




  Future<void> postProduct(Product product) async {
    emit(PostProductLoading());

    try {
      String token = await CacheHelper.getData(key: AppConstants.token);
      final response = await DioHelper.postDataFromFormData(
        url: ApiConstants.getProducts,
        data: product.toJson(),
        token: token,
      );

      if (response.statusCode == 200) {
        emit(PostProductSuccess());
      } else {
        final responseData = response.data;
        final errorMessage = responseData['error'] ?? 'Unknown error';
        emit(PostProductFailure('Failed to post product: $errorMessage'));
      }
    } catch (e) {
      emit(PostProductFailure('Error posting product: $e'));
    }
  }

  final picker = ImagePicker();

  Future<void> selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      emit(ImageSelectedState(imageFile));
      uploadImage(imageFile);
    } else {
      print('No image selected.');
    }
  }

  Future<void> uploadImage(File imageFile) async {
    if (imageFile != null) {
      try {
        String token = await CacheHelper.getData(key: AppConstants.token);
        Dio dio = Dio();

        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
        });

        dio.options.headers = {
          'Authorization': 'Bearer $token',
        };

        Response response = await dio.post(
          ApiConstants.upload,
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          ),
        );

        String imageUrl = response.data['url'];
        CacheHelper.setData(key: AppConstants.image, value: imageUrl);
        emit(ImageUploadedState(imageUrl));
      } catch (e) {
        emit(ImageUploadFailedState('Error uploading image: $e'));
      }
    } else {
      print('No image selected.');
    }
  }

  void clearSelectedImage() {
    emit(HomeInitialState());
  }
  Future<void> deleteProduct(int productId) async {
    emit(DeletingProduct());

    try {
      String token = await CacheHelper.getData(key: AppConstants.token);
      final response = await DioHelper.deleteData(
        url: ApiConstants.getProducts,
        token: token,
        queryParameters: {'id': productId},
      );

      if (response.statusCode == 200) {
        emit(ProductDeleteSuccess());
        // Refresh products after deletion
        await getProducts();
      } else {
        emit(ProductDeleteFailure('Failed to delete product: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ProductDeleteFailure('Error deleting product: $e'));
      print(e);
    }
  }

}





