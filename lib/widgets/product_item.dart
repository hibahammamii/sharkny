import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/models/product_model.dart';
import 'package:sharekny_app/providers/products_provider.dart';
import 'package:sharekny_app/screens/product_detail_screen.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    Product loadedProduct;
    return GestureDetector(
      onTap: () async{
        loadedProduct =
              (await locator<ProductsProvider>().findById(product.id!))!;
        print(product.id);
        locator<NavigationServices>()
            .navigateToWithArg(ProductDetailScreen.routeName, loadedProduct);
      },
      child: SingleChildScrollView(
        child: Container(
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: product.image != null ?CachedNetworkImage(
                  imageUrl: product.image!,
                  placeholder: (context, url) => const CircularProgressIndicator(
                    backgroundColor: colorPrimary,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: 140,
                  height: 110,
                ):Container(),
              ),
              const SizedBox(
                height: 8,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title!,
                      style: AppTextStyle.subTextStyle
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${AppLocalizations.of(context)!.translate("gain")} :",
                      style: AppTextStyle.subTextStyle
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      width: 140,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  color: dangerColor.withOpacity(0.5)),
                              child: Text(product.earn.toString(),
                                  style: AppTextStyle.subTextStyle
                                      .copyWith(fontSize: 12)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              child: Text(
                                "${AppLocalizations.of(context)!.translate("from")}",
                                style: AppTextStyle.subTextStyle.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  color: colorAccent.withOpacity(0.2)),
                              child: Text(product.price.toString(),
                                  style: AppTextStyle.subTextStyle
                                      .copyWith(fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
