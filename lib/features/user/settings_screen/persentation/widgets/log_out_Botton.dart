import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mohra_project/core/constants/constans_collections/collections.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';

class LogOutBotton extends StatelessWidget {
  const LogOutBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return GestureDetector(
            onTap: () {
              GoogleSignIn googleSignIn = GoogleSignIn();
              if (googleSignIn.currentUser != null) {
                googleSignIn.disconnect();
                Constanscollection.updateUserStatus(2);
              } else {
                // If not logged in with Google, perform email logout
                Constanscollection.updateUserStatus(2);
                BlocProvider.of<AuthCubit>(context).logOut().then((value) =>
                    Navigator.of(context)
                        .pushReplacementNamed(RouterName.loginScreen));
              }
            },
            child: Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: ListTile(
                leading: Icon(Icons.logout, size: 24.h),
                title: Text(
                  "LogOut",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ));
      },
    );
  }
}
