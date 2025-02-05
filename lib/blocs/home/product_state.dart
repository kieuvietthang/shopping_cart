import 'package:equatable/equatable.dart';
import 'package:shopping_cart/models/product/product.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ErrorProductState extends ProductState {
  final String error;

  ErrorProductState(this.error);
}