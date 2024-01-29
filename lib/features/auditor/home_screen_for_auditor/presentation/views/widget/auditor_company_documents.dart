import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/document_and_number_after_upload.dart';

class AuditorCompanyDocuments extends StatelessWidget {
  const AuditorCompanyDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    var companyId = ModalRoute.of(context)?.settings.arguments;
    final Stream<QuerySnapshot> documentCompany = FirebaseFirestore.instance
        .collection('Document')
        .where("companydocID", isEqualTo: companyId)
        .snapshots();

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("Documents"),
        leading: BackButton(
          color: ColorManger.white,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RouterName.addDocumetType,
                      arguments: companyId);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Icon(
                          Icons.add_box_rounded,
                          size: 55.h,
                        )),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Add Document Type',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        )
                      ]),
                ),
              ),
              Divider(color: ColorManger.backGroundColorToSplashScreen),
              SizedBox(
                height: 10.h,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: documentCompany,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.90,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final doc = snapshot.data!.docs[index];
                            return DocumentForAuditor(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  RouterName.auditorDocumentDetails,
                                  arguments: {
                                    'urlImage': doc["urlImage"],
                                    'comment': doc["comment"],
                                    'companydocID': doc['companydocID'],
                                    'DocID': doc['DocID']
                                  },
                                );
                              },
                              status: snapshot.data!.docs[index]['comment'],
                              typeOfDocument: snapshot.data!.docs[index]
                                  ['selectItem'],
                              docImage: snapshot.data!.docs[index]['urlImage'],
                              color: ColorManger.darkGray,
                            );
                          },
                        ),
                      );
                    }
                    return Container(
                      color: Colors.black,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
