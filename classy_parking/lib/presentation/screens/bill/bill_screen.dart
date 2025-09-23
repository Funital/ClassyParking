import 'package:classy_parking/presentation/screens/bill/component/bill_box.dart';
import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bill_view_model.dart';

class BillScreen extends StatelessWidget {
  const BillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSubAppBar(title: '이용 내역'),
      body: ChangeNotifierProvider(
        create: (_) => BillViewModel(),
        child: Consumer<BillViewModel>(
          builder: (context, billViewModel, child) {
            final bills = billViewModel.getTopBill(context);
            return Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: bills.length,
                    itemBuilder: (context, index) {
                      final bill = bills[index];
                      return BillBox(
                        index: bill.index,
                        address: bill.address,
                        date: bill.date,
                        time: bill.time,
                        fee: bill.fee,
                        payment: bill.payment,
                        onTap: bill.onTap,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
