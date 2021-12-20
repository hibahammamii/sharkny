import 'package:flutter/material.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/utilities/styles.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController? textController;
  final VoidCallback?  onComplete;
  final VoidCallback?  onTap;
  final VoidCallback?  onClose;
   const SearchBar({
       Key? key,
       this.textController,
       this.onTap,
       this.onClose,
       this.onComplete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      height: 52,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.transparent,
        child: TextFormField(
          cursorColor: colorAccent,
          enabled: true,
          controller: textController,
          onTap: onTap,
          keyboardType: TextInputType.text,
          cursorWidth: 1,
          autofocus: false,
          onEditingComplete: onComplete,
          style: const TextStyle(
              color: mainTextColor, fontWeight: FontWeight.w600, fontSize: 16),
          decoration: InputDecoration(
            icon: const Icon(
              Icons.search,
              color: colorAccent,
            ),
            // ignore: unnecessary_null_comparison
            suffixIcon: onClose != null
                ? GestureDetector(
                    onTap: onClose,
                    child: const Icon(
                      Icons.close,
                      color: blackColor,
                    ),
                  )
                : null,
            hintText: AppLocalizations.of(context)!.translate("search"),
            hintStyle: TextStyle(
              color: colorAccent.withOpacity(0.4),
              fontWeight: FontWeight.w300,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
