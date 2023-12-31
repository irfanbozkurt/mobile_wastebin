import 'package:flutter/material.dart';
import 'package:shrine/supplemental/asymmetric_view.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({this.category = Category.all, Key? key}) : super(key: key);

  // TODO: Add a variable for Category (104)
  final Category category;

  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return AsymmetricView(
      products: ProductsRepository.loadProducts(category),
    );
  }
}
