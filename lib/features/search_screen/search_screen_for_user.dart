import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';

class CustomAppBarForUsers extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBarForUsers({
    Key? key,
    this.title,
    this.leading,
    this.searchController,
  }) : super(key: key);

  final Widget? title;
  final Widget? leading;
  final TextEditingController? searchController;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _CustomAppBarState extends State<CustomAppBarForUsers> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: isSearching ? widget.title : widget.title,
        titleTextStyle: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: Colors.white),
        leading: widget.leading,
        iconTheme: IconThemeData(size: 18.h),
        elevation: 0,
        backgroundColor: ColorManger.backGroundColorToSplashScreen,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.of(context)
                      .pushNamed(RouterName.searchScreenForUser);

                  // Check if there's anything to pop before calling Navigator.pop
                });
              },
              child: isSearching
                  ? const Icon(
                      Icons.delete,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class searchuser extends StatefulWidget {
  const searchuser({super.key});

  @override
  State<searchuser> createState() => _searchuserState();
}

class _searchuserState extends State<searchuser> {
  TextEditingController _searchController = TextEditingController();
  bool isSearch = false;
  bool _isSearching = false;
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarForUsers(
        leading: BackButton(color: Colors.white),
        title: buildSearchBar(),
        searchController: _searchController, // Pass the searchController
      ),
      body: Visibility(
        visible: _isSearching && _searchController.text.isNotEmpty,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Companys')
              .where('userID',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print(FirebaseAuth.instance.currentUser!.uid);
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData || snapshot.data.docs == null) {
              // Check if there's no data or docs are null
              print('No data');
              return Center(
                child: Text(
                  "No data available",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              );
            } else {
              // Data is available, proceed with building the list
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    try {
                      var data = snapshot.data.docs[index].data();
                      if (_searchController.text.isEmpty) {
                        return Center(
                          child: Text(
                            "Write anything to search",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        );
                      } else if (data['company_Name']
                          .toString()
                          .toLowerCase()
                          .startsWith(_searchController.text.toLowerCase())) {
                        const SizedBox(
                          height: 40,
                        );
                        return CompanyButton(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouterName.companyDocuments,
                                arguments: snapshot.data.docs[index]
                                    ["companyId"]);
                          },
                          withStatus: true,
                          companyName: snapshot.data.docs[index]
                              ["company_Name"],
                          logoCompany: snapshot.data.docs[index]["logo"],
                          colorOfStatus: snapshot.data.docs[index]
                                      ["CompanyStatus"] ==
                                  'Accepted'
                              ? Colors.green
                              : Colors.red,
                          statusText: snapshot.data.docs[index]
                              ["CompanyStatus"],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    } catch (e) {
                      print(e.toString());
                      return SizedBox.shrink();
                    }
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: const TextStyle(color: Colors.white),
                suffixIcon: _isSearching
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _isSearching = false;
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _isSearching = value.isNotEmpty;
                  name = value;
                  _searchController.text = name;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
// import 'package:mohra_project/core/helpers/custom_app_bar.dart';
// import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';

// class CustomAppBaruSER extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBaruSER({
//     Key? key,
//     required this.isSearch,
//     required this.onSearchTap,
//     required this.onClearSearch,
//     required this.title,
//     this.leading,
//   }) : super(key: key);

//   final bool isSearch;
//   final VoidCallback onSearchTap;
//   final VoidCallback onClearSearch;
//   final Widget title;
//   final Widget? leading;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       toolbarHeight: 70,
//       title: isSearch
//           ? Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "Search...",
//                         hintStyle: const TextStyle(color: Colors.white),
//                         prefixIcon: const Icon(
//                           Icons.search,
//                           color: Colors.white,
//                         ),
//                         suffixIcon: isSearch
//                             ? IconButton(
//                                 icon: const Icon(
//                                   Icons.delete,
//                                   color: Colors.white,
//                                 ),
//                                 onPressed: onClearSearch,
//                               )
//                             : null,
//                       ),
//                       onChanged: (value) {
//                         // Handle search logic if needed
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : title,
//       titleTextStyle: Theme.of(context)
//           .textTheme
//           .displayMedium!
//           .copyWith(color: Colors.white),
//       leading: leading,
//       iconTheme: const IconThemeData(size: 18),
//       elevation: 0,
//       backgroundColor: ColorManger.backGroundColorToSplashScreen,
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 20),
//           child: GestureDetector(
//             onTap: onSearchTap,
//             child: Icon(
//               isSearch ? Icons.clear : Icons.search,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => const Size.fromHeight(56);
// }
