import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/models/product_model.dart';
import 'package:sharekny_app/providers/products_provider.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';
import 'package:sharekny_app/widgets/product_item.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = "ProductScreen";
  final String? title;
  final int? id;
  final List<Product>? products;

  const ProductScreen({Key? key, this.title, this.id, this.products})
      : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product>? _products ;
  String? _currentFilter;
  @override
  void initState() {
    _products = widget.products;
    // TODO: implement initState
    super.initState();
  }
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
      appBar: Constants.appBar(context, widget.title!,action:
        IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            onPressed: () => _products!.isEmpty ? null : _showFilterDialog())
      ,) as PreferredSizeWidget?,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: SizedBox(
                height: 40,
                child: Text(widget.title!,
                  style: AppTextStyle.mainTextStyle.copyWith(fontSize: 25),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SizedBox(
                height: height - (20 + statusBar + appBar),
                child: _products == null? Consumer<ProductsProvider>(builder: (_, data, __) {
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
                        value: _products![i],
                        child: ProductItem(
                          // products[i].id,
                          // products[i].title,
                          // products[i].imageUrl,
                        ),

                      ),
                    itemCount: _products!.length,
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
                      value: _products![i],
                      child: ProductItem(
                        // products[i].id,
                        // products[i].title,
                        // products[i].imageUrl,
                      ),

                    ),
                  itemCount:_products!.length,
                )

              ),
            ),
          ],
        ),
      ),

    );

  }

  Future<void> _showFilterDialog() {
    return showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return Container(
            padding:  EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "filter rate",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .apply(fontWeightDelta: 2, fontSizeFactor: 1.2),
                ),
                ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.translate("high to low"),
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    _filterProducts("high");
                  },
                ),
                ListTile(
                  title: Text(
                    AppLocalizations.of(context)!
                        .translate("low to high"),
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    _filterProducts('low');
                  },
                ),
                Divider(),

              ],
            ),
          );
        });
  }

  void _filterProducts(String query) {

    if (query == "high") {
      _products!.sort((a, b) => a.rate!.compareTo(b.rate!));
      setState(() {
        _currentFilter = query;
      });
    } else if (query ==
      "low") {
      _products!.sort((a, b) => b.rate!.compareTo(a.rate!));
      setState(() {
        _currentFilter = query;
      });

    }
  }
}
