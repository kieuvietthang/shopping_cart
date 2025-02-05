import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/blocs/home/product_event.dart';

import '../../blocs/home/product_bloc.dart';
import '../../blocs/home/product_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProductBloc()..add(LoadProducts()),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                _appBar(context, "Home"),
                Expanded(
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductLoaded) {
                        return ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return Card(
                              child: ListTile(
                                leading: Image.asset(product.image!),
                                title: Text(product.name!),
                                subtitle: Text(
                                    '\$${product.price!.toStringAsFixed(2)}'),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(child: Text('No products found.'));
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Stack _appBar(BuildContext context, String name) {
    return Stack(
      children: [
        Container(
          height: 60,
          width: double.infinity,
          color: Colors.amber,
          alignment: Alignment.center,
          child: Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        const Positioned(
          top: 0,
          right: 15,
          bottom: 0,
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
