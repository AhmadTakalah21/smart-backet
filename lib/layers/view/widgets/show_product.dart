import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_shelf/core/app/state/app_state.dart';
import 'package:fresh_shelf/core/configuration/styles.dart';
import 'package:fresh_shelf/core/utils.dart';
import 'package:fresh_shelf/layers/data/model/product.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../injection_container.dart';
import '../../../l10n/local_provider.dart';

class ProductDialog {
  final Product product;

  ProductDialog({required this.product});

  void showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: DialogContent(
            product: product,
          ),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }
}

class DialogContent extends StatefulWidget {
  const DialogContent({super.key, required this.product});

  final Product product;

  @override
  State<DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).viewInsets,
      width: double.maxFinite,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Builder(
                    builder: (context) {
                      final provider =
                          Provider.of<AppState>(context, listen: true);
                      return IconButton(
                        icon: Icon(
                          provider.wishProducts
                                  .where((element) =>
                                      element.id == widget.product.id)
                                  .isNotEmpty
                              ? Icons.remove
                              : Icons.my_library_add,
                          color: Styles.colorPrimary,
                        ),
                        onPressed: () {
                          provider.wishProducts
                                  .where((element) =>
                                      element.id == widget.product.id)
                                  .isNotEmpty
                              ? provider.removeFromWishlist(
                                  widget.product.id, context)
                              : provider.addToWishlist(
                                  widget.product.id, context);
                        },
                      );
                    },
                  ),
                ],
              ),
              Text(
                widget.product.description,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (_quantity > 1) {
                        _quantity--;
                        setState(() {});
                      }
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    style: IconButton.styleFrom(
                        backgroundColor: Styles.colorPrimary),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${_quantity}",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      if (_quantity < 10) {
                        _quantity++;
                        setState(() {});
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Styles.colorPrimary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    "${S.of(context).totalPrice}: ${_quantity * widget.product.price} SYR",
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: Align(
                      alignment: sl<LocaleProvider>().locale != null
                          ? sl<LocaleProvider>().locale!.languageCode == 'ar'
                              ? Alignment.centerLeft
                              : Alignment.centerRight
                          : Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: Styles.colorPrimary,
                        ),
                        onPressed: () {
                          Provider.of<AppState>(context, listen: false)
                              .addToCart(widget.product, _quantity);
                          Navigator.of(context).pop();
                          Utils.showSnackBar(context,
                              "${_quantity} ${widget.product.name} ${S.of(context).addToCart}");
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
