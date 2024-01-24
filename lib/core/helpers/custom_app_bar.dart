import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
  });
  final Widget title;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 70.h,
        surfaceTintColor: ColorManger.backGroundColorToSplashScreen,
        title: title,
        titleTextStyle: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: Colors.white),
        leading: leading,
        iconTheme: IconThemeData(size: 18.h),
        elevation: 0,
        backgroundColor: ColorManger.appbarColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: ColorManger.white,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: MySearchDelegate());
                }),
          ),
        ]);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    String? selectItem;

    List<String> suggestion = ["barazel ", "roma"];
    return Container(
      padding: EdgeInsets.all(10.h),
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Fillters",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextFormField(
            //   controller: searchContraller,
            hintText: "Write Name to Accountant or Auditor",
            prefixIcon: const Icon(Icons.email),
            labelText: "name",
            onChanged: (value) {
              // setState(() {
              //   searchResultList();
              // });
            },
          ),
          // StreamBuilder(
          //       stream: selectStaffType,
          //       builder: (context, snapshot) {
          //         Set<String> uniqueRoles = Set();
          //         List<DropdownMenuItem<String>> staffTypeList = [];
          //         if (snapshot.hasData) {
          //           final staffType = snapshot.data?.docs.reversed.toList();
          //           for (var staff in staffType!) {
          //             String role = staff['role'];

          //             if (!uniqueRoles.contains(role)) {
          //               uniqueRoles.add(role);
          //               staffTypeList.add(DropdownMenuItem(
          //                 value: staff.id,
          //                 child: Text(role),
          //               ));
          //             }
          //           }
          //         }

          //         return Container(
          //           padding:
          //               EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
          //           decoration: BoxDecoration(
          //               color: ColorManger.white,
          //               borderRadius: BorderRadius.circular(15.h),
          //               border: Border.all(color: ColorManger.darkGray)),
          //           child: DropdownButton<String>(
          //             hint: Text(
          //               "Select Type",
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .displayMedium!
          //                   .copyWith(
          //                       color:
          //                           ColorManger.backGroundColorToSplashScreen),
          //             ),
          //             borderRadius: BorderRadius.circular(10),
          //             isExpanded: true,
          //             value: selectItem,
          //             items: staffTypeList,
          //             onChanged: (item) => setState(() {
          //               selectItem = item!;
          //               print(selectItem);
          //             }),
          //           ),
          //         );
          //       },
          //     ),
        ],
      ),
    );

    // ListView.builder(
    //   itemCount: suggestion.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return ListTile(
    //       title: Text(suggestion[index]),
    //     );
    //   },
    // );
  }
}
