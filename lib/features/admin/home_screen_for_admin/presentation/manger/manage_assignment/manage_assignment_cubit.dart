// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// part 'manage_assignment_state.dart';

// class MannageAssignmentCubit extends Cubit<MannageAssignmentState> {
//   MannageAssignmentCubit() : super(MannageAssignmentInitial());

//   List companySearchList = [];
//   List companySearchResults = [];
//   var showresultsCompanys = [];

//   getNameOfCompany() async {
//     try {
//       var companiesData = await FirebaseFirestore.instance
//           .collection("users")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection('Companys')
//           .orderBy("company_Name")
//           .get();

//       companySearchList = companiesData.docs;
//     } catch (e) {
//       emit(MannageAssignmentCompanyFaild(
//           error: "faild to get Name Company  ${e.toString()}"));
//     }
//   }

// //   searchResultListCompanys() {
// //     if (searchContraller.text != "") {
// //       for (var companySnapshot in companySearchList) {
// //         if (companySnapshot.data()!.containsKey('company_Name')) {
// //           var name = companySnapshot['company_Name'].toString();
// //           if (name.contains(searchContraller.text.toLowerCase())) {
// //             showresultsCompanys.add(companySnapshot);
// //           }
// //         }
// //       }
// //     } else {
// //       showresultsCompanys = List.from(companySearchList);
// //     }

// //     companySearchResults = showresultsCompanys;
// //   }
// // }
// }
