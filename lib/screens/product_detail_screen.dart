import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/models/product_model.dart';
import 'package:sharekny_app/providers/cart_provider.dart';
import 'package:sharekny_app/providers/products_provider.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';
import 'package:sharekny_app/widgets/heart_button.dart';

import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = "ProductDetailsScreen";
  final Product? loadedProduct;

  ProductDetailScreen({this.loadedProduct});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool more = false;
  int quantity = 1;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
        GlobalKey<ScaffoldMessengerState>();
    final cart = locator<CartProvider>();
    if (widget.loadedProduct == null) {
      return const SizedBox();
    }// is the id!

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        appBar: Constants.appBar(context, "",
            iconColor: blackColor,
            action:  InkWell(
              onTap:  () => locator<NavigationServices>()
                  .navigateTo(CartScreen.routeName),
              child: Badge(
                  badgeContent: Consumer<CartProvider>(
                    builder: (_, data, __) {
                      return Text(
                        data.itemCount.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .apply(color: Colors.white),
                      );
                    },
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 5,right: 5),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: logoColor,
                    ),
                  ),
                  position: BadgePosition.topStart(top: 5,start: 0)
              ),
            ),
        ) as PreferredSizeWidget?,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  height: height * 0.25,
                  width: double.infinity,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return widget.loadedProduct!.image != null? Image.network(
                        widget.loadedProduct!.image!,
                        fit: BoxFit.contain,
                      ): Container();
                    },
                    itemCount: 3,
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomLeft,
                      builder: DotSwiperPaginationBuilder(
                          size: 5,
                          color: Colors.grey,
                          activeColor: colorAccent),
                    ),
                    // control: const SwiperControl(),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: Text(
                  widget.loadedProduct!.title?? "",
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style: AppTextStyle.mainTextStyle.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' L.E ${widget.loadedProduct!.price} ',
                      style: const TextStyle(
                        color: colorAccent,
                        fontSize: 16,
                      ),
                    ),
                    HeartButton(
                      product: widget.loadedProduct,
                      size: 18.0,
                      color: lightGrey,),

                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // const Divider(
              //   thickness: 2,
              // ),
              // const SizedBox(
              //   height: 7,
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 30),
              //   child: Text(
              //     'Reviews',
              //     style: TextStyle(
              //       color: colorAccent,
              //       fontSize: 16,
              //     ),
              //     textAlign: TextAlign.end,
              //   ),
              // ),
              const SizedBox(
                height: 7,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.translate('description'),
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style: AppTextStyle.mainTextStyle,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: Text(
                  widget.loadedProduct!.desc ?? "",
                  textAlign: TextAlign.start,
                  maxLines: more == false ? 2 : 6,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: AppTextStyle.subTextStyle.copyWith(height: 1.7),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  more = !more;
                  setState(() {});
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate(more == false ? "read_more" : "read_less"),
                      style:
                          const TextStyle(color: colorAccent, fontSize: 10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.translate('quantity')} :",
                      textAlign: TextAlign.start,
                      softWrap: true,
                      style: AppTextStyle.mainTextStyle,
                    ),
                    Container(
                        width: 95,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 0.04),
                            borderRadius: BorderRadius.circular(4)),
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (quantity < 10) ++quantity;
                                  setState(() {});
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    FontAwesomeIcons.plus,
                                    size: 10,
                                    color: Color(0xBB343434),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  quantity.toString(),
                                  style: AppTextStyle.mainTextStyle.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (quantity > 1) --quantity;
                                  setState(() {});
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    size: 10,
                                    color: Color(0xBB343434),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Constants.buttonLinearGradient(
                    text:
                        AppLocalizations.of(context)!.translate("add_to_cart"),
                    onTap: () {
                      cart.addItem(
                          widget.loadedProduct!.id!,
                          widget.loadedProduct!.price!.toDouble(),
                          widget.loadedProduct!.title!,
                          widget.loadedProduct!.image,
                          quantity);
                      scaffoldMessengerKey.currentState!.hideCurrentSnackBar();
                      scaffoldMessengerKey.currentState!.showSnackBar(
                        SnackBar(
                          backgroundColor: lightGrey,
                          content: const Text(
                            'Added item to cart!',
                            style: TextStyle(color: blackColor),
                          ),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.removeSingleItem(widget.loadedProduct!.id!);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  //Container(
                  //   width: width / 2,
                  //   height: height * 0.07,
                  //   decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(5)),
                  //     gradient: LinearGradient(
                  //       colors: [colorButtonBegin, colorButtonEnd],
                  //       begin: FractionalOffset.centerLeft,
                  //       end: FractionalOffset.centerRight,
                  //     ),
                  //   ),
                  //   child: TextButton(
                  //     onPressed: () {
                  //       cart.addItem(
                  //           loadedProduct.id,
                  //           loadedProduct.price,
                  //           loadedProduct.title,
                  //           loadedProduct.imageUrl,
                  //           quantity);
                  //       scaffoldMessengerKey.currentState!
                  //           .hideCurrentSnackBar();
                  //       scaffoldMessengerKey.currentState!.showSnackBar(
                  //         SnackBar(
                  //           backgroundColor: lightGrey,
                  //           content: const Text(
                  //             'Added item to cart!',
                  //             style: TextStyle(color: blackColor),
                  //           ),
                  //           duration: const Duration(seconds: 2),
                  //           action: SnackBarAction(
                  //             label: 'UNDO',
                  //             onPressed: () {
                  //               cart.removeSingleItem(loadedProduct.id);
                  //             },
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     child: Text(
                  //       AppLocalizations.of(context)!.translate('add_to_cart'),
                  //       style: const TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  //),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
