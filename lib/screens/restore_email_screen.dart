import 'package:flutter/material.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/utilities/styles.dart';

class AddEmailScreen extends StatefulWidget {
  static const routeName = "AddEmailScreen";
  @override
  _AddEmailScreenState createState() => _AddEmailScreenState();
}

class _AddEmailScreenState extends State<AddEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          body(context),
        ],
      ),
    );
  }

  Widget body(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 32,
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              color: whiteColor,
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.translate("account_restore"),
                      style: AppTextStyle.mainTextStyle.copyWith(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .translate("enter_your_email"),
                      style: AppTextStyle.subTextStyle,
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    TextFormField(
                      cursorColor: redColor,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorWidth: 1,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                      autofocus: false,
                      style: TextStyle(
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
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: verifyEmail,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: redColor,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.translate("restore"),
                          style: AppTextStyle.subTextStyle.copyWith(
                              color: whiteColor, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verifyEmail() {
    /* if (!_emailController.text.isEmail) {
      setState(() {
        _emailError = S.of(context).required_field;
      });
      return;
    }
    _loginController.verifyEmail(_emailController.text);*/
  }
}
