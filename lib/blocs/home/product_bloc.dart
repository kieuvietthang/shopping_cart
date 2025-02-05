import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/blocs/home/product_event.dart';
import 'package:shopping_cart/blocs/home/product_state.dart';
import 'package:shopping_cart/models/product/product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    // Đăng ký event handler
    on<LoadProducts>((event, emit) {
      try {
        List<Product> products = [
          Product('assets/images/product_0.jpg', 'Product 1', 29.99),
          Product('assets/images/product_1.jpg', 'Product 2', 19.99),
          Product('assets/images/product_2.jpg', 'Product 3', 39.99),
        ];
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ErrorProductState('Failed to load product'));
      }
    });
  }
}