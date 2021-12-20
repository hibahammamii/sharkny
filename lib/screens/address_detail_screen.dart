import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/styles.dart';

class AddressDetailsScreen extends StatelessWidget{
  static const routeName = "AddressDetailsScreen";
  const AddressDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: Constants.appBar(context, "") as PreferredSizeWidget?,
    body:  SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                AppLocalizations.of(context)!.translate('add_address'),
                style:
                AppTextStyle.mainTextStyle.copyWith(fontSize: 30),
              ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              cursorColor: colorAccent,
              //controller: _nameController,
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
                labelText:
                AppLocalizations.of(context)!.translate("name"),
                labelStyle: AppTextStyle.subTextStyle,
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorAccent)),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: lightGrey)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              cursorColor: colorAccent,
             // controller: _emailController,
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
                labelText:
                AppLocalizations.of(context)!.translate("phone"),
                labelStyle: AppTextStyle.subTextStyle,
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorAccent)),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: lightGrey)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              cursorColor: colorAccent,
              //controller: _emailController,
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
                labelText:
                AppLocalizations.of(context)!.translate("governorate"),
                labelStyle: AppTextStyle.subTextStyle,
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorAccent)),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: lightGrey)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              cursorColor: colorAccent,
              //controller: _passwordController,
              keyboardType: TextInputType.text,
              cursorWidth: 1,
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              autofocus: false,
              style: const TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
              decoration: InputDecoration(
                labelText:
                AppLocalizations.of(context)!.translate("region"),
                errorMaxLines: 2,
                labelStyle: AppTextStyle.subTextStyle.copyWith(
                  letterSpacing: 0.7,
                ),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorAccent)),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: lightGrey)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              cursorColor: colorAccent,
              //controller: _cPasswordController,
              keyboardType: TextInputType.text,
              cursorWidth: 1,

              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              autofocus: false,
              style: const TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!
                    .translate("address"),
                errorMaxLines: 2,
                labelStyle: AppTextStyle.subTextStyle.copyWith(
                  letterSpacing: 0.7,
                ),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorAccent)),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: lightGrey)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              cursorColor: colorAccent,
              //controller: _emailController,
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
                labelText:
                AppLocalizations.of(context)!.translate("more_details"),
                labelStyle: AppTextStyle.subTextStyle,
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorAccent)),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: lightGrey)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              cursorColor: colorAccent,
              //controller: _emailController,
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
                labelText:
                AppLocalizations.of(context)!.translate("notes"),
                labelStyle: AppTextStyle.subTextStyle,
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorAccent)),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: lightGrey)),
              ),
            ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 30),
        child: Constants.buttonLinearGradient(
            text: AppLocalizations.of(context)!.translate("save"),
            onTap: null,
            width: double.infinity),)

          ],
        ),
      ),
    ),

    );
  }
}