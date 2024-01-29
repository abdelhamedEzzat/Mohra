import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';

class AddDocumentType extends StatefulWidget {
  const AddDocumentType({super.key});

  @override
  State<AddDocumentType> createState() => _AddTypeState();
}

class _AddTypeState extends State<AddDocumentType> {
  List<String> informationList = [];

  TextEditingController textFieldController = TextEditingController();

  String selectedInformation = "";

  void addInformation() async {
    var companyId = ModalRoute.of(context)?.settings.arguments;
    String enteredText = textFieldController.text.trim();

    if (enteredText.isNotEmpty) {
      QuerySnapshot<Map<String, dynamic>> companyDocRef =
          await FirebaseFirestore.instance
              .collection("Companys")
              .where('companyId', isEqualTo: companyId)
              .get();

      if (companyDocRef.docs.isNotEmpty) {
        DocumentReference<Map<String, dynamic>> documentReference =
            companyDocRef.docs[0].reference;

        await documentReference.update({
          'additionalInformation': FieldValue.arrayUnion([enteredText]),
        });
      } else {
        print("Document not found");
      }
      setState(() {
        informationList.add(enteredText);
        selectedInformation = enteredText;
      });

      textFieldController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var companyId = ModalRoute.of(context)?.settings.arguments;
    final Stream<QuerySnapshot> companyCollection =
        FirebaseFirestore.instance.collection("Companys").snapshots();
    return Scaffold(
      appBar: const CustomAppBar(
          title: Text(
            "Add Document Type",
          ),
          leading: BackButton(
            color: Colors.white,
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text field for user input
            CustomTextFormField(
              hintText: "Enter Type",
              prefixIcon: Icon(Icons.type_specimen),
              controller: textFieldController,
            ),
            const SizedBox(height: 16.0),
            // Button to add information
            CustomButton(
                nameOfButton: 'add Type of Document Company',
                onTap: () {
                  print(companyId);
                  setState(() {
                    addInformation();
                  });
                }),

            const SizedBox(height: 16.0),
            // Dteropdown button to display information
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: companyCollection,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print(informationList);
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 8.h,
                            ),
                            margin: EdgeInsets.all(8.0.h),
                            child: Text(
                              snapshot.data.docs[index]['additionalInformation']
                                  .toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}",
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
