import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
import 'package:mohra_project/generated/l10n.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return GestureDetector(
            onTap: () {
              BlocProvider.of<AuthCubit>(context).deleteAccount().then(
                  (value) => Navigator.of(context)
                      .pushReplacementNamed(RouterName.registerScreen));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: ListTile(
                leading: Icon(
                  Icons.delete,
                  size: 24.h,
                  color: Colors.red,
                ),
                title: Text(
                  S.of(context).Delete,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.red),
                ),
              ),
            ));
      },
    );
  }
}
