import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fresh_shelf/core/app/state/app_state.dart';
import 'package:fresh_shelf/core/configuration/styles.dart';
import 'package:fresh_shelf/core/routing/route_path.dart';
import 'package:fresh_shelf/layers/data/model/cart.dart';
import 'package:fresh_shelf/layers/data/model/cart_item.dart';
import 'package:fresh_shelf/layers/view/widgets/cart_card.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        final cart = Provider.of<AppState>(context, listen: true).cart!;
        if (cart.cart.isNotEmpty) {
          return ListView.separated(
            itemCount: cart.cart.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == cart.cart.length) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${S.of(context).totalPrice}:',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${cart.totalPrice} SYR',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 80.0),
                    ],
                  ),
                );
              }
              CartItem cartItem = cart.cart[index];

              return CartCard(cartItem: cartItem);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 1.0,
                endIndent: 20,
                indent: 20,
                color: Styles.colorPrimary.withOpacity(0.6),
              );
            },
          );
        }
        return Center(
          child: Text(S.of(context).noCart),
        );
      }),
      bottomSheet: Builder(builder: (context) {
        final cart = Provider.of<AppState>(context, listen: true).cart!;

        return cart.cart.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RoutePaths.SubmitCart);
                },
                child: Container(
                  height: 80.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, -1),
                          blurRadius: 6.0,
                        ),
                      ],
                      gradient: LinearGradient(
                          colors: [Styles.colorPrimary, Color(0xFF2AAA8A)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)),
                  child: Center(
                    child: Text(
                      S.of(context).confirm,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox();
      }),
    );
  }
}
