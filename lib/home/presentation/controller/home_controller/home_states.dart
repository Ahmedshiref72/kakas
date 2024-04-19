
import 'dart:io';

import 'package:kakas/home/data/models/myGallery_model/data_model.dart';

import '../../../data/models/myGallery_model/product_model.dart';
import 'home_cubit.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ProductInitial extends HomeStates {}

class ProductLoadSuccess extends HomeStates {
  final List<ProductData> products;

  ProductLoadSuccess(this.products);
}

class ProductLoadFailure extends HomeStates{
  final String errorMessage;

  ProductLoadFailure(this.errorMessage);
}


class PostProductInitial extends HomeStates {}

class PostProductLoading extends HomeStates {}
class LogoutSuccess extends HomeStates {}

class PostProductSuccess extends HomeStates {}

class PostProductFailure extends HomeStates {
  final String errorMessage;

  PostProductFailure(this.errorMessage);
}




class ImageSelectedState extends HomeStates {
  final File imageFile;

  ImageSelectedState(this.imageFile);
}

class ImageUploadedState extends HomeStates {
  final String imageUrl;

  ImageUploadedState(this.imageUrl);
}

class ImageUploadFailedState extends HomeStates {
  final String errorMessage;

  ImageUploadFailedState(this.errorMessage);
}

// Define events
abstract class HomeEvent {}

class SelectImageEvent extends HomeEvent {}

class UploadImageEvent extends HomeEvent {
  final File imageFile;

  UploadImageEvent(this.imageFile);
}
// State emitted when the product deletion process starts
class DeletingProduct extends HomeStates {}

// State emitted when the product is successfully deleted
class ProductDeleteSuccess extends HomeStates {}

// State emitted when there is an error during product deletion
class ProductDeleteFailure extends HomeStates {
  final String errorMessage;

  ProductDeleteFailure(this.errorMessage);
}