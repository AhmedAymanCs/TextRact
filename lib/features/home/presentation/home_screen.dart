import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textract/core/constants/image_manager.dart';
import 'package:textract/core/constants/string_manager.dart';
import 'package:textract/core/di/service_locator.dart';
import 'package:textract/core/router/routes.dart';
import 'package:textract/features/home/data/repository/repo.dart';
import 'package:textract/features/home/logic/cubit.dart';
import 'package:textract/features/home/logic/state.dart';
import 'package:textract/features/home/presentation/shared_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(getIt<HomeRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.appName),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.history_rounded),
              onPressed: () => Navigator.pushNamed(context, Routes.history),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            return Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Image.asset(
                      ImageManager.placeholder,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: SourceButton(
                          icon: Icons.camera_alt_rounded,
                          label: StringManager.camera,
                          onTap: () => cubit.pickImage(ImageSource.camera),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SourceButton(
                          icon: Icons.photo_library_rounded,
                          label: StringManager.gallery,
                          onTap: () => cubit.pickImage(ImageSource.gallery),
                        ),
                      ),
                    ],
                  ),
                ),

                MaterialButton(
                  onPressed: () {
                    cubit.pickImage(ImageSource.gallery);
                  },
                  child: const Text(StringManager.extract),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
