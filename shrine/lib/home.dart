import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Make a collection of cards
  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    if (products.isEmpty) return const [];

    final theme = Theme.of(context);
    final formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
    );

    return products
        .map((product) => Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 1,
                  ),
                  AspectRatio(
                    aspectRatio: 18 / 11,
                    child: Image.asset(
                      product.assetName,
                      package: product.assetPackage,
                      // adjust box size
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: theme.textTheme.titleLarge,
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              formatter.format(product.price),
                              style: theme.textTheme.titleSmall,
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ))
        .toList();
  }

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
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
      body: GridView.count(
        // We'll list a countable amount of cards
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        childAspectRatio: 8 / 9,
        children: _buildGridCards(context),
      ),
      resizeToAvoidBottomInset:
          false, // Ensure keyword's appearance doesn't affect the layout
    );
  }
}
