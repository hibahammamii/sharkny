import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/providers/cart_provider.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';

class CartItem extends StatefulWidget {
  final String id;
  final String productId;
  final double price;
  int quantity;
  final String title;
   String? urlImage;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.urlImage, {Key? key}
  ) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
              'Do you want to remove the item from the cart?',
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        locator<CartProvider>().removeItem(widget.productId);
      },
      child: Card(
        shadowColor: lightGrey,
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.urlImage != null?
                  Image.network(
                       widget.urlImage!,
                       fit: BoxFit.contain,
                       width: 80,
                       height: 80,
                     ):Container(),
                  const SizedBox(width: 10,),
                  SingleChildScrollView(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title),
                      const SizedBox(height: 4,),
                      Text(widget.price.toString()),
                      const SizedBox(height: 20,),
                      Container(
                        width: 95,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(
                                0, 0, 0, 0.04),
                            borderRadius:
                            BorderRadius
                                .circular(4)),
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceEvenly,
                            children: [
                               InkWell(
                                onTap: (){
                                  if (widget.quantity <4) ++widget.quantity;
                                  locator<CartProvider>().changeQty(widget.productId, widget.quantity);

                                  setState(() {

                                  });
                                },
                                child: const Padding(
                                  padding:
                                  EdgeInsets
                                      .all(8.0),
                                  child: Icon(
                                    FontAwesomeIcons
                                        .plus,
                                    size: 10,
                                    color: Color(
                                        0xBB343434),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets
                                    .all(8.0),
                                child: Text(
                                 widget.quantity
                                      .toString(),
                                  style: AppTextStyle
                                      .mainTextStyle
                                      .copyWith(
                                    fontSize: 13,
                                    fontWeight:
                                    FontWeight
                                        .w400,
                                    color:
                                    blackColor,
                                  ),
                                ),
                              ),
                               InkWell(
                                onTap:  (){
                                  if (widget.quantity >1) --widget.quantity;
                                  locator<CartProvider>().changeQty(widget.productId, widget.quantity);
                                  setState(() {

                                  });
                                },
                                child: const Padding(
                                  padding:
                                  EdgeInsets
                                      .all(8.0),
                                  child: Icon(
                                    FontAwesomeIcons
                                        .minus,
                                    size: 10,
                                    color: Color(
                                        0xBB343434),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),



                    ],)),
                ],
              ),
            ),

            const Spacer(),
            IconButton(
              padding: const EdgeInsets.all(9),
              alignment: Alignment.topRight,
              iconSize: 30,

                    icon:  Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        "assets/icons/Cencel_Icon.png"
                      ),
                    ),
                    onPressed:(){showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text(
                            'Do you want to remove the item from the cart?',
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                            ),
                            TextButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                locator<CartProvider>().removeItem(widget.productId);
                                Navigator.of(ctx).pop(true);
                              },
                            ),
                          ],
                        ),
                      );}
                  ),

            // Positioned(
            //     top: 0,
            //     right: 0,
            //     child: IconButton(
            //       icon: const Icon(
            //         Icons.minimize,
            //         color: Colors.black,
            //         size: 20,
            //       ),
            //       onPressed:(){showDialog(
            //           context: context,
            //           builder: (ctx) => AlertDialog(
            //             title: const Text('Are you sure?'),
            //             content: const Text(
            //               'Do you want to remove the item from the cart?',
            //             ),
            //             actions: <Widget>[
            //               TextButton(
            //                 child: const Text('No'),
            //                 onPressed: () {
            //                   Navigator.of(ctx).pop(false);
            //                 },
            //               ),
            //               TextButton(
            //                 child: const Text('Yes'),
            //                 onPressed: () {
            //                   Navigator.of(ctx).pop(true);
            //                 },
            //               ),
            //             ],
            //           ),
            //         );}
            //     )),
            // Padding(
            //   padding: const EdgeInsets.all(8),
            //   child: ListTile(
            //     leading: CircleAvatar(
            //       child: Padding(
            //         padding: const EdgeInsets.all(5),
            //         child: FittedBox(
            //           child: Text('\$$price'),
            //         ),
            //       ),
            //     ),
            //     title: Text(title),
            //     subtitle: Text('Total: \$${(price * quantity)}'),
            //     //trailing: Text('$quantity x'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
