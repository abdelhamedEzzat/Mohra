import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/constans_collections/collections.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/generated/l10n.dart';

class ManageAssignment extends StatefulWidget {
  const ManageAssignment({super.key});

  @override
  State<ManageAssignment> createState() => _ManageAssignmentState();
}

class _ManageAssignmentState extends State<ManageAssignment> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  final TextEditingController searchContraller = TextEditingController();
  final TextEditingController companyContraller = TextEditingController();
  final GlobalKey<FormState> textFeildkey = GlobalKey<FormState>();

//
//for company
//

  List companySearchList = [];
  List companySearchResults = [];
  getNameOfCompany() async {
    var companiesData = await FirebaseFirestore.instance
        .collection('Companys')
        .orderBy("company_Name")
        .get();

    setState(() {
      companySearchList = companiesData.docs;
    });
  }

  searchResultListCompanys() {
    var showresultsCompanys = [];
    if (companyContraller.text != "") {
      for (var companySnapshot in companySearchList) {
        var name = companySnapshot['company_Name'].toString().toLowerCase();
        if (name.contains(companyContraller.text.toLowerCase())) {
          showresultsCompanys.add(companySnapshot);
        }
      }
    } else {
      showresultsCompanys = List.from(companySearchList);
    }
    setState(() {
      companySearchResults = showresultsCompanys;
    });
  }

//
//  for userName
//
  List allNameResults = [];
  List nameResultList = [];

  getNameOfUserStream() async {
    var usersData = await FirebaseFirestore.instance
        .collection("users")
        .where("role", isNotEqualTo: "User")
        .get();

    setState(() {
      allNameResults = usersData.docs;
    });
  }

  searchResultList() {
    var showresults = [];
    if (searchContraller.text.isNotEmpty) {
      for (var userSnapshot in allNameResults) {
        var name = userSnapshot["first_Name"].toString().toLowerCase();
        if (name.contains(searchContraller.text.toLowerCase())) {
          showresults.add(userSnapshot);
        }
      }
    } else {
      showresults = List.from(allNameResults);
    }
    setState(() {
      nameResultList = showresults;
    });
  }

  @override
  void initState() {
    getNameOfUserStream();

    searchContraller.addListener(onSearchChanged);

    getNameOfCompany();
    companyContraller.addListener(onCompanySearchChanged);

    super.initState();
  }

  void onCompanySearchChanged() {}
  void onSearchChanged() {}

  @override
  void dispose() {
    searchContraller.removeListener(onSearchChanged);
    searchContraller.dispose();
    companyContraller.removeListener(onSearchChanged);
    companyContraller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getNameOfUserStream();
    getNameOfCompany();
    super.didChangeDependencies();
  }

  bool isItemSearchSelected = true;
  bool isItemSearchnameSelected = true;
  int number = 0;
  List<String> filterCompanyDropDown = ['Auditor', 'Accountant'];
  String? selectItem;

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.of(context).pushNamed(RouterName.searchScreenForAdmin);
        },
        title: Text(
          S.of(context).Assignment,
        ),
        leading: const BackButton(color: Colors.white),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          margin: EdgeInsets.only(top: 15.h),
          child: SingleChildScrollView(
            child: Form(
              key: textFeildkey,
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                    decoration: BoxDecoration(
                        color: ColorManger.white,
                        borderRadius: BorderRadius.circular(15.h),
                        border: Border.all(color: ColorManger.darkGray)),
                    child: DropdownButton<String>(
                      hint: Text(
                        S.of(context).SelectStaffType,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color:
                                    ColorManger.backGroundColorToSplashScreen),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      value: selectItem,
                      items: filterCompanyDropDown
                          .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              )))
                          .toList(),
                      onChanged: (item) => setState(() {
                        selectItem = item!;
                      }),
                    ),
                  ),

                  //
                  //
                  //
                  SizedBox(
                    height: 10.h,
                  ),

                  CustomTextFormField(
                    validator: (value) {},
                    controller: searchContraller,
                    hintText: S.of(context).hintAssignmentStaffName,
                    prefixIcon: const Icon(Icons.email),
                    labelText: S.of(context).name,
                    onChanged: (value) {
                      setState(() {
                        searchResultList();
                        isItemSearchnameSelected = true;
                      });
                    },
                  ),
                  Visibility(
                    visible: isItemSearchnameSelected,
                    child: SizedBox(
                      height: searchContraller.text.isEmpty
                          ? 0
                          : MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        // Use Column or Row as a parent
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: nameResultList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    color: Colors.white,
                                  ),
                                  margin: const EdgeInsets.all(8),
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        searchContraller.text =
                                            "${nameResultList[index]["fullName"]} ";
                                        isItemSearchnameSelected = false;
                                      });
                                    },
                                    child: ListTile(
                                        title: Text(
                                            "${nameResultList[index]["first_Name"] + nameResultList[index]["last_Name"]}"),
                                        subtitle: Text(
                                            nameResultList[index]["email"])),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomTextFormField(
                    controller: companyContraller,
                    hintText: S.of(context).CompanyName,
                    prefixIcon: const Icon(Icons.add_business),
                    labelText: S.of(context).SearchForCompany,
                    onChanged: (value) {
                      setState(() {
                        searchResultListCompanys();
                        isItemSearchSelected = true;
                      });
                    },
                  ),
                  Visibility(
                    visible: isItemSearchSelected,
                    child: SizedBox(
                      height: companyContraller.text.isEmpty
                          ? 0
                          : MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        // Use Column or Row as a parent
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: companySearchResults.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      color: Colors.white,
                                    ),
                                    margin: EdgeInsets.all(8),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isItemSearchSelected = false;
                                          companyContraller.text =
                                              "${companySearchResults[index]['company_Name']}";
                                        });
                                      },
                                      child: ListTile(
                                        title: Text(
                                          "${companySearchResults[index]['company_Name']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                        ),
                                        trailing: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            companySearchResults[index]["logo"],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                    nameOfButton: S.of(context).selectItem,
                    onTap: () async {
                      setState(() {
                        isLoading = true; // Start loading
                      });
                      try {
                        var addInformationStaffToCompany =
                            FirebaseFirestore.instance.collection('Companys');

                        var companySnapshot = await addInformationStaffToCompany
                            .where('company_Name',
                                isEqualTo: companyContraller.text.trim())
                            .get();

                        var addUserInformation =
                            FirebaseFirestore.instance.collection('users');

                        var addUserInformationdata = await addUserInformation
                            .where('fullName',
                                isEqualTo: searchContraller.text.trim())
                            .get();

                        if (companySnapshot.docs.isNotEmpty) {
                          var companyDocs = companySnapshot.docs[0];
                          var companyID = companyDocs['companyId'];
                          var companyName = companyDocs["company_Name"];
                          var staffInformation = addUserInformationdata.docs[0];
                          var sttafuserID = staffInformation["userID"];
                          var sttafuserEmail = staffInformation["email"];
                          print(sttafuserID);
                          await FirebaseFirestore.instance
                              .collection('Staff')
                              .doc()
                              .set(
                            {
                              'CompanyId': companyID,
                              'companyName': companyName,
                              "StaffEmail": sttafuserEmail,
                              'userid': sttafuserID,
                              'StaffRole': selectItem,
                              'StaffName': searchContraller.text,
                            },
                            SetOptions(merge: true),
                          ).then((value) {
                            FirebaseFirestore.instance
                                .collection('Notification')
                                .add({
                              'notificationMassage':
                                  "${S.of(context).YouAdded} $companyName ${S.of(context).tobe} $selectItem ${S.of(context).toit} ",
                              'role': selectItem,
                              'MassgeSendBy': 'ManagerMassage',
                              'NotificationCompanyID': companyID,
                              'NotificationUserID': sttafuserID
                            });
                          });

                          print(
                              'تم تحديث المعلومات بنجاح للمستخدم ذو البريد الإلكتروني: $sttafuserID');
                        } else {}
                      } on Exception catch (e) {
                        print(
                            'لم يتم العثور على مستخدم ذو الـ "first name" المحدد. ${e.toString()}');
                        // TODO
                      } finally {
                        setState(() {
                          isLoading = false; // Stop loading
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}  


  // var addUserInformation =
                    //     FirebaseFirestore.instance.collection('users');

                    // var addUserInformationdata = await addUserInformation
                    //     .where('role', isNotEqualTo: "User")
                    //     .get();
                    // var staffInformation = addUserInformationdata.docs[0];
                    // var sttafuserID = staffInformation["userID"];
//                     print(await FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(FirebaseAuth.instance.currentUser!.uid)
//                         .collection("Companys")
//                         .get()
//                         .then((QuerySnapshot<Map<String, dynamic>> value) {
//                       value.docs.forEach((element) {
//                         var data = element.data();
// //
//                         // Assuming "1" is the key you're interested in
//                         var staffData = data[sttafuserID];

//                         if (staffData != null) {
//                           var staffEmail = staffData['StaffEmail'];
//                           var staffRole = staffData['StaffRole'];
//                           var staffName = staffData['StaffName'];

//                           print("StaffEmail: $staffEmail");
//                           print("StaffRole: $staffRole");
//                           print("StaffName: $staffName");
//                         } else {}
//                       });
//                     }));
 // Map<String, dynamic> dataToUpdate = {
                        //   "$sttafuserID": {
                            
                        //   },
                        // }; // var addUserInformation =
                    //     FirebaseFirestore.instance.collection('users');

                    // var addUserInformationdata = await addUserInformation
                    //     .where('role', isNotEqualTo: "User")
                    //     .get();
                    // var staffInformation = addUserInformationdata.docs[0];
                    // var staffUserID = staffInformation["userID"];

                    // bool isEqual = false;

                    // var results = await FirebaseFirestore.instance
                    //     .collection('users')
                    //     .doc(FirebaseAuth.instance.currentUser!.uid)
                    //     .collection("Companys")
                    //     .get()
                    //     .then(
                    //         (QuerySnapshot<Map<String, dynamic>> value) async {
                    //   for (var element in value.docs) {
                    //     var data = element.data();
                    //     var staffData = data[staffUserID];

                    //     if (staffData != null) {
                    //       var staffEmail = staffData['StaffEmail'];

                    //       // Now, let's compare 'staffEmail' with data from the 'users' table
                    //       // var table1Snapshot = await FirebaseFirestore.instance
                    //       //     .collection("users")
                    //       //     .where("userID", isEqualTo: staffEmail)
                    //       //     .get();

                    //       if (staffEmail ==
                    //           FirebaseAuth.instance.currentUser!.uid) {
                    //         print(isEqual = false);

                    //         print(FirebaseFirestore.instance
                    //             .collection("users")
                    //             .doc(FirebaseAuth.instance.currentUser!.uid));
                    //         print(staffEmail);
                    //         break; // Exit the loop if a match is found
                    //       } else {
                    //         print(isEqual = true);
                    //       }
                    //     }
                    //   }
                    // });



//  var selectStaffType = FirebaseFirestore.instance
//       .collection("users")
//       .where("role", isNotEqualTo: "User")
//       .snapshots();

 // String? selectedStaffType;
  // void fetchStaffTypes() async {
  //   var staffTypesSnapshot = await FirebaseFirestore.instance
  //       .collection("users")
  //       .where("role", isNotEqualTo: "User")
  //       .get();

  //   setState(() {
  //     staffTypesList = staffTypesSnapshot.docs.map((doc) => doc.id).toList();
  //   });
  // }


  //
              //
              // StreamBuilder(
              //   stream: selectStaffType,
              //   builder: (context, snapshot) {
              //     Set<String> uniqueRoles = Set();
              //     List<DropdownMenuItem<String>> staffTypeList = [];
              //     if (snapshot.hasData) {
              //       final staffType = snapshot.data?.docs.reversed.toList();
              //       for (var staff in staffType!) {
              //         String role = staff['role'];

              //         if (!uniqueRoles.contains(role)) {
              //           uniqueRoles.add(role);
              //           staffTypeList.add(DropdownMenuItem(
              //             value: staff.id,
              //             child: Text(role),
              //           ));
              //         }
              //       }
              //     }

              //     return Container(
              //       padding:
              //           EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              //       decoration: BoxDecoration(
              //           color: ColorManger.white,
              //           borderRadius: BorderRadius.circular(15.h),
              //           border: Border.all(color: ColorManger.darkGray)),
              //       child: DropdownButton<String>(
              //         hint: Text(
              //           "Select Type",
              //           style: Theme.of(context)
              //               .textTheme
              //               .displayMedium!
              //               .copyWith(
              //                   color:
              //                       ColorManger.backGroundColorToSplashScreen),
              //         ),
              //         borderRadius: BorderRadius.circular(10),
              //         isExpanded: true,
              //         value: selectItem,
              //         items: staffTypeList,
              //         onChanged: (item) => setState(() {
              //           selectItem = item!;
              //           print(selectItem);
              //         }),
              //       ),
              //     );
              //   },
              // ),