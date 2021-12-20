import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/models/category_model.dart';
import 'package:sharekny_app/models/product_model.dart';
import 'package:sharekny_app/providers/products_provider.dart';
import 'package:sharekny_app/screens/product_detail_screen.dart';
import 'package:sharekny_app/screens/product_screen.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';


class CategoryItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryModel>(context, listen: false);

    return GestureDetector(
      onTap:()
    async {
        print(category.id);
    await  locator<ProductsProvider>().getProducts(category.id!);
       Navigator.of(
        context,
      ).push(MaterialPageRoute(
        builder: (context) => ProductScreen(
          title: category.title,
          id : category.id,
        ),
      ));},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(

          width: 100,
          height: 50,

          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(12)),color: colorAccent.withOpacity(0.1),),
          child:Center(child: Text(category.title!,style:const TextStyle(height: 1.2),textAlign: TextAlign.center,)),
        ),
      ),);
  }
}
