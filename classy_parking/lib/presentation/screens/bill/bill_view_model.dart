import 'package:classy_parking/presentation/screens/bill/bill_model.dart';
import 'package:flutter/material.dart';

class BillViewModel extends ChangeNotifier {
  List<BillModel> getTopBill(BuildContext context) => [
    BillModel(
        index: '01',
        address: '경기도 안양시 동안구 시민대로',
        date: '2025년 09월 09일(화)',
        time: '13:00 ~ 16:00',
        fee: '3,000',
        payment: '카카오페이',
        onTap: () {  }
    ),
    BillModel(
        index: '02',
        address: '경기도 안양시 만안구 안양동',
        date: '025년 09월 04일(목)',
        time: '10:00 ~ 15:00',
        fee: '7,500',
        payment: '카카오페이',
        onTap: () {  }
    ),
  ];
}