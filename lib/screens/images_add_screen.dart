import 'dart:io';
import 'package:budget_map/models/image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/Images_provider.dart';
import '../widgets/appbar.dart';

class AddImagesScreen extends StatefulWidget {
  const AddImagesScreen({super.key});

  @override
  State<AddImagesScreen> createState() => _AddImagesScreenState();
}

class _AddImagesScreenState extends State<AddImagesScreen> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context, title: 'Add Image'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<ImagesProvider>(
          builder: (BuildContext context, ImagesProvider value, Widget? child) {
            if (!value.addDone && !value.addLoading) {
              return Column(children: [
                StatefulBuilder(builder: (BuildContext context,
                    void Function(void Function()) internalSetState) {
                  return Column(children: [
                    _selectedImage != null
                        ? Image.file(_selectedImage!)
                        : const Text('No Image Selected'),
                    ElevatedButton(
                        onPressed: () async {
                          final pickedFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            internalSetState(() {
                              _selectedImage = File(pickedFile.path);
                            });
                          }
                        },
                        child: const Icon(Icons.add)),
                  ]);
                }),
                ElevatedButton(
                    onPressed: () {
                      Provider.of<ImagesProvider>(context, listen: false)
                          .addImage(ImageModel(name: "test1"), _selectedImage!);
                    },
                    child: const Text("Add"))
              ]);
            } else {
              value.addDone = false;
              Future.microtask(() {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              });
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
