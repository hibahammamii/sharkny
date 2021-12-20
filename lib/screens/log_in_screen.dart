import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/providers/auth_provider.dart';
import 'package:sharekny_app/screens/restore_email_screen.dart';
import 'package:sharekny_app/screens/sign_up_screen.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';
import 'package:sharekny_app/widgets/color_safe_area.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "LoginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  String? _email, _password;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    locator<AuthProvider>()
        .logIn(context, _scaffoldKey, email: _email, password: _password);
  }

  @override
  Widget build(BuildContext context) {
    return ColoredSafeArea(
      child: Scaffold(
        appBar: Constants.appBar(context, "") as PreferredSizeWidget?,
        body: Stack(
          children: [
            body(context),
          ],
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.translate('sign_in'),
                      style: AppTextStyle.mainTextStyle.copyWith(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorWidth: 1,
                      cursorColor: colorAccent,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                      autofocus: false,
                      style: const TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 15),
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.translate("email"),
                        labelStyle: AppTextStyle.subTextStyle,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: colorAccent)),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: lightGrey)),
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
                      height: 32,
                    ),
                    TextFormField(
                      cursorColor: colorAccent,
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      cursorWidth: 1,
                      obscureText: true,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                      autofocus: false,
                      style: const TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 6,
                          fontSize: 16),
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.translate("password"),
                        errorMaxLines: 2,
                        labelStyle: AppTextStyle.subTextStyle.copyWith(
                          letterSpacing: 0.7,
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: colorAccent)),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: lightGrey)),
                      ),
                      onSaved: (val) {
                        _password = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty && value.length < 5) {
                          return "Password is too short";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Align(
                    //   alignment:
                    //   locator<LocalizationProvider>().locale!.languageCode ==
                    //       "en"
                    //       ? Alignment.centerRight
                    //       : Alignment.centerLeft,
                    //   child: TextButton(
                    //       style: TextButton.styleFrom(
                    //         padding: EdgeInsets.only(left: 8),
                    //       ),
                    //       onPressed: () {
                    //         locator<NavigationServices>()
                    //             .navigateTo(AddEmailScreen.routeName);
                    //       },
                    //       child: Text(
                    //         AppLocalizations.of(context)!
                    //             .translate("forgot_password"),
                    //         style: TextStyle(color: redColor),
                    //       )),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<AuthProvider>(builder: (_, data, __) {
                      if (data.loading) {
                        return Container(
                          color: Colors.white,
                          child: Center(
                            child: Constants.loadingElement(),
                          ),
                        );
                      }
                      return Constants.buttonLinearGradient(
                        text:
                            AppLocalizations.of(context)!.translate("sign_in"),
                        onTap: () async {
                          _submit();
                        },
                      );
                    }),
                    Center(
                      child: InkWell(
                          onTap: () {
                            locator<NavigationServices>()
                                .navigateTo(SignUpScreen.routeName);
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: RichText(
                                text: TextSpan(
                                  text: AppLocalizations.of(context)!
                                          .translate("no_account") +
                                      "  ",
                                  style: AppTextStyle.subTextStyle,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .translate("sign_up"),
                                      style: AppTextStyle.subTextStyle.copyWith(
                                          color: blackColor, fontSize: 18),
                                    )
                                  ],
                                ),
                              ))),
                    )

                    // Container(
                    //    height: 50,
                    //    child: ElevatedButton(
                    //      style: ElevatedButton.styleFrom(
                    //        elevation: 0,
                    //        primary: redColor, // background
                    //        onPrimary: Colors.white, // foreground
                    //      ),
                    //      onPressed: () {
                    //        if (_emailController.value.text.isNotEmpty &&
                    //            _passwordController.value.text.isNotEmpty) {
                    //
                    //        } else {
                    //          showInSnackBar("fill_all_fileds", dangerColor);
                    //        }
                    //        //
                    //      },
                    //      child: Text(
                    //        AppLocalizations.of(context)!.translate("sign_in"),
                    //        style: AppTextStyle.subTextStyle.copyWith(
                    //            color: whiteColor,
                    //            fontWeight: FontWeight.w400,
                    //            fontSize: 14),
                    //      ),
                    //    ),
                    //  ),
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              const SizedBox(
                height: 42,
              ),
              /* Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: redColor, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    locator<NavigationServices>()
                        .navigateToReplacment(HomeScreen.routeName);
                  },
                  child: Text(
                    AppLocalizations.of(context).translate("view_as_guest"),
                    style: AppTextStyle.subTextStyle.copyWith(
                        color: whiteColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),*/

              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value, Color c) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: c,
        content: Text(AppLocalizations.of(context)!.translate(value),
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ))));
  }
}
