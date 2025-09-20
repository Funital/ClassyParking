import 'package:flutter/material.dart';

import '../../core/constants/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          icon: const Icon(Icons.menu, color: AppColor.mainRed),
          iconSize: 40,
          onPressed: (){},
          // onPressed: () => showMiniAddMenu(context),
        ),
      ),
      title: GestureDetector(
          onTap: (){
            // context.go(RoutePath.home);
          },
          child: Image.asset('assets/images/classyparking_logo.png', height: 50)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            iconSize: 40,
            onPressed: () {
              // context.push(RoutePath.myPage);
            },
          ),
        ),
      ],
    );
  }
}
