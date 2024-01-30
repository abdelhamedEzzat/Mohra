import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.leading,
  }) : super(key: key);

  final Widget title;
  final Widget? leading;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70.h,
      surfaceTintColor: ColorManger.backGroundColorToSplashScreen,
      title: widget.title,
      titleTextStyle: Theme.of(context)
          .textTheme
          .displayMedium!
          .copyWith(color: Colors.white),
      leading: widget.leading,
      iconTheme: IconThemeData(size: 18.h),
      elevation: 0,
      backgroundColor: ColorManger.appbarColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: Icon(
              isSearch == false ? Icons.search : Icons.clear,
              color: ColorManger.white,
            ),
            onPressed: () {
              setState(() {
                isSearch == true;
              });

              if (isSearch = true) {
                Navigator.of(context)
                    .pushNamed(RouterName.searchScreenForAdmin);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
