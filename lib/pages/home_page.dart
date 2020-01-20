import 'package:flutter/material.dart';
import 'package:sales_online/blocs/categories_bloc.dart';
import 'package:sales_online/blocs/products_bloc.dart';
import 'package:sales_online/models/category.dart';
import 'package:sales_online/pages/selected_category_page.dart';
import 'package:sales_online/blocs/bloc_provider.dart';
import 'package:sales_online/widgets/cart_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _categoriesBloc =
    BlocProvider.of<CategoriesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce'),
        actions: <Widget>[
          CartButton(),
        ],
      ),
      body: StreamBuilder<List<Category>>(
        stream: _categoriesBloc.outCategories,
        builder:
            (context, categories) {
          if (categories.hasData) {
            return ListView.builder(
                itemCount: categories.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = categories.data[index];
                  return ListTile(
                    onTap: () => navigateToSelectedCategory(context, category),
                    title: Text(
                      category.name,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  );
                });
          }
          return SizedBox();
        },
      ),
    );
  }

  void navigateToSelectedCategory(BuildContext context, Category category){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => BlocProvider(
        child: SelectedCategoryPage(),
        bloc: ProductsBloc(category),
      ),
    )
    );
  }
}
