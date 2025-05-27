import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_shelf/core/loaders/loading_overlay.dart';
import 'package:fresh_shelf/core/routing/route_path.dart';
import 'package:fresh_shelf/core/utils.dart';
import 'package:fresh_shelf/layers/bloc/bill_detail/bill_detail_cubit.dart';
import 'package:fresh_shelf/layers/bloc/get_bills/get_bills_cubit.dart';

import '../../../../core/ui/waiting_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../bloc/product/product_cubit.dart';
import '../../../data/model/bill.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final _getBillsCubit = sl<GetBillsCubit>();
  List<Bill> bills = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBillsCubit.getBills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).bills),
        centerTitle: true,
      ),
      body: BlocConsumer<GetBillsCubit, GetBillsState>(
        bloc: _getBillsCubit,
        listener: (context, state) {
          if (state is GetBillsLoaded) {
            bills = List.from(state.bills.reversed);
            setState(() {});
          } else if (state is BillRemoving) {
            LoadingOverlay.of(context).show();
          } else if (state is BillRemoved) {
            _getBillsCubit.getBills();
            LoadingOverlay.of(context).hide();
          } else if (state is BillRemovingError) {
            LoadingOverlay.of(context).hide();
            Utils.showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is GetBillsLoading) {
            return Center(
              child: WaitingWidget(),
            );
          } else if (state is GetBillsError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            if (bills.isNotEmpty) {
              return ListView.builder(
                itemCount: bills.length,
                itemBuilder: (context, index) {
                  Bill bill = bills[index];
                  return GestureDetector(
                    onTap: () {
                      sl<BillDetailCubit>().getBillCart(bill.id);
                      Navigator.of(context)
                          .pushNamed(RoutePaths.BillDetailScreen);
                    },
                    child: Card(
                      child: ListTile(
                        leading: Text(bill.status),
                        title: Text(bill.createdAt.toString().substring(0, 10)),
                        subtitle: Text(bill.price.toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => _getBillsCubit.removeBill(bill.id),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(S.of(context).noBills),
              );
            }
          }
        },
      ),
    );
  }
}
