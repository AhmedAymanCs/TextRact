import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textract/core/constants/color_manager.dart';
import 'package:textract/core/constants/font_manager.dart';
import 'package:textract/core/widgets/custom_button.dart';
import 'package:textract/core/widgets/cutom_form_field.dart';
import 'package:textract/features/profile/data/models/update_model.dart';
import 'package:textract/features/profile/logic/cubit.dart';
import 'package:textract/features/profile/logic/state.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  const ProfileAvatar({super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
          child: imageUrl == null
              ? Text(
                  name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 40),
                )
              : null,
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeightManager.bold,
          ),
        ),
      ],
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final String name;
  final String email;
  const ProfileInfoCard({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.backgroundGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ProfileInfoRow(
            icon: Icons.person_rounded,
            label: 'Name',
            value: name,
          ),
          const Divider(height: 20),
          ProfileInfoRow(
            icon: Icons.email_rounded,
            label: 'Email',
            value: email,
          ),
        ],
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const ProfileInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: ColorManager.gray500),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(color: ColorManager.gray500)),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeightManager.medium),
        ),
      ],
    );
  }
}

class ProfileActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  const ProfileActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: ColorManager.backgroundGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color ?? ColorManager.textDark),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeightManager.medium,
                color: color ?? ColorManager.textDark,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: ColorManager.gray500,
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileDialog extends StatefulWidget {
  final ProfileCubit cubit;
  const EditProfileDialog({super.key, required this.cubit});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _nameController;
  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormField(hint: 'New Name', controller: _nameController),
          CustomButton(
            text: 'Update',
            onPressed: () => widget.cubit.updateUserData(
              UpdateModel(name: _nameController.text),
            ),
          ),
        ],
      ),
    );
  }
}
