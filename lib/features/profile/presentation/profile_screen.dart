import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:textract/core/constants/color_manager.dart';
import 'package:textract/features/profile/presentation/shared_widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const ProfileAvatar(imageUrl: null, name: 'John Doe'),
            SizedBox(height: 24.h),
            const ProfileInfoCard(name: 'John Doe', email: 'johndoe@email.com'),
            SizedBox(height: 16.h),
            ProfileActionButton(
              icon: Icons.edit_rounded,
              label: 'Edit Profile',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            ProfileActionButton(
              icon: Icons.logout_rounded,
              label: 'Logout',
              color: ColorManager.red,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
