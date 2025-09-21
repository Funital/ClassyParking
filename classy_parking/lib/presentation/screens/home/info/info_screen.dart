import 'package:classy_parking/core/constants/font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_sub_app_bar.dart';
import '../../../widgets/info_box.dart';
import 'info_view_model.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InfoViewModel(),
      child: Scaffold(
        appBar: CustomSubAppBar(title: '서비스 이용 안내'),
        backgroundColor: Colors.grey[100],
        body: Consumer<InfoViewModel>(
          builder: (context, vm, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.directions_car,
                            size: 50, color: Colors.blue),
                        SizedBox(height: 8),
                        Text(
                          "서비스 이용 안내",
                          style: AppFont.size22.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                          )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...vm.infos.map((info) => InfoBox(info: info)).toList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}