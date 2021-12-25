import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:search_widget/search_widget.dart';
import 'package:sharekny_app/providers/search_model.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';
import 'package:sharekny_app/widgets/product_item.dart';
import 'package:sharekny_app/widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "SearchScreen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textEditingController = TextEditingController();
  String? searchWord="";
  void onSubmit(){
    locator<SearchModel>().searchProducts(name: textEditingController.text);
  }
  @override
  void initState() {
    // TODO: implement initState

  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {

        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: Constants.appBar(context, "search") as PreferredSizeWidget?,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: <Widget>[

              Card(
                          child:Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                            height: 52,
                            decoration: BoxDecoration(
                                color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              cursorColor: colorAccent,
                              enabled: true,
                              onSaved: (val) {
                                searchWord = val;
                              },
                              keyboardType: TextInputType.text,
                              cursorWidth: 1,
                              autofocus: false,
                              controller: textEditingController,
                              onEditingComplete: onSubmit,

                              style: const TextStyle(
                                  color: blackColor, fontWeight: FontWeight.w600, fontSize: 16),
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.search,
                                  color: colorAccent,
                                ),
                                // ignore: unnecessary_null_comparison

                                hintText: AppLocalizations.of(context)!.translate("search"),
                                hintStyle: const TextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.w300,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          shadowColor: lightGrey,
                          elevation: 20,
                          color: Colors.white),
              const SizedBox(
                height: 32,
              ),
              Consumer<SearchModel>(builder: ( _,data,__)
              {
                if (data.loadingProducts == true) {
                  return Container(

                    color: Colors.white,
                    child: Center(
                      child: Constants.loadingElement(),
                    ),
                  );
                }

                return data.products.isNotEmpty
                    ? SizedBox(
                  height: height,

                  child:
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: data.products.length,
                    itemBuilder: (ctx, i) =>
                        ChangeNotifierProvider.value(
                          // builder: (c) => products[i],
                          value: data.products[i],
                          child: ProductItem(
                            // products[i].id,
                            // products[i].title,
                            // products[i].imageUrl,
                          ),
                        ),
                  ),
                )
                    :
                Container(child:  const Text(
                  " No item selected",
                ),);
              },),


                    ],
                  ),
                ),



          ),
    );

  }
}

class LeaderBoard {
  LeaderBoard(this.username, this.score);

  final String username;
  final double score;
}

class SelectedItemWidget extends StatelessWidget {
  const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);

  final LeaderBoard selectedItem;
  final VoidCallback deleteSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: Text(
                selectedItem.username,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, size: 22),
            color: Colors.grey[700],
            onPressed: deleteSelectedItem,
          ),
        ],
      ),
    );
  }
}

/*class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search here...",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}*/

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900]!.withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900]!.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final LeaderBoard item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        item.username,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
