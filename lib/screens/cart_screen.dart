import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/providers/cart_provider.dart';
import 'package:sharekny_app/screens/address_screen.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/paths.dart';
import 'package:sharekny_app/utilities/styles.dart';
import 'package:sharekny_app/widgets/cart_item.dart';
import 'package:slide_item/slide_item.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "CartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final voucherCode = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final cart = locator<CartProvider>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Constants.appBar(context, "", iconColor: blackColor)
          as PreferredSizeWidget?,
      body: Consumer<CartProvider>(builder: (_, data, __) {
        if (data.getLoading) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Constants.loadingElement(),
            ),
          );
        }
        return data.items.isNotEmpty
            ? SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Text(
                        AppLocalizations.of(context)!.translate('cart'),
                        style: AppTextStyle.mainTextStyle.copyWith(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: height*0.5,
                      child: CustomScrollView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cart.items.length,
                              itemBuilder: (ctx, i) => CartItem(
                                  cart.items.values.toList()[i].id,
                                  cart.items.keys.toList()[i],
                                  cart.items.values.toList()[i].price,
                                  cart.items.values.toList()[i].quantity!,
                                  cart.items.values.toList()[i].title,
                                  cart.items.values.toList()[i].urlImage),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 1,
                      color: lightGrey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.translate("subtotal")} :",
                                style: AppTextStyle.subTextStyle.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text("${data.totalAmount.toString()}  L.E"),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   "${AppLocalizations.of(context)!.translate("discount")} :",
                          //   style: AppTextStyle.subTextStyle.copyWith(
                          //       fontSize: 16, fontWeight: FontWeight.w400),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // Text(
                          //   "${AppLocalizations.of(context)!.translate("shipping_fees")} :",
                          //   style: AppTextStyle.subTextStyle.copyWith(
                          //       fontSize: 16, fontWeight: FontWeight.w400),
                          // ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: lightGrey,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20),
                      // child: Text(
                      //   "${AppLocalizations.of(context)!.translate("total")} :",
                      //   style: AppTextStyle.mainTextStyle
                      //       .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                      // ),
                    ),
                  const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.center,
                       child:
                       Constants.buttonLinearGradient( text:
                       AppLocalizations.of(context)!.translate("checkout"),
                         onTap:() async {
                           locator<NavigationServices>()
                               .navigateTo(AddressScreen.routeName);
                         },),
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
            )
            : emptyCart();
      }),
    );
  }

  Widget emptyCart() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Constants.assetsImagesPath + Paths.cart,
            width: 64,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            AppLocalizations.of(context)!.translate("cart_is_empty"),
            style: AppTextStyle.mainTextStyle,
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? const CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              // await Provider.of<Orders>(context, listen: false).addOrder(
              //   widget.cart.items.values.toList(),
              //   widget.cart.totalAmount,
              // );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
