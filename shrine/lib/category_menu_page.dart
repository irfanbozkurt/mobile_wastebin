import 'package:flutter/material.dart';

import 'colors.dart';
import 'model/product.dart';

class CategoryMenuPage extends StatelessWidget {
  final Category currentCategory;
  final ValueChanged<Category> onCategoryTap;
  final List<Category> _categories = Category.values;

  const CategoryMenuPage(
      {Key? key, required this.currentCategory, required this.onCategoryTap})
      : super(key: key);

  // Will be called for each category
  Widget _buildCategory(Category category, BuildContext context) {
    final categoryString =
        category.toString().replaceAll('Category.', '').toUpperCase();
    final themeData = Theme.of(context);

    return GestureDetector(
        onTap: () => onCategoryTap(category),
        child: category != currentCategory
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  categoryString,
                  style: themeData.textTheme.bodyLarge!
                      .copyWith(color: kShrineBrown900.withAlpha(153)),
                  textAlign: TextAlign.center,
                ))
            : Column(
                children: <Widget>[
                  const SizedBox(height: 16.0),
                  Text(
                    categoryString,
                    style: themeData.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14.0),
                  Container(
                    width: 70.0,
                    height: 2.0,
                    color: kShrinePink400,
                  ),
                ],
              ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: const EdgeInsets.only(top: 40),
            color: kShrinePink100,
            child: ListView(
              children:
                  _categories.map((c) => _buildCategory(c, context)).toList(),
            )));
  }
}
