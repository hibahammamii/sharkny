// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sharekny_app/providers/orders_provider.dart';
// import 'package:sharekny_app/utilities/constants.dart';
// import 'package:sharekny_app/utilities/get_it.dart';
// import 'package:sharekny_app/utilities/styles.dart';
//
// class OrdersScreen extends StatefulWidget {
//   static const routeName = "orders";
//
//   OrdersScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }
//
// class _OrdersScreenState extends State<OrdersScreen> {
//   final voucherCode = TextEditingController();
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();
//
//   TextEditingController? phone = TextEditingController();
//   TextEditingController? payOutsAmount = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
// //    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
//
//   @override
//   Widget build(BuildContext context) {
//     final orders = locator<OrdersProvider>().orders;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//         appBar: Constants.appBar(context, "", iconColor: blackColor)
//             as PreferredSizeWidget?,
//         body: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Stack(
//                             children: [
//                               Container(
//                                   margin: const EdgeInsets.symmetric(vertical: 20),
//                                   width: 150,
//                                   height: 150,
//                                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//
//                                       border: Border.all(
//                                           color: lightGrey,
//                                           width: 2)),
//                                   child: Center(child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text("تم الاستلام",
//                                           style: AppTextStyle.subTextStyle.copyWith(fontSize: 20)),
//                                       const SizedBox(height: 6,),
//                                       Text(orders!.delivered.toString()),
//                                     ],
//                                   ))),
//                               const Positioned(
//                                   left: 50,
//                                   right: 50,
//                                   top: 2,
//                                   child: Icon(Icons.check_circle,color: orangeColor,size: 40,))
//                             ],
//                           ),
//
//                           Stack(
//                             children: [
//                               Container(
//                                   margin: const EdgeInsets.symmetric(vertical: 20),
//                                   width: 150,
//                                   height: 150,
//                                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//
//                                       border: Border.all(
//                                           color: lightGrey,
//                                           width: 2)),
//                                   child: Center(child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text("طلبات معطله",
//                                           style: AppTextStyle.subTextStyle.copyWith(fontSize: 20)),
//                                       const SizedBox(height: 6,),
//                                       Text(orders!.rejected.toString()),
//                                     ],
//                                   ))),
//                               const Positioned(
//                                   left: 50,
//                                   right: 50,
//                                   top: 2,
//                                   child: Icon(Icons.block,color: redColor,size: 40,))
//                             ],
//                           ),
//                         ],
//                       ),
//                       Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: SizedBox(
//                               height: height * 0.8,
//                               width: double.infinity,
//                               child: Consumer<OrdersProvider>(
//                                   builder: (_, data, __) {
//                                 if (data.loadingOrders == true) {
//                                   return Container(
//                                     color: Colors.white,
//                                     child: Center(
//                                       child: Constants.loadingElement(),
//                                     ),
//                                   );
//                                 }
//                                 return data.orders!.ordersList!.isNotEmpty
//                                     ? SizedBox(
//                                         height: height * 0.08,
//                                         child: ListView.builder(
//                                           scrollDirection: Axis.vertical,
//                                           itemCount:
//                                               data.orders!.ordersList!.length,
//                                           itemBuilder: (context, i) {
//                                             return Card(
//                                               child: ListTile(
//                                                 title: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     const Text("رقم الطلب "),
//                                                     Text(data.orders!
//                                                         .ordersList![i].id
//                                                         .toString()),
//                                                     Text(data.orders!
//                                                         .ordersList![i].name?? ""),
//                                                   ],
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       )
//                                     : Container();
//                               })))
//                     ]))));
//   }
// }
