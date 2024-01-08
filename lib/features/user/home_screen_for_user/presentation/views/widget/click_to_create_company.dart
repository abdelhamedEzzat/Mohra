import 'package:flutter/material.dart';
import 'package:mohra_project/core/helpers/custom_button_with_icon_or_image.dart';
import 'package:mohra_project/core/routes/name_router.dart';

class ClickToCreateCampany extends StatelessWidget {
  const ClickToCreateCampany({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.100,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        width: MediaQuery.of(context).size.width * 0.90,
        height: MediaQuery.of(context).size.height * 0.20,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "Create Company To Start",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          CustomBottonWithIconOrImage(
            onTap: () {
              print("pla pla pla");

              Navigator.of(context).pushNamed(RouterName.createCompany);
            },
            //  color: ColorManger.backGroundColorToSplashScreen,
            nameOfButton: "Click to Create your Company",
            width: MediaQuery.of(context).size.width * 0.75,
          )
        ]),
      ),
    );
  }
}
