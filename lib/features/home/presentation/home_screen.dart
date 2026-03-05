import 'package:flutter/material.dart';
import 'package:textract/core/constants/image_manager.dart';
import 'package:textract/core/constants/string_manager.dart';
import 'package:textract/core/router/routes.dart';
import 'package:textract/features/home/presentation/shared_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Image.asset(ImageManager.placeholder, fit: BoxFit.contain),
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
                    onTap: () {
                      //Todo: add logic
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SourceButton(
                    icon: Icons.photo_library_rounded,
                    label: StringManager.gallery,
                    onTap: () {
                      //Todo: add logic
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
