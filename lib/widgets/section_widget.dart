import 'package:flutter/material.dart';
import 'package:sharekny_app/models/product_model.dart';
import 'package:sharekny_app/providers/products_provider.dart';
import 'package:sharekny_app/screens/product_screen.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final double horizontal;
  final double vertical;
  final TextStyle? style;


  const SectionWidget({Key? key, required this.title, required this.horizontal, required this.vertical,this.style}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: Text(
        AppLocalizations.of(context)!.translate(title),
        style: style,
      ),
    );
  }
}
