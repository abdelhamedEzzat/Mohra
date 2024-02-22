import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:photo_view/photo_view.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/generated/l10n.dart';

class SearchScreenForAccountant extends StatefulWidget {
  const SearchScreenForAccountant({
    Key? key,
    // this.onLongPress,
  }) : super(key: key);
  // final void Function()? onLongPress;
  @override
  State<SearchScreenForAccountant> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreenForAccountant> {
  String? selectTypeItem;
  final TextEditingController companyContraller = TextEditingController();
  List companySearchList = [];
  List companySearchResults = [];
  String selectedCompanyId = ""; // Store the selected company ID
  List<String> additionalInfoItems = []; // Store additional information
  List<Map<String, dynamic>> companyDocuments = [];
  bool isLogo = false;
  bool istype = false;
  // void Function()? onLongPress;
  bool ifsearch = true;

  // Function to get the name of companies
  Future<void> getNameOfCompany() async {
    // Step 1: Get the company IDs from the staff collection
    var staffData = await FirebaseFirestore.instance.collection('Staff').get();

    // Extracting company IDs from staff data
    List<String> companyIDs = [];
    for (var staffSnapshot in staffData.docs) {
      String companyID = staffSnapshot['CompanyId'];
      companyIDs.add(companyID);
    }

    // Step 2: Query companies collection for each company ID
    for (var companyID in companyIDs) {
      var companyQuery = await FirebaseFirestore.instance
          .collection('Companys')
          .where('companyId', isEqualTo: companyID)
          .get();

      setState(() {
        companySearchList = companyQuery.docs;
      });
    }
  }

// Function to search and update the results
  void searchResultListCompanys() {
    var showresultsCompanys = [];
    if (companyContraller.text.isNotEmpty) {
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

  // Function to handle the selection of a company
  void onCompanySelected(String companyId) {
    if (mounted) {
      setState(() {
        selectedCompanyId = companyId;
        fetchCompanyData();
      });
    }
  }

  void fetchCompanyData() async {
    await fetchCompanyDocuments();
    fetchAdditionalInfo();
  }

  void fetchAdditionalInfo() async {
    if (selectedCompanyId.isNotEmpty) {
      var snapshot = await FirebaseFirestore.instance
          .collection('Staff')
          .where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('CompanyId', isEqualTo: selectedCompanyId)
          .get();

      // Get the additional information
      List<String> infoList = [];

      for (var doc in snapshot.docs) {
        var additionalInfo = doc['additionalInformation'];

        if (additionalInfo != null) {
          if (additionalInfo is String) {
            infoList.add(additionalInfo);
          } else if (additionalInfo is List) {
            infoList.addAll(additionalInfo.map((item) => item.toString()));
          }
        }
      }

      print(
          "Additional Info List: $infoList"); // Add this line to check infoList

      setState(() {
        additionalInfoItems = infoList;
      });
    }
  }

  Future<void> fetchCompanyDocuments() async {
    print(
        "Fetching documents for Company ID: $selectedCompanyId, Type: $selectTypeItem");
    if (selectedCompanyId.isNotEmpty && selectTypeItem != null) {
      var documentsSnapshot = await FirebaseFirestore.instance
          .collection("Document")
          .where('companydocID', isEqualTo: selectedCompanyId)
          .where('selectTypeItem', isEqualTo: selectTypeItem)
          .get();
      setState(() {
        companyDocuments =
            documentsSnapshot.docs.map((doc) => doc.data()).toList();
      });
      print("Company Documents: $companyDocuments");
      print("selecttype $selectTypeItem");
      print("selecttype $selectedCompanyId");
    }
  }

  @override
  void initState() {
    getNameOfCompany();
    companyContraller.addListener(onSearchChanged);

    super.initState();
  }

  void onSearchChanged() {
    // Implement any logic when the search field changes
  }

  @override
  void dispose() {
    companyContraller.removeListener(onSearchChanged);
    companyContraller.dispose();
    //fetchCompanyDocuments();
    //myStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getNameOfCompany();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(S.of(context).Search),
        leading: const BackButton(
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                  });
                },
              ),
              SizedBox(
                height: companyContraller.text.isEmpty
                    ? 0
                    : MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    searchResults(
                        // widget.onLongPress
                        ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: ColorManger.white,
                  borderRadius: BorderRadius.circular(15.w),
                  border: Border.all(color: ColorManger.darkGray),
                ),
                child: DropdownButton<String>(
                  hint: Text(
                    S.of(context).SelectTypeOfDocument,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: ColorManger.backGroundColorToSplashScreen),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  isExpanded: true,
                  value: selectTypeItem,
                  items: istype
                      ? [
                          const DropdownMenuItem(
                              value: null, child: CircularProgressIndicator())
                        ]
                      : additionalInfoItems.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          );
                        }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selectTypeItem = item as String?;
                      if (selectTypeItem != null) {
                        print(
                            "Fetching documents for Company ID: $selectedCompanyId, Type: $selectTypeItem");
                      }
                      fetchCompanyDocuments();
                      // Move this inside setState
                    });
                  },
                ),
              ),
              SizedBox(
                height: companyContraller.text.isEmpty
                    ? 0
                    : MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    searchResultsaftersearchCompanyandType(),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded searchResults() {
    return Expanded(
      child: ListView.builder(
        itemCount: companySearchResults.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              // Handle the selection of a company
              onCompanySelected(companySearchResults[index].id);
              setState(() {
                selectedCompanyId = companySearchResults[index]['companyId'];

                companyContraller.text =
                    "${companySearchResults[index]['company_Name']}";
              });
              fetchAdditionalInfo();
              istype = false;
              // print({companySearchResults[index]['companyId']});
              print("sadasdasdasdasdas $selectedCompanyId");
            },
            child: Column(
              children: [
                GestureDetector(
                  onLongPress: () {
                    Navigator.of(context).pushNamed(
                        RouterName.accuntantCompanyDocuments,
                        arguments: companySearchResults[index]['companyId']);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.all(8),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: ListTile(
                      title: Text(
                        "${companySearchResults[index]['company_Name']}",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      trailing: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: companySearchResults.isEmpty
                            ? const CircularProgressIndicator()
                            : Image.network(
                                companySearchResults[index]["logo"],
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const CircularProgressIndicator(
                                      color: Colors.black,
                                    );
                                  }
                                },
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  return const CircularProgressIndicator();
                                },
                              ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    color: Colors.black,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded searchResultsaftersearchCompanyandType() {
    return Expanded(
      child: ListView.builder(
        itemCount: companyDocuments.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              var imageCompany = companyDocuments[index]['urlImage'].toString();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('Image Preview'),
                    ),
                    body: Center(
                      child: PhotoView(
                        imageProvider: NetworkImage(imageCompany),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.contained * 2.5,
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Container(
              height: 200.h,
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: companySearchResults.isEmpty
                    ? const CircularProgressIndicator()
                    : Image.network(
                        companyDocuments[index]["urlImage"],
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const CircularProgressIndicator(
                              color: Colors.black,
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return const CircularProgressIndicator();
                        },
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
