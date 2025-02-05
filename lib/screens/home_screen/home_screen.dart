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
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'HOT Products',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: List.generate(
                                  state.products.length,
                                  (int index) {
                                    final product = state.products[index];
                                    return _buildItem(
                                        context,
                                        product.image!,
                                        product.name!,
                                        product.price!,
                                        product.id!);
                                  },
                                ),
                              ),
                            ],
                          ),
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

  Column _buildItem(
      BuildContext context, String image, String name, double price, int id) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: height * 0.18,
          width: width * 0.37,
          margin: const EdgeInsets.symmetric(horizontal: 5,),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          ),
        ),
        Text(
          '$name $id',
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        Text(
          '$price đ',
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      ],
    );
  }
}
