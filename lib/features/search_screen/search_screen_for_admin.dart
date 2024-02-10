import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/core/routes/name_router.dart';

class SearchScreenForAdmin extends StatefulWidget {
  const SearchScreenForAdmin({super.key});

  @override
  State<SearchScreenForAdmin> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreenForAdmin> {
  String? selectTypeItem;
  final TextEditingController companyContraller = TextEditingController();
  List companySearchList = [];
  List companySearchResults = [];
  String selectedCompanyId = ""; // Store the selected company ID
  List<String> additionalInfoItems = []; // Store additional information
  List<Map<String, dynamic>> companyDocuments = [];
  bool isLogo = false;
  bool istype = false;

  bool ifsearch = true;

  // Function to get the name of companies
  Future<void> getNameOfCompany() async {
    var companiesData = await FirebaseFirestore.instance
        .collection('Companys')
        .orderBy("company_Name")
        .get();

    setState(() {
      companySearchList = companiesData.docs;
    });
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
        fetchAdditionalInfo();
        fetchCompanyDocuments();
      });
    }
  }

  // Function to fetch additional information based on the selected company
  void fetchAdditionalInfo() async {
    // Check if a company is selected
    if (selectedCompanyId.isNotEmpty) {
      var snapshot = await FirebaseFirestore.instance
          .collection('Companys')
          .where('companyId', isEqualTo: selectedCompanyId)
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
        title: const Text('Search'),
        leading: const BackButton(
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(RouterName.searchScreenForAdmin);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                controller: companyContraller,
                hintText: "Company Name",
                prefixIcon: const Icon(Icons.add_business),
                labelText: "Search For Company",
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
                    searchResults(),
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
                    "Select Type Of Document",
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
                    print("Dropdown onChanged: $item");
                    setState(() {
                      selectTypeItem = item as String?;
                      if (selectTypeItem != null) {
                        print(
                            "Fetching documents for Company ID: $selectedCompanyId, Type: $selectTypeItem");
                        fetchCompanyDocuments();
                      }
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
            onTap: () {
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
              // print({selectedCompanyId});
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
              // Handle any action needed when tapping on an item
              // This block is optional, you can remove it if not needed
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
