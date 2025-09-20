import 'package:classy_parking/core/constants/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/color.dart';
import '../../core/router/route_path.dart';

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
          icon: const Icon(Icons.menu, color: Colors.blue),
          iconSize: 40,
          onPressed: (){},
          // onPressed: () => showMiniAddMenu(context),
        ),
      ),
      title: GestureDetector(
          onTap: (){
            // context.go(RoutePath.home);
          },
          child: Text(
            '주차의 품격',
            style: AppFont.size20.copyWith(
              fontWeight: FontWeight.w800,
              color: Colors.black
            ),
          )
      ),
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
              context.push(RoutePath.myPage);
            },
          ),
        ),
      ],
    );
  }
}
