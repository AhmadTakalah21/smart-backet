import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_shelf/layers/bloc/bill_detail/bill_detail_cubit.dart';
import 'package:fresh_shelf/layers/data/model/cart_item.dart';

import '../../../../core/configuration/styles.dart';
import '../../../../core/ui/waiting_widget.dart';
import '../../../../injection_container.dart';
import '../../widgets/cart_card.dart';

class BillDetailScreen extends StatelessWidget {
  const BillDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Detail"),
        centerTitle: true,
      ),
      body: BlocBuilder<BillDetailCubit, BillDetailState>(
        bloc: sl<BillDetailCubit>(),
        builder: (context, state) {
          if (state is BillDetailLoading) {
            return Center(
              child: WaitingWidget(),
            );
          } else if (state is BillDetailError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is BillDetailLoaded) {
            return ListView.separated(
              itemCount: state.cart.cart.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == state.cart.cart.length) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Total Cost:',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${state.cart.totalPrice} SYR',
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
                CartItem cartItem = state.cart.cart[index];

                return CartCard(
                  cartItem: cartItem,
                  withButton: false,
                );
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
          return SizedBox();
        },
      ),
    );
  }
}
