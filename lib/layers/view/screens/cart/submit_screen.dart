import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_shelf/core/app/state/app_state.dart';
import 'package:fresh_shelf/core/configuration/styles.dart';
import 'package:fresh_shelf/core/routing/route_path.dart';
import 'package:fresh_shelf/layers/bloc/add_bill/add_bill_cubit.dart';
import 'package:fresh_shelf/layers/data/model/cart.dart';
import 'package:provider/provider.dart';

import '../../../../core/loaders/loading_overlay.dart';
import '../../../../core/utils.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';

class SubmitCartScreen extends StatelessWidget {
  SubmitCartScreen({Key? key}) : super(key: key);

  final double tax = 0.03;
  final int delivery = 5000;

  final _addBillCubit = sl<AddBillCubit>();

  int getTotalPrice(int cartTotalPrice) {
    return cartTotalPrice + (cartTotalPrice * tax).floor() + delivery;
  }

  orderCart(BuildContext context) async {
    if (Provider.of<AppState>(context, listen: false).address != null) {
      _addBillCubit.addBill();
    } else {
      Navigator.of(context).pushNamed(RoutePaths.AddressScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<AppState>(context, listen: false).cart!;
    return BlocListener<AddBillCubit, AddBillState>(
      bloc: _addBillCubit,
      listener: (context, state) async {
        if (state is BillUploading) {
          LoadingOverlay.of(context).show();
        } else if (state is BillUploaded) {
          await Provider.of<AppState>(context, listen: false).getCart();
          LoadingOverlay.of(context).hide();
          Navigator.of(context).pop();
          //Navigator.of(context).pop();
          Utils.showSnackBar(context, S.of(context).productsOrdered);
        } else if (state is BillError) {
          LoadingOverlay.of(context).hide();
          Utils.showSnackBar(context, state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildPadding(
                  '${S.of(context).orderCost}:', '${cart.totalPrice} SP'),
              const SizedBox(
                height: 10,
              ),
              buildPadding('${S.of(context).tax}:',
                  '${(cart.totalPrice * tax).floor()} SP'),
              const SizedBox(
                height: 10,
              ),
              buildPadding('${S.of(context).delivery}:', '${delivery} SP'),
              const SizedBox(
                height: 10,
              ),
              buildPadding('${S.of(context).totalPrice}:',
                  '${getTotalPrice(cart.totalPrice)} SP'),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => orderCart(context),
                  child: Container(
                    height: 50,
                    width: 250,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey,
                      gradient: const LinearGradient(
                          colors: [Color(0xFF2AAA8A), Color(0xFFAFE1AF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                    ),
                    child: Text(
                      S.of(context).confirm,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPadding(String title, tail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                tail,
                style: TextStyle(
                  color: Styles.colorPrimary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
