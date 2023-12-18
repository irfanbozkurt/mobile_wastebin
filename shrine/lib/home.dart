import 'package:flutter/material.dart';
import 'package:shrine/supplemental/asymmetric_view.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pa ss Category variable to AsymmetricView (104)
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHRINE'),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu button');
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                //
              },
              icon: const Icon(Icons.search, semanticLabel: 'search')),
          IconButton(
              onPressed: () {
                //
              },
              icon: const Icon(Icons.tune, semanticLabel: 'filter')),
        ],
      ),
      body: AsymmetricView(
        products: ProductsRepository.loadProducts(Category.all),
      ),
      resizeToAvoidBottomInset:
          false, // Ensure keyword's appearance doesn't affect the layout
    );
  }
}
