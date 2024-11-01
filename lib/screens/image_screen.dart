import 'package:budget_map/screens/photo_view_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/Images_provider.dart';
import '../widgets/appbar.dart';
import 'images_add_screen.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ImagesProvider>(context, listen: false).getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                onPressed: () => addImageScreen(context: context),
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onSurface,
                )),
            appBar: buildAppBar(context: context, title: 'الصور'),
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Consumer<ImagesProvider>(
              builder:
                  (BuildContext context, ImagesProvider value, Widget? child) {
                if (value.getDone) {
                  return Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                          width: MediaQuery.sizeOf(context).width - 20.0,
                          child: ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: value.data.length,
                              itemBuilder: (context, i) {
                                if (kDebugMode) {
                                  print(value.data[i].url);
                                  print(Supabase.instance.client.auth.headers);
                                }
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PhotoViewScreen(
                                              imageUrl: value.data[i].url!),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: CachedNetworkImage(
                                            imageUrl: value.data[i].url!,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget: (context, url, error) {
                                              if (kDebugMode) {
                                                print(error);
                                              }
                                              return const Icon(Icons.error);
                                            },
                                            httpHeaders: Supabase.instance
                                                .client.auth.headers)));
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: 3);
                              })));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )));
  }

  void addImageScreen({required BuildContext context}) {
    Provider.of<ImagesProvider>(context, listen: false).addDone = false;
    Provider.of<ImagesProvider>(context, listen: false).addLoading = false;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AddImagesScreen()))
        .then((result) {
      if (context.mounted) {
        Provider.of<ImagesProvider>(context, listen: false).getImages();
      }
    });
  }
}
