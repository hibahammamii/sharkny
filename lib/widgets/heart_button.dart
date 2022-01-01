import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharekny_app/models/user_model.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';

import '../models/product_model.dart' show Product;
import '../models/wishlist_model.dart' show WishListModel;

class HeartButton extends StatefulWidget {
  final Product? product;
  final double? size;
  final Color? color;
  BuildContext context;

  HeartButton({Key? key, this.product, this.size, this.color,required this.context}) : super(key: key);

  @override
  _HeartButtonState createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  @override
  Widget build(context) {

    List<int?> WishListOnline = Provider.of<WishListModel>(context).getWishListOnline();
    final isExist = WishListOnline.firstWhere(
            (item) => item == widget.product!.id,
        orElse: () => null);
    print(WishListOnline);
    // List<Product?> wishlist = Provider.of<WishListModel>(context).getWishList();
    // final isExist = wishlist.firstWhere(
    //     (item) => item!.id == widget.product!.id,
    //     orElse: () => null);

    if (isExist == null) {
      return IconButton(
        onPressed: () async {
          await locator<UserData>().getUser();

          bool? loggedIn = locator<UserData>().loggedIn?? false;
          if (!loggedIn) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 800),
                backgroundColor: dangerColor,
                content: const Text(
                  "يرجى تسجيل الدخول",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else {
          await  Provider.of<WishListModel>(context, listen: false).addToWishlist(
                widget.product, locator<UserData>().currentUser!.id);
        await Provider.of<WishListModel>(context, listen: false).WishListOnline();
            setState(() {});
          }
        },
        icon: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.3),
          child: Icon(FontAwesomeIcons.heart,
              color: Theme.of(context).accentColor.withOpacity(0.5),
              size: widget.size ?? 16.0),
        ),
      );
    }

    return IconButton(
      onPressed: () async {
        await locator<UserData>().getUser();

        bool? loggedIn = locator<UserData>().loggedIn?? false;
        if (!loggedIn) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 800),
              backgroundColor: dangerColor,
              content: const Text(
                "يرجى تسجيل الدخول",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
        await  Provider.of<WishListModel>(context, listen: false)
              .removeToWishlist(widget.product,locator<UserData>().currentUser!.id);
        await Provider.of<WishListModel>(context, listen: false).WishListOnline();
          setState(() {});
        }
      },
      icon: CircleAvatar(
        backgroundColor: Colors.pink.withOpacity(0.1),
        child: Icon(FontAwesomeIcons.solidHeart,
            color: Colors.pink, size: widget.size ?? 16.0),
      ),
    );
  }
}
