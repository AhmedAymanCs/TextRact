import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textract/core/constants/color_manager.dart';
import 'package:textract/core/constants/image_manager.dart';
import 'package:textract/core/constants/string_manager.dart';
import 'package:textract/core/di/service_locator.dart';
import 'package:textract/core/router/routes.dart';
import 'package:textract/core/widgets/custom_button.dart';
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
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.status is HomeError) {
              Fluttertoast.showToast(
                msg: (state.status as HomeError).error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            }
            if (state.status is HomeSuccess) {
              Fluttertoast.showToast(
                msg: 'Text extracted',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      child: state.file == null
                          ? Image.asset(
                              ImageManager.placeholder,
                              fit: BoxFit.contain,
                            )
                          : Image.file(
                              File(state.file!.path),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      text: StringManager.extract,
                      onPressed: state.file == null
                          ? null
                          : () => cubit.extractText(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: state.textExtracted != ''
                          ? ColorManager.backgroundGray
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SelectableText(
                      state.textExtracted != ''
                          ? state.textExtracted
                          : StringManager.notextracted,
                      style: TextStyle(
                        fontSize: 15,
                        color: state.textExtracted.isNotEmpty
                            ? ColorManager.textDark
                            : ColorManager.gray500,
                      ),
                    ),
                  ),
                  state.textExtracted == ''
                      ? SizedBox()
                      : IconButton(
                          onPressed: () => cubit.copyText(),
                          icon: Icon(Icons.copy),
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
