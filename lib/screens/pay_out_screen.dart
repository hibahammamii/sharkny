import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/models/user_model.dart';
import 'package:sharekny_app/providers/pay_outs_provider.dart';
import 'package:sharekny_app/screens/home_screen.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';

class PayOutsScreen extends StatefulWidget {
  static const routeName = "PayOuts";

  PayOutsScreen({Key? key}) : super(key: key);

  @override
  State<PayOutsScreen> createState() => _PayOutsScreenState();
}

class _PayOutsScreenState extends State<PayOutsScreen> {


  final voucherCode = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();


  TextEditingController? phone= TextEditingController();
  TextEditingController? payOutsAmount= TextEditingController();


  @override
  void initState() {
    super.initState();
    }

//    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');



  @override
  Widget build(BuildContext context) {
  final payOuts=  locator<PayOutsProvider>().payOuts;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: Constants.appBar(context, "", iconColor: blackColor)
            as PreferredSizeWidget?,
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 25),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text("الرصيد:"),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),

                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),

                              border: Border.all(
                                  color: lightGrey,
                                  width: 2)),
                          child: Center(child: Text(payOuts!.balance.toString())),

                        ),


                      Text("الرصيد المتاح:"),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 50,
                            height: 40,

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),

                                border: Border.all(
                                    color: lightGrey,
                                    width: 2)),
                            child: Center(child: Text(payOuts.availablebalance.toString()))),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("الربح الكلي:"),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                            width: 50,
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),

                                border: Border.all(
                                    color: lightGrey,
                                    width: 2)),
                            child: Center(child: Text(payOuts.totalEarn.toString()))),
                      ],
                    ),


                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Stack(
                    //       children: [
                    //         Container(
                    //             margin: const EdgeInsets.symmetric(vertical: 20),
                    //             width: 150,
                    //             height: 150,
                    //             padding: const EdgeInsets.symmetric(horizontal: 10),
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(5),
                    //
                    //                 border: Border.all(
                    //                     color: lightGrey,
                    //                     width: 2)),
                    //             child: Center(child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Text("قيد الانتظار",
                    //                     style: AppTextStyle.subTextStyle.copyWith(fontSize: 20)),
                    //                 const SizedBox(height: 6,),
                    //                 Text(payOuts.balance.toString()),
                    //               ],
                    //             ))),
                    //         const Positioned(
                    //             left: 50,
                    //             right: 50,
                    //             top: 2,
                    //             child: Icon(Icons.timelapse_rounded,color: orangeColor,size: 40,))
                    //       ],
                    //     ),
                    //
                    //     Stack(
                    //       children: [
                    //         Container(
                    //             margin: const EdgeInsets.symmetric(vertical: 20),
                    //             width: 150,
                    //             height: 150,
                    //             padding: const EdgeInsets.symmetric(horizontal: 10),
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(5),
                    //
                    //                 border: Border.all(
                    //                     color: lightGrey,
                    //                     width: 2)),
                    //             child: Center(child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Text("طلبات معطله",
                    //                     style: AppTextStyle.subTextStyle.copyWith(fontSize: 20)),
                    //                 const SizedBox(height: 6,),
                    //                 Text(payOuts.balance.toString()),
                    //               ],
                    //             ))),
                    //         const Positioned(
                    //             left: 50,
                    //             right: 50,
                    //             top: 2,
                    //             child: Icon(Icons.block,color: redColor,size: 40,))
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Stack(
                    //       children: [
                    //         Container(
                    //             margin: const EdgeInsets.symmetric(vertical: 20),
                    //             width: 150,
                    //             height: 150,
                    //             padding: const EdgeInsets.symmetric(horizontal: 10),
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(5),
                    //
                    //                 border: Border.all(
                    //                     color: lightGrey,
                    //                     width: 2)),
                    //             child: Center(child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Text("قيد الانتظار",
                    //                     style: AppTextStyle.subTextStyle.copyWith(fontSize: 20)),
                    //                 const SizedBox(height: 6,),
                    //                 Text(payOuts.balance.toString()),
                    //               ],
                    //             ))),
                    //         const Positioned(
                    //             left: 50,
                    //             right: 50,
                    //             top: 2,
                    //             child: Icon(Icons.timelapse_rounded,color: orangeColor,size: 40,))
                    //       ],
                    //     ),
                    //
                    //     Stack(
                    //       children: [
                    //         Container(
                    //             margin: const EdgeInsets.symmetric(vertical: 20),
                    //             width: 150,
                    //             height: 150,
                    //             padding: const EdgeInsets.symmetric(horizontal: 10),
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(5),
                    //
                    //                 border: Border.all(
                    //                     color: lightGrey,
                    //                     width: 2)),
                    //             child: Center(child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Text("طلبات معطله",
                    //                     style: AppTextStyle.subTextStyle.copyWith(fontSize: 20)),
                    //                 const SizedBox(height: 6,),
                    //                 Text(payOuts.balance.toString()),
                    //               ],
                    //             ))),
                    //         const Positioned(
                    //             left: 50,
                    //             right: 50,
                    //             top: 2,
                    //             child: Icon(Icons.block,color: redColor,size: 40,))
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    Container(
                      height: 500,
                      width: 500,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: payOuts.listPayOuts!.length,
                        itemBuilder: (context, i){

                          return Card(
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("الرصيد: "),
                                  Text(payOuts.listPayOuts![i].amount.toString()),
                                  Text(payOuts.listPayOuts![i].type.toString()),
                                ],
                              ),

                            ),
                          );

                        },
                      ),
                    ),


                  ]
              ),
            )));
  }
}
