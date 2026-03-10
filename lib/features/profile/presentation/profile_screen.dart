import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:textract/core/constants/color_manager.dart';
import 'package:textract/core/di/service_locator.dart';
import 'package:textract/features/profile/data/repository/repo.dart';
import 'package:textract/features/profile/logic/cubit.dart';
import 'package:textract/features/profile/logic/state.dart';
import 'package:textract/features/profile/presentation/shared_widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(getIt<ProfileRepository>())..getUserData(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  ProfileAvatar(
                    imageUrl: state.user.image == '' ? null : state.user.image,
                    name: state.user.name ?? 'Not Found',
                  ),
                  SizedBox(height: 24.h),
                  ProfileInfoCard(
                    name: state.user.name ?? 'Not Found',
                    email: state.user.email ?? 'Not Found',
                  ),
                  SizedBox(height: 16.h),
                  ProfileActionButton(
                    icon: Icons.edit_rounded,
                    label: 'Edit Profile',
                    onTap: () {
                      final cubit = context.read<ProfileCubit>();
                      showDialog(
                        context: context,
                        builder: (context) => EditProfileDialog(cubit: cubit),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  ProfileActionButton(
                    icon: Icons.logout_rounded,
                    label: 'Logout',
                    color: ColorManager.red,
                    onTap: () {},
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
