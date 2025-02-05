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
          Product(1, 'assets/images/product_0.jpg', 'Product', 29.99),
          Product(2, 'assets/images/product_1.jpg', 'Product', 19.99),
          Product(3, 'assets/images/product_2.jpg', 'Product', 39.99),
        ];
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ErrorProductState('Failed to load product'));
      }
    });
  }
}
