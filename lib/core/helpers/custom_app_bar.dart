import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
  });
  final Widget title;
  final Widget? leading;

  final bool isSearch = false;

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
                  isSearch ? Icons.search : Icons.clear,
                  color: ColorManger.white,
                ),
                onPressed: () {
                  isSearch
                      ? Navigator.of(context).pushNamed(RouterName.searchScreen)
                      : Navigator.pop(context);
                  isSearch == true;
                }),
          ),
        ]);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}

// class MySearchDelegate extends SearchDelegate {
//   late TextEditingController companyController;
//   late List<DocumentSnapshot> companySearchList;
//   late List<DocumentSnapshot> companySearchResults;
//   List<Map<String, dynamic>> nameResultList = [];
//   final VoidCallback onUpdateUI;

//   MySearchDelegate(
//       {super.searchFieldLabel,
//       super.searchFieldStyle,
//       super.searchFieldDecorationTheme,
//       super.keyboardType,
//       super.textInputAction,
//       required this.companySearchList,
//       required this.onUpdateUI}) {
//     companyController = TextEditingController();
//     companySearchResults = List.from(companySearchList);
//   }
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {
//             if (query.isEmpty) {
//               close(context, null);
//             } else {
//               query = '';
//             }
//           },
//           icon: const Icon(Icons.close))
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () => close(context, null),
//         icon: const Icon(Icons.arrow_back));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     onUpdateUI(); //
//     return SizedBox(
//       height: companyController.text.isEmpty
//           ? 0
//           : MediaQuery.of(context).size.height * 0.25,
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: nameResultList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 Map<String, dynamic> resultData = nameResultList[index];
//                 return buildResultItem(
//                   resultData[index],
//                   companyController,
//                   onUpdateUI,
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     String? selectTypeItem;

//     // List<String> typeDocumentDropDown = [];
//     // String? selectItem;
//     // List<String> suggestion = ["barazel ", "roma"];

//     return Container(
//       padding: EdgeInsets.all(10.h),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 15.h,
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               "Fillters",
//               style: Theme.of(context).textTheme.displayMedium,
//             ),
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           CustomTextFormField(
//             controller: companyController,
//             hintText: "Write Name to Accountant or Auditor",
//             prefixIcon: const Icon(Icons.email),
//             labelText: "name",
//             onChanged: (value) {
//               searchResultListCompanys();
//               onUpdateUI(); // Update search results on text change.
//             },
//           ),
//           StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection('Companys')
//                 // Use the selected company's document ID
//                 .snapshots(),
//             builder: (context, snapshot) {
//               // snapshot.data.docs[]
//               //  QueryDocumentSnapshot<Object?> staffDocument =
//               //               snapshot.data!.docs;
//               //           var staffCompanyId = staffDocument['CompanyId'];
//               if (snapshot.hasData) {
//                 // Get the companyId from the selected company's document
//                 // String? companyId = snapshot.data!.get('companyId');

//                 return StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection(
//                           'Document') // Replace with your actual collection
//                       .where('companydocID', isEqualTo: 'companyId')
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     List<String> dropdownItems = [];
//                     if (snapshot.hasData) {
//                       // // Handle the search results here
//                       // List<DocumentSnapshot> searchResults = snapshot.data!.docs;
//                       // // You can use searchResults to display the results as needed
//                       // // For example, you might want to create a ListView.builder to display them.
//                       // // Don't forget to call onUpdateUI if needed

//                       dropdownItems = snapshot.data!.docs
//                           .map((DocumentSnapshot<Object?> item) =>
//                               item['additionalInformation'])
//                           .where((info) => info != null)
//                           .map((info) {
//                             if (info is List) {
//                               // If additionalInformation is a list, concatenate its items
//                               return info
//                                   .map((item) => item.toString())
//                                   .join(', ');
//                             } else {
//                               return info.toString();
//                             }
//                           })
//                           .expand((info) => info.split(','))
//                           .map((item) => item.trim())
//                           .toList();
//                       return Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 20.w, vertical: 2.h),
//                         decoration: BoxDecoration(
//                             color: ColorManger.white,
//                             borderRadius: BorderRadius.circular(15.w),
//                             border: Border.all(color: ColorManger.darkGray)),
//                         child: DropdownButton<String>(
//                           hint: Text(
//                             "Select Type Of Document",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displayMedium!
//                                 .copyWith(
//                                     color: ColorManger
//                                         .backGroundColorToSplashScreen),
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                           isExpanded: true,
//                           value: selectTypeItem,
//                           items: dropdownItems.map((String item) {
//                             return DropdownMenuItem(
//                               value: item,
//                               child: Text(
//                                 item,
//                                 style:
//                                     Theme.of(context).textTheme.displayMedium,
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (item) => selectTypeItem = item!,
//                         ),
//                       );
//                       onUpdateUI();
//                     }

//                     // return Container(
//                     //   // Your UI for displaying search results
//                     // );
//                     else if (snapshot.hasError) {
//                       return Text("Error: ${snapshot.error}");
//                     } else {
//                       return CircularProgressIndicator(); // Loading indicator
//                     }
//                   },
//                 );
//               } else if (snapshot.hasError) {
//                 return Text("Error: ${snapshot.error}");
//               } else {
//                 return CircularProgressIndicator(); // Loading indicator
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }

//   void searchResultListCompanys() {
//     var showResultsCompanies = <Map<String, dynamic>>[];

//     if (companyController.text.isNotEmpty) {
//       for (var companySnapshot in companySearchList) {
//         var name = companySnapshot['company_Name'].toString().toLowerCase();
//         if (name.contains(companyController.text.toLowerCase())) {
//           // Assuming you have 'first_Name', 'last_Name', and 'email' fields
//           showResultsCompanies.add({
//             // "first_Name": companySnapshot['first_Name'],
//             // "last_Name": companySnapshot['last_Name'],
//             "email": companySnapshot['email'],
//           });
//         }
//       }
//     } else {
//       showResultsCompanies = List.from(nameResultList);
//     }

//     nameResultList = showResultsCompanies;
//     onUpdateUI();
//   }

//   Widget buildResultItem(
//     DocumentSnapshot<Object?> resultData,
//     TextEditingController companyController,
//     VoidCallback onUpdateUI,
//   ) {
//     // Convert the DocumentSnapshot to a Map<String, dynamic>
//     Map<String, dynamic> data = resultData.data() as Map<String, dynamic>;

//     return Container(
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(25)),
//         color: Colors.white,
//       ),
//       margin: const EdgeInsets.all(8),
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: GestureDetector(
//         onTap: () async {
//           // Updated onTap handler here
//           String companyId = resultData.id;
//           DocumentSnapshot companySnapshot = await FirebaseFirestore.instance
//               .collection('Companys')
//               .doc(companyId)
//               .get();

//           String companyName = companySnapshot['company_Name'];
//           // Add more fields as needed

//           companyController.text = companyName;
//           onUpdateUI(); // Update UI if needed

//           // Close the search delegate
//           // Note: You might need to find an alternative way to close the search delegate if you're not using context
//         },
//         child: ListTile(
//           title: Text(
//             "${data["companyName"]}",
//           ),
//           subtitle: Text(data["email"]),
//         ),
//       ),
//     );
//   }
// }
