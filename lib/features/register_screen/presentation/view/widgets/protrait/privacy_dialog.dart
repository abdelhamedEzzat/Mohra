import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';

class PrivacyDaialog extends StatelessWidget {
  PrivacyDaialog({super.key, this.radius = 8, required this.mdFileName})
      : assert(
            mdFileName.contains(".md"), 'the File Must Contain .md extention');
  final double radius;
  final String mdFileName;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 150)).then((value) {
                return rootBundle.loadString('assets/$mdFileName');
              }),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Markdown(data: snapshot.data);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.all(0),
            color: ColorManger.backGroundColorToSplashScreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius)),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(radius),
                      bottomRight: Radius.circular(radius))),
              alignment: Alignment.center,
              height: 50.h,
              width: double.infinity,
              child: Text(
                "Close",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
