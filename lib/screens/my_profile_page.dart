import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/models/user_model.dart';
import 'package:sharekny_app/screens/home_screen.dart';
import 'package:sharekny_app/screens/welcome_screen.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';

class MyProfile extends StatefulWidget {
  static const routeName = "MyProfile";

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final voucherCode = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  String? _name,
      _email,
      _phone,
      _password,
      _cPassword,
      _fbLink,
      _commercialNum,
      _cardNum,
      _companyName;
  TextEditingController? userEmail;
  TextEditingController? phone;
  TextEditingController? name;
  TextEditingController? city;
  @override
  void initState() {
    super.initState();

    Provider.of<UserData>(context, listen: false).getUser();
    final user = Provider.of<UserData>(context, listen: false).currentUser;

    if(user!= null){
      userEmail = TextEditingController(text: user.email);

      name = TextEditingController(text: user.name);
      phone  = TextEditingController(text: user.phone);
      print(city);

    }

//    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: Constants.appBar(context, "", iconColor: blackColor)
            as PreferredSizeWidget?,
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
                key: _formKey,
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
                                      .translate("my_profile"),
                                  style: AppTextStyle.mainTextStyle
                                      .copyWith(fontSize: 30),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                TextFormField(
                                  controller: name,
                                  cursorColor: colorAccent,
                                  keyboardType: TextInputType.text,
                                  cursorWidth: 1,
                                  textAlign: TextAlign.start,
                                  textDirection: TextDirection.ltr,
                                  autofocus: false,
                                  style: const TextStyle(
                                      color: blackColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .translate("name"),
                                    labelStyle: AppTextStyle.subTextStyle,
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colorAccent)),
                                    border: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: lightGrey)),
                                  ),
                                  onSaved: (value) {
                                    _name = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty && value.length < 2) {
                                      return "name is too short";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextFormField(
                                  controller: userEmail,
                                  cursorColor: colorAccent,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorWidth: 1,
                                  textAlign: TextAlign.start,
                                  textDirection: TextDirection.ltr,
                                  autofocus: false,
                                  style: const TextStyle(
                                      color: blackColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .translate("email"),
                                    labelStyle: AppTextStyle.subTextStyle,
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colorAccent)),
                                    border: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: lightGrey)),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "inter your Email";
                                    } else {
                                      return Constants.validateEmail(val);
                                    }
                                  },
                                  onSaved: (val) {
                                    _email = val;
                                  },
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextFormField(
                                  controller: phone,
                                  cursorColor: colorAccent,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorWidth: 1,
                                  textAlign: TextAlign.start,
                                  textDirection: TextDirection.ltr,
                                  autofocus: false,
                                  style: const TextStyle(
                                      color: blackColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .translate("phone"),
                                    labelStyle: AppTextStyle.subTextStyle,
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colorAccent)),
                                    border: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: lightGrey)),
                                  ),
                                  onSaved: (val) {
                                    _phone = val;
                                  },
                                ),
                                const SizedBox(
                                  height: 25,
                                ),


                              ])),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Constants.buttonLinearGradient(
                    text: AppLocalizations.of(context)!.translate("log_out"),
                    onTap: () async{
                      await locator<UserData>().logout();

                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 800),
                        backgroundColor: dangerColor,
                        content: Text(
                          AppLocalizations.of(context)!.translate("LogOut_successfully"),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );

                    locator<NavigationServices>()
                        .navigateToReplacmentUntil(WelcomeScreen.routeName);
                    },
                    width: double.infinity),)
                    ]))));
  }
}
