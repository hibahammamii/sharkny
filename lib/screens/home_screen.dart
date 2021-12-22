import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/models/user_model.dart';
import 'package:sharekny_app/models/wishlist_model.dart';
import 'package:sharekny_app/providers/categories_provider.dart';
import 'package:sharekny_app/providers/products_provider.dart';
import 'package:sharekny_app/screens/product_screen.dart';
import 'package:sharekny_app/screens/search_screen.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';
import 'package:sharekny_app/widgets/app_drawer.dart';
import 'package:sharekny_app/widgets/category_item.dart';
import 'package:sharekny_app/widgets/product_item.dart';
import 'package:sharekny_app/widgets/search_bar.dart';
import 'package:sharekny_app/widgets/section_widget.dart';

import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  TextEditingController search = new TextEditingController();
  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }


  @override
  void initState() {
    locator<WishListModel>().getLocalWishlist();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // Provider.of<Categories>(context).fetchAndSetProducts().then((_){});

    locator<CategoriesProvider>().getCategories();

    locator<ProductsProvider>().getProductsNewArrival();
    locator<ProductsProvider>().getProductsTopSales();



    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {


    final height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const HomeAppBar(),
        drawer: const AppDrawer(),
        body: RefreshIndicator(
        color: redColor,
        key: _refreshIndicatorKey,
    onRefresh: () async {
     await locator<ProductsProvider>().getProductsNewArrival();
      await locator<ProductsProvider>().getProductsTopSales();
    },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  //
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  //  Card(
                  //   child: SearchBar(
                  //       onTap: () {
                  //         locator<NavigationServices>()
                  //             .navigateTo(SearchScreen.routeName);
                  //       },
                  //       textController: search,
                  //
                  //   ),
                  //
                  //   shadowColor: lightGrey,
                  //   elevation: 20,
                  //   color: Colors.white,
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SectionWidget(
                      title: "categories",
                      horizontal: 10,
                      vertical: 20,
                      style: AppTextStyle.mainTextStyle),
                  Consumer<CategoriesProvider>(builder: (_, data, __) {
                    if (data.loadingCategory == true) {
                      return Container(
                        color: Colors.white,
                        child: Center(
                          child: Constants.loadingElement(),
                        ),
                      );
                    }

                    return data.items.isNotEmpty
                        ? SizedBox(
                      height: height * 0.08,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.items.length,
                        itemBuilder: (ctx, i) =>
                            ChangeNotifierProvider.value(
                              // builder: (c) => products[i],
                              value: data.items[i],
                              child: CategoryItem(
                                // products[i].id,
                                // products[i].title,
                                // products[i].imageUrl,
                              ),
                            ),
                      ),
                    )
                        : Container();
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const SectionWidget(
                          title: "best_selling",
                          horizontal: 10,
                          vertical: 20,
                          style: AppTextStyle.mainTextStyle),
                      InkWell(
                        onTap: (){
                          Navigator.of(
                            context,
                          ).push(MaterialPageRoute(
                            builder: (context) => ProductScreen(
                              title: AppLocalizations.of(context)!.translate("best_selling"),
                              products: locator<ProductsProvider>().topSales ,
                            ),
                          ));
                        },
                        child: const SectionWidget(
                            title: "see_all",
                            horizontal: 10,
                            vertical: 20,
                            style: AppTextStyle.subTextStyle),
                      ),
                    ],
                  ),
                  Consumer<ProductsProvider>(builder: (_, data, __) {
                    if (data.loadingProducts == true) {
                      return Container(
                        color: Colors.white,
                        child: Center(
                          child: Constants.loadingElement(),
                        ),
                      );
                    }

                    return data.topSales.isNotEmpty
                        ? SizedBox(
                      height: height * 0.29,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.topSales.length,
                        itemBuilder: (ctx, i) =>
                            ChangeNotifierProvider.value(
                              // builder: (c) => products[i],
                              value: data.topSales[i],
                              child: ProductItem(
                                // products[i].id,
                                // products[i].title,
                                // products[i].imageUrl,
                              ),
                            ),
                      ),
                    )
                        : Container();
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const SectionWidget(
                          title: "new_arrival",
                          horizontal: 10,
                          vertical: 20,
                          style: AppTextStyle.mainTextStyle),
                      InkWell(
                        onTap: (){
                          Navigator.of(
                            context,
                          ).push(MaterialPageRoute(
                            builder: (context) => ProductScreen(
                              title: AppLocalizations.of(context)!.translate("new_arrival"),
                              products: locator<ProductsProvider>().newArrival,
                            ),
                          ));
                        },
                        child: const SectionWidget(
                            title: "see_all",
                            horizontal: 10,
                            vertical: 20,
                            style: AppTextStyle.subTextStyle),
                      ),
                    ],
                  ),
                  Consumer<ProductsProvider>(builder: (_, data, __) {
                    if (data.loadingProducts == true) {
                      return Container(
                        color: Colors.white,
                        child: Center(
                          child: Constants.loadingElement(),
                        ),
                      );
                    }

                    return data.newArrival.isNotEmpty
                        ? SizedBox(
                      height: height * 0.29,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.newArrival.length,
                        itemBuilder: (ctx, i) =>
                            ChangeNotifierProvider.value(
                              // builder: (c) => products[i],
                              value: data.newArrival[i],
                              child: ProductItem(
                                // products[i].id,
                                // products[i].title,
                                // products[i].imageUrl,
                              ),
                            ),
                      ),
                    )
                        : Container();
                  }),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: const [
                  //     SectionWidget(
                  //         title: "featured_brands",
                  //         horizontal: 10,
                  //         vertical: 20,
                  //         style: AppTextStyle.mainTextStyle),
                  //     SectionWidget(
                  //         title: "see_all",
                  //         horizontal: 10,
                  //         vertical: 20,
                  //         style: AppTextStyle.subTextStyle),
                  //   ],
                  // ),
                  // Consumer<ProductsProvider>(builder: (_, data, __) {
                  //   if (data.loadingProducts == true) {
                  //     return Container(
                  //       color: Colors.white,
                  //       child: Center(
                  //         child: Constants.loadingElement(),
                  //       ),
                  //     );
                  //   }
                  //
                  //   return data.items.isNotEmpty
                  //       ? SizedBox(
                  //     height: height * 0.29,
                  //     child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: data.items.length,
                  //       itemBuilder: (ctx, i) =>
                  //           ChangeNotifierProvider.value(
                  //             // builder: (c) => products[i],
                  //             value: data.items[i],
                  //             child: ProductItem(
                  //               // products[i].id,
                  //               // products[i].title,
                  //               // products[i].imageUrl,
                  //             ),
                  //           ),
                  //     ),
                  //   )
                  //       : Container();
                  // }),
                ],
              ),
            ),
          ),
        ));
  }

}
