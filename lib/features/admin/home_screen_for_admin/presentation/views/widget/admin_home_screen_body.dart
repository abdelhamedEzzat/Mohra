import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/icon_and_text_company.dart';

class AdminHomeScreenBody extends StatelessWidget {
  const AdminHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TabBar(
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                labelColor: ColorManger.backGroundColorToSplashScreen,
                indicatorColor: ColorManger.black,
                tabs: [
                  Tab(
                    icon: const Icon(Icons.pest_control_outlined),
                    child: Text("Controller", style: TextStyle(fontSize: 12.h)),
                  ),
                  Tab(
                    icon: const Icon(Icons.add_business),
                    child: Text("Companys", style: TextStyle(fontSize: 12.h)),
                  ),
                  Tab(
                    icon: const Icon(Icons.person),
                    child: Text("Users", style: TextStyle(fontSize: 12.h)),
                  ),
                  Tab(
                    icon: const Icon(Icons.person_2_sharp),
                    child: Text("Staff", style: TextStyle(fontSize: 12.h)),
                  ),
                ]),
          ],
        ),
        const Expanded(
          child: TabBarView(children: [
            ContrallerTabBarScreen(),
            CompanysTabBarScreen(),
            UsersTabBarScreens(),
            StaffTabBARScreens(),
          ]),
        )
      ],
    );
  }
}

class StaffTabBARScreens extends StatelessWidget {
  const StaffTabBARScreens({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      margin: EdgeInsets.only(top: 31.h),
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.h),
                    topRight: Radius.circular(10.h))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,
            //  padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.h),
                            topRight: Radius.circular(10.h))),
                    child: Center(
                      child: Text(
                        "Accountant",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.h),
                    bottomRight: Radius.circular(10.h))),
            // margin: EdgeInsets.only(top: 15.h),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.10,
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text("email : "),
                  ],
                ),
                Row(
                  children: [
                    Text("UserName : "),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class UsersTabBarScreens extends StatelessWidget {
  const UsersTabBarScreens({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      margin: EdgeInsets.only(top: 15.h),
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.h),
                    topRight: Radius.circular(10.h))),
            margin: EdgeInsets.only(top: 15.h),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.10,
            padding: EdgeInsets.all(8),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text("email : "),
                  ],
                ),
                Row(
                  children: [
                    Text("UserName : "),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.h),
                    bottomRight: Radius.circular(10.h))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text("Accepted"),
                    ),
                  ),
                )),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.red,
                    child: const Center(
                      child: Text("Rejected"),
                    ),
                  ),
                ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class CompanysTabBarScreen extends StatefulWidget {
  const CompanysTabBarScreen({
    super.key,
  });

  @override
  State<CompanysTabBarScreen> createState() => _CompanysTabBarScreenState();
}

class _CompanysTabBarScreenState extends State<CompanysTabBarScreen> {
  List<String> filterCompanyDropDown = [
    "Accepted",
    "Rojected",
    "Waiting",
  ];

  String? selectItem;
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: ColorManger.darkGray.withOpacity(0.5),
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.only(top: 15.h),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.10,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconsAndTextToCompany(
                  text: "Companies",
                  color: Colors.black,
                ),
                IconsAndTextToDoc(
                  color: Colors.black,
                  text: "Documents",
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
            decoration: BoxDecoration(
                color: ColorManger.white,
                borderRadius: BorderRadius.circular(15.h),
                border: Border.all(color: ColorManger.darkGray)),
            child: DropdownButton<String>(
              hint: Text(
                "Choose Filter",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: ColorManger.backGroundColorToSplashScreen),
              ),
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              value: selectItem,
              items: filterCompanyDropDown
                  .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.displayMedium,
                      )))
                  .toList(),
              onChanged: (item) => setState(() {
                selectItem = item!;
              }),
            ),
          ),
          const AllCampanyWithStatus(),
        ]));
  }
}

class AllCampanyWithStatus extends StatelessWidget {
  const AllCampanyWithStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: CompanyButton(
                  colorOfStatus: ColorManger.acceptedCompanyStatus,
                  statusText: "Accepted",
                  companyName: "companyName",
                  logoCompany: ImageManger.mohraLogo,
                  withStatus: true,
                  onTap: () {}),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: CompanyButton(
                  colorOfStatus: ColorManger.rejectedCompanyStatus,
                  statusText: "Rejcted",
                  companyName: "companyName",
                  logoCompany: ImageManger.mohraLogo,
                  withStatus: true,
                  onTap: () {}),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: CompanyButton(
                  colorOfStatus: ColorManger.darkGray,
                  statusText: "Wating to Accepted",
                  companyName: "companyName",
                  logoCompany: ImageManger.mohraLogo,
                  withStatus: true,
                  onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}

///
class ContrallerTabBarScreen extends StatelessWidget {
  const ContrallerTabBarScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      margin: EdgeInsets.only(top: 15.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ContrallBottonInAdminHomeScreen(
              colorToButtonContainer: ColorManger.darkGray.withOpacity(0.9),
              buttonTitle: "Add New Accountatnt",
              icon1: Icons.person,
              icon2: Icons.money,
              onTap: () {
                Navigator.of(context).pushNamed(RouterName.addNewAccountant);
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            ContrallBottonInAdminHomeScreen(
              colorToButtonContainer: ColorManger.bottonColor.withOpacity(0.6),
              buttonTitle: "Add New Auditor",
              icon1: Icons.person,
              icon2: Icons.search,
              onTap: () {
                Navigator.of(context).pushNamed(RouterName.addNewAuditor);
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            ContrallBottonInAdminHomeScreen(
              colorToButtonContainer:
                  ColorManger.rejectedCompanyStatus.withOpacity(0.7),
              buttonTitle: "Mange Assignment",
              icon1: Icons.person,
              icon2: Icons.assignment_add,
              onTap: () {},
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}

class ContrallBottonInAdminHomeScreen extends StatelessWidget {
  const ContrallBottonInAdminHomeScreen({
    super.key,
    required this.buttonTitle,
    this.onTap,
    this.icon1,
    this.icon2,
    required this.colorToButtonContainer,
  });
  final String buttonTitle;
  final void Function()? onTap;
  final IconData? icon1;
  final IconData? icon2;
  final Color colorToButtonContainer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 5.w),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
            color: colorToButtonContainer,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon1,
                  size: 45,
                  // color: ColorManger.white,
                ),
                Icon(
                  icon2,
                  size: 45,
                  //color: ColorManger.white,
                ),
              ],
            )),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                flex: 2,
                child: Text(
                  buttonTitle,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: ColorManger.black,
                      ),
                )),
          ],
        ),
      ),
    );
  }
}
