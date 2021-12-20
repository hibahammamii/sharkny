import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/models/product_model.dart';
import 'package:sharekny_app/providers/products_provider.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';
import 'package:sharekny_app/widgets/product_item.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = "ProductScreen";
  final String? title;
  final int? id;
  final List<Product>? products;

  const ProductScreen({Key? key, this.title, this.id, this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double statusBar = MediaQuery
        .of(context)
        .padding
        .top;
    double appBar = AppBar().preferredSize.height;

    return Scaffold(
      appBar: Constants.appBar(context, title!) as PreferredSizeWidget?,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: SizedBox(
                height: 40,
                child: Text(title!,
                  style: AppTextStyle.mainTextStyle.copyWith(fontSize: 30),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SizedBox(
                height: height - (20 + statusBar + appBar),
                child: products == null? Consumer<ProductsProvider>(builder: (_, data, __) {
                  if (data.loadingProducts == true) {
                    return Container(
                      color: Colors.white,
                      child: Center(
                        child: Constants.loadingElement(),
                      ),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.85,
                    ), itemBuilder: (ctx, i) =>
                      ChangeNotifierProvider.value(
                        // builder: (c) => products[i],
                        value: data.items[i],
                        child: ProductItem(
                          // products[i].id,
                          // products[i].title,
                          // products[i].imageUrl,
                        ),

                      ),
                    itemCount: data.items.length,
                  );

                }):GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.85,
                  ), itemBuilder: (ctx, i) =>
                    ChangeNotifierProvider.value(
                      // builder: (c) => products[i],
                      value: products![i],
                      child: ProductItem(
                        // products[i].id,
                        // products[i].title,
                        // products[i].imageUrl,
                      ),

                    ),
                  itemCount:products!.length,
                )

              ),
            ),
          ],
        ),
      ),

    );
  }
}
