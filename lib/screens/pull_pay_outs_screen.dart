import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: Constants.appBar(context, "", iconColor: blackColor)
        as PreferredSizeWidget?,
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .translate("pay_out"),
                              style: AppTextStyle.mainTextStyle
                                  .copyWith(fontSize: 30),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                              child: Column(

                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      Text("رصيدك الحالي:" ,style: AppTextStyle.mainTextStyle),
                                      Container(
                                          width: 150,
                                          height: 50,
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),

                                              border: Border.all(
                                                  color: lightGrey,
                                                  width: 2)),
                                          child: Center(child: Text("&&&&&&&",textAlign: TextAlign.center,))),

                                    ],
                                  ),
                                  SizedBox(height: 8,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      Text("المبلغ المراد سحبه:" ,style: AppTextStyle.mainTextStyle),
                                      Container(
                                        width: 150,
                                        height: 50,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),

                                            border: Border.all(
                                                color: lightGrey,
                                                width: 2)),
                                        child: TextFormField(
                                          controller: payOutsAmount,

                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),

                                          keyboardType: TextInputType.number,

                                        ),),

                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      Text("رقم الهاتف:" ,style: AppTextStyle.mainTextStyle),
                                      Container(
                                        width: 150,
                                        height: 50,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),

                                            border: Border.all(
                                                color: lightGrey,
                                                width: 2)),
                                        child: TextFormField(
                                          controller: phone,

                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),

                                          keyboardType: TextInputType.number,

                                        ),),

                                    ],
                                  ),

                                ],
                              ),
                            )
                          ])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Constants.buttonLinearGradient(
                        text:  "تأكيد عملية السحب",
                        onTap: () async{},
                        width: double.infinity),)
                ])));
  }
}
