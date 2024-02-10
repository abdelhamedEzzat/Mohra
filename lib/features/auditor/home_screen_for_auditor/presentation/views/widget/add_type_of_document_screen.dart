import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/search_screen/search_screen_for_user.dart';

class AddDocumentType extends StatefulWidget {
  @override
  _AddDocumentTypeState createState() => _AddDocumentTypeState();
}

class _AddDocumentTypeState extends State<AddDocumentType> {
  List<String> messages = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var companyId = ModalRoute.of(context)?.settings.arguments;
    void addToFirestoreAndList(String text) {
      print("=================${'jNl1XYzjgad5a6gTstev'}");

      FirebaseFirestore.instance
          .collection('Companys')
          .where('companyId', isEqualTo: companyId)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          var doc = querySnapshot.docs.first;
          print("===================${doc['companyId']}");
          // استخراج قائمة additionalInformation من الوثيقة أو استخدام قائمة فارغة إذا لم تكن موجودة
          var additionalInformationList =
              doc['additionalInformation']?.cast<String>() ?? <String>[];

          // التحقق مما إذا كان النص موجودًا بالفعل في القائمة
          if (!additionalInformationList.contains(text)) {
            // إضافة النص إلى قائمة additionalInformation في الوثيقة
            doc.reference.update({
              'additionalInformation': FieldValue.arrayUnion([text]),
            }).then((value) {
              setState(() {
                // تحديث قائمة الرسائل في الواجهة
                messages = List.from(additionalInformationList)..add(text);
                _textEditingController.clear(); // مسح حقل النص
              });
            }).catchError((error) {
              print("خطأ في تحديث البيانات: $error");
            });
          } else {
            print("النص موجود بالفعل في القائمة");
          }
        } else {
          print("لا توجد وثائق تطابق شروط البحث");
        }
      }).catchError((error) {
        print("خطأ في استرجاع البيانات: $error");
      });
    }

    return Scaffold(
      appBar: CustomAppBarForUsers(
        leading: BackButton(color: Colors.white),
        title: Text('Add Document Type'),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Companys')
                  .where('companyId', isEqualTo: companyId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (!snapshot.hasData) {
                  return Text("Company document not found");
                }

                return Expanded(
                    child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // Retrieve the 'additionalInformation' field as a List
                    List<dynamic> itemList =
                        snapshot.data!.docs[index]['additionalInformation'];

                    // Create a Column with a Container for each item in the list
                    return Column(
                      children: itemList.map((item) {
                        return Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(15.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            item.toString(),
                            style: Theme.of(context).textTheme.displayMedium!,
                          ),
                        );
                      }).toList(),
                    );
                  },
                ));
              }),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter Type',
                labelStyle: Theme.of(context)
                    .textTheme
                    .displayMedium, // Adjust the style here
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // You can customize other properties as needed
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_textEditingController.text.isNotEmpty) {
                addToFirestoreAndList(
                  _textEditingController.text,
                );
              }
            },
            child: Container(
                decoration: BoxDecoration(
                  color: ColorManger.backGroundColorToSplashScreen,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.only(bottom: 20.h),
                padding: EdgeInsets.all(20.h),
                child: Text(
                  'Add Type of Document Company',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mohra_project/core/helpers/custom_app_bar.dart';
// import 'package:mohra_project/core/helpers/custom_button.dart';
// import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
// import 'package:mohra_project/features/search_screen/search_screen_for_user.dart';

// class AddDocumentType extends StatefulWidget {
//   const AddDocumentType({super.key});

//   @override
//   State<AddDocumentType> createState() => _AddTypeState();
// }

// class _AddTypeState extends State<AddDocumentType> {
//   List<String> informationList = [];

//   TextEditingController textFieldController = TextEditingController();

//   String selectedInformation = "";

//   void addInformation() async {
//     var companyId = ModalRoute.of(context)?.settings.arguments;
//     String enteredText = textFieldController.text.trim();

//     if (enteredText.isNotEmpty) {
//       QuerySnapshot<Map<String, dynamic>> companyDocRef =
//           await FirebaseFirestore.instance
//               .collection("Companys")
//               .where('companyId', isEqualTo: companyId)
//               .get();

//       for (QueryDocumentSnapshot<Map<String, dynamic>> document
//           in companyDocRef.docs) {
//         if (document['companyId'] == companyId) {
//           DocumentReference<Map<String, dynamic>> documentReference =
//               document.reference;

//           try {
//             await documentReference.update({
//               'additionalInformation': FieldValue.arrayUnion([enteredText]),
//             });
//             print("Document updated successfully");
//           } catch (e) {
//             print("Error updating document: $e");
//           }

//           setState(() {
//             informationList.add(enteredText);
//             selectedInformation = enteredText;
//           });

//           textFieldController.clear();
//           return; // Exit the loop once the update is done for the matching companyId
//         }
//       }

//       // If no matching companyId is found
//       print("Document not found for companyId: $companyId");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var companyId = ModalRoute.of(context)?.settings.arguments;
//     final Stream<QuerySnapshot> companyCollection =
//         FirebaseFirestore.instance.collection("Companys").snapshots();
//     return Scaffold(
//       appBar: const CustomAppBarForUsers(
//           title: Text(
//             "Add Document Type",
//           ),
//           leading: BackButton(
//             color: Colors.white,
//           )),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Text field for user input
//             CustomTextFormField(
//               hintText: "Enter Type",
//               prefixIcon: Icon(Icons.type_specimen),
//               controller: textFieldController,
//             ),
//             const SizedBox(height: 16.0),
//             // Button to add information
//             CustomButton(
//                 nameOfButton: 'add Type of Document Company',
//                 onTap: () {
//                   print(companyId);
//                   setState(() {
//                     addInformation();
//                   });
//                 }),

//             const SizedBox(height: 16.0),
//             // Dteropdown button to display information
//             Expanded(
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: companyCollection,
//                   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     print(informationList);
//                     if (snapshot.hasData) {
                      // return ListView.builder(
                      //   itemCount: snapshot.data.docs.length,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return Container(
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey,
                      //         borderRadius: BorderRadius.circular(25),
                      //       ),
                      //       padding: EdgeInsets.symmetric(
                      //         horizontal: 15.w,
                      //         vertical: 8.h,
                      //       ),
                      //       margin: EdgeInsets.all(8.0.h),
                      //       child: Text(
                      //         snapshot.data.docs[index]['additionalInformation']
                      //             .toString(),
                      //         style: Theme.of(context).textTheme.bodySmall,
                      //       ),
                      //     );
                      //   },
                      // );
//                     } else if (snapshot.hasError) {
//                       return Center(
//                         child: Text(
//                           "Error: ${snapshot.error}",
//                         ),
//                       );
//                     } else {
//                       return Center(
//                         child: CircularProgressIndicator(
//                           color: Colors.black,
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
