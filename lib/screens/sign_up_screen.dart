import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/providers/auth_provider.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';

import 'log_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "SignUpScreen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? frontIdPicture;
  String? backIdPicture;
  String? commercialPicture;
  String? taxCardPicture;
  bool? _isLoading;
  String? _name,
      _email,
      _phone,
      _password,
      _cPassword,
      _fbLink,
      _commercialNum,
      _cardNum,
      _companyName;

  XFile? imageFile;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _passwordController.dispose();
    _cPasswordController.dispose();
    //textController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    locator<AuthProvider>().signUp(context, _scaffoldKey,
        password: _password,
        cpassword: _cPassword,
        email: _email,
        name: _name,
        phone: _phone,
        linkName: _fbLink);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.appBar(context, "") as PreferredSizeWidget?,
      body: Stack(
        children: [body(context)],
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }

  Widget body(BuildContext context) {
    bool isVendor = locator<AuthProvider>().getIsVendor();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Future<void> _showChoiceDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Choose option",
                style: TextStyle(color: colorAccent),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    const Divider(height: 1, color: colorAccent),
                    ListTile(
                      onTap: () {
                        _openGallery(context);
                      },
                      title: const Text("Gallery"),
                      leading:
                          const Icon(Icons.account_box, color: colorAccent),
                    ),
                    const Divider(
                      height: 1,
                      color: colorAccent,
                    ),
                    ListTile(
                      onTap: () {
                        _openCamera(context);
                      },
                      title: const Text("Camera"),
                      leading: const Icon(Icons.camera, color: colorAccent),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                      AppLocalizations.of(context)!.translate("sign_up_page"),
                      style: AppTextStyle.mainTextStyle.copyWith(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
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
                        labelText:
                            AppLocalizations.of(context)!.translate("name"),
                        labelStyle: AppTextStyle.subTextStyle,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: colorAccent)),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: lightGrey)),
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
                      height: 25,
                    ),
                    TextFormField(
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
                        labelText:
                            AppLocalizations.of(context)!.translate("phone"),
                        labelStyle: AppTextStyle.subTextStyle,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: colorAccent)),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: lightGrey)),
                      ),
                      onSaved: (val) {
                        _phone = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty && value.length < 11) {
                          return "";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25,
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
                      height: 25,
                    ),
                    TextFormField(
                      cursorColor: colorAccent,
                      controller: _cPasswordController,
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
                        labelText: AppLocalizations.of(context)!
                            .translate("re_password"),
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
                        _cPassword = val;
                      },
                      validator: (value) {
                        if (_passwordController.text !=
                            _cPasswordController.text) {
                          return "Password is not match";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
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
                            .translate("facebook_link"),
                        labelStyle: AppTextStyle.subTextStyle,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: colorAccent)),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: lightGrey)),
                      ),
                      onSaved: (val) {
                        _fbLink = val;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    // if (isVendor)
                    //   Column(
                    //     children: [
                    //       const SizedBox(
                    //         height: 25,
                    //       ),
                    //
                    //       const SizedBox(
                    //         height: 25,
                    //       ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       AppLocalizations.of(context)!
                    //           .translate("front_id_picture"),
                    //       style: AppTextStyle.subTextStyle,
                    //     ),
                    //     TextButton(
                    //         onPressed: () async {
                    //           await _showChoiceDialog(context);
                    //           if(imageFile != null) {
                    //             frontIdPicture =
                    //               await _convertToBase64(imageFile!);
                    //           }
                    //           setState(() {
                    //             imageFile = null;
                    //           });
                    //
                    //         },
                    //         child: Image.asset(
                    //           "assets/images/upload_image.png",
                    //           width: 20,
                    //           height: 20,
                    //         )),
                    //     if (frontIdPicture != null)
                    //       Image.memory(
                    //         _getImage(frontIdPicture),
                    //         width: 60,
                    //         height: 60,
                    //       ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 6,
                    // ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       AppLocalizations.of(context)!
                    //           .translate("back_id_picture"),
                    //       style: AppTextStyle.subTextStyle,
                    //     ),
                    //     TextButton(
                    //         onPressed: () async {
                    //           await _showChoiceDialog(context);
                    //           if(imageFile !=null) {
                    //             backIdPicture =
                    //               await _convertToBase64(imageFile!);
                    //           }
                    //           setState(() {
                    //             imageFile = null;
                    //           });
                    //
                    //         },
                    //         child: Image.asset(
                    //           "assets/images/upload_image.png",
                    //           width: 20,
                    //           height: 20,
                    //         )),
                    //     if (backIdPicture != null)
                    //       Image.memory(
                    //         _getImage(backIdPicture),
                    //         width: 60,
                    //         height: 60,
                    //       ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 6,
                    // ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       AppLocalizations.of(context)!
                    //           .translate("commercial_record_picture"),
                    //       style: AppTextStyle.subTextStyle,
                    //     ),
                    //     TextButton(
                    //         onPressed: () async {
                    //           await _showChoiceDialog(context);
                    //           if(imageFile !=null) {
                    //             commercialPicture =
                    //               await _convertToBase64(imageFile!);
                    //           }
                    //           setState(() {
                    //             imageFile = null;
                    //           });
                    //         },
                    //         child: Image.asset(
                    //           "assets/images/upload_image.png",
                    //           width: 20,
                    //           height: 20,
                    //         )),
                    //     if (commercialPicture != null)
                    //       Image.memory(
                    //         _getImage(commercialPicture),
                    //         width: 60,
                    //         height: 60,
                    //       ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 6,
                    // ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       AppLocalizations.of(context)!
                    //           .translate("tax_card_picture"),
                    //       style: AppTextStyle.subTextStyle,
                    //     ),
                    //     TextButton(
                    //         onPressed: () async {
                    //           await _showChoiceDialog(context);
                    //           if(imageFile !=null) {
                    //             taxCardPicture =
                    //               await _convertToBase64(imageFile!);
                    //           }
                    //           setState(() {
                    //             imageFile =null;
                    //           });
                    //         },
                    //         child: Image.asset(
                    //           "assets/images/upload_image.png",
                    //           width: 20,
                    //           height: 20,
                    //         )),
                    //     if (taxCardPicture != null)
                    //       Image.memory(
                    //         _getImage(taxCardPicture),
                    //         width: 60,
                    //         height: 60,
                    //       ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    // TextFormField(
                    //   cursorColor: colorAccent,
                    //   keyboardType: TextInputType.emailAddress,
                    //   cursorWidth: 1,
                    //   textAlign: TextAlign.start,
                    //   textDirection: TextDirection.ltr,
                    //   autofocus: false,
                    //   style: const TextStyle(
                    //       color: blackColor,
                    //       fontWeight: FontWeight.w800,
                    //       fontSize: 15),
                    //   decoration: InputDecoration(
                    //     labelText: AppLocalizations.of(context)!
                    //         .translate("record_number"),
                    //     labelStyle: AppTextStyle.subTextStyle,
                    //     focusedBorder: const UnderlineInputBorder(
                    //         borderSide: BorderSide(color: colorAccent)),
                    //     border: const UnderlineInputBorder(
                    //         borderSide: BorderSide(color: lightGrey)),
                    //   ),
                    //   onSaved: (val)
                    //
                    //   {
                    //     _commercialNum = val;
                    //   },
                    //   validator: (val)
                    //   {
                    //     if(val!.isEmpty)
                    //       {
                    //         return "enter your record number";
                    //       }
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    // TextFormField(
                    //   cursorColor: colorAccent,
                    //   keyboardType: TextInputType.number,
                    //   cursorWidth: 1,
                    //   textAlign: TextAlign.start,
                    //   textDirection: TextDirection.ltr,
                    //   autofocus: false,
                    //   style: const TextStyle(
                    //       color: blackColor,
                    //       fontWeight: FontWeight.w800,
                    //       fontSize: 15),
                    //   decoration: InputDecoration(
                    //     labelText: AppLocalizations.of(context)!
                    //         .translate("card_number"),
                    //     labelStyle: AppTextStyle.subTextStyle,
                    //     focusedBorder: const UnderlineInputBorder(
                    //         borderSide: BorderSide(color: colorAccent)),
                    //     border: const UnderlineInputBorder(
                    //         borderSide: BorderSide(color: lightGrey)),
                    //   ),
                    //   onSaved: (val)
                    //
                    //   {
                    //     _cardNum = val;
                    //   },
                    //   validator: (val)
                    //   {
                    //     if(val!.isEmpty)
                    //     {
                    //       return "enter your id number";
                    //     }
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    // TextFormField(
                    //   cursorColor: colorAccent,
                    //   keyboardType: TextInputType.emailAddress,
                    //   cursorWidth: 1,
                    //   textAlign: TextAlign.start,
                    //   textDirection: TextDirection.ltr,
                    //   autofocus: false,
                    //   style: const TextStyle(
                    //       color: blackColor,
                    //       fontWeight: FontWeight.w800,
                    //       fontSize: 15),
                    //   decoration: InputDecoration(
                    //     labelText: AppLocalizations.of(context)!
                    //         .translate("company_name"),
                    //     labelStyle: AppTextStyle.subTextStyle,
                    //     focusedBorder: const UnderlineInputBorder(
                    //         borderSide: BorderSide(color: colorAccent)),
                    //     border: const UnderlineInputBorder(
                    //         borderSide: BorderSide(color: lightGrey)),
                    //   ),
                    //   onSaved: (val)
                    //
                    //   {
                    //     _companyName = val;
                    //   },
                    // ),
                    //     ],
                    //   ),
                    //
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    Consumer<AuthProvider>(builder: (_, data, __) {
                      if (data.loading) {
                        return Container(
                          color: Colors.white,
                          child: Center(
                            child: Constants.loadingElement(),
                          ),
                        );
                      }
                  return  Constants.buttonLinearGradient(
                      text: AppLocalizations.of(context)!.translate("sign_up"),
                      onTap: () async {
                        _submit();
                      },
                    );}),


                     Center(
                        child: InkWell(
                            onTap: () async {
                              locator<NavigationServices>()
                                  .navigateTo(LoginScreen.routeName);
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: RichText(
                                  text: TextSpan(
                                    text: AppLocalizations.of(context)!
                                            .translate("have_account") +
                                        "  ",
                                    style: AppTextStyle.subTextStyle,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .translate("sign_in"),
                                        style: AppTextStyle.subTextStyle
                                            .copyWith(
                                                color: blackColor,
                                                fontSize: 18),
                                      )
                                    ],
                                  ),
                                ))),

                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Future<XFile?> _openGallery(BuildContext context) async{
//   final pickedFile = await ImagePicker().pickImage(
//     source: ImageSource.gallery ,
//   );
//  return pickedFile;
//
//
// }
//
// Future<XFile?> _openCamera(BuildContext context)  async{
//   final pickedFile =await ImagePicker().pickImage(
//     source: ImageSource.camera ,
//   );
//
// return pickedFile;
//
// }
Future<String> _convertToBase64(XFile image) async {
  final imageBytes = image.readAsBytes();

  String base64Image = base64Encode(await imageBytes);
  return base64Image;
}

_getImage(String? imageBase64) {
  Uint8List bytes = base64.decode(imageBase64!);
  return bytes;
}
