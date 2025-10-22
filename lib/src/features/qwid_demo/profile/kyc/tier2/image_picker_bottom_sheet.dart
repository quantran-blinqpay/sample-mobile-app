import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';

// Future<String?> showGalleryBottomSheet(BuildContext context) async {
//   return await showModalBottomSheet<String>(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => const ImagePickerBottomSheet(),
//   );
// }

class ImagePickerBottomSheet extends StatefulWidget {
  const ImagePickerBottomSheet({super.key});

  @override
  State<ImagePickerBottomSheet> createState() => _ImagePickerBottomSheetState();
}

class _ImagePickerBottomSheetState extends State<ImagePickerBottomSheet> {
  List<AssetEntity> _images = [];
  AssetEntity? _selected;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.isAuth) {
      PhotoManager.openSetting();
      return;
    }

    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      onlyAll: true,
      type: RequestType.image,
    );

    List<AssetEntity> media = await albums.first.getAssetListPaged(page: 0, size: 100);

    setState(() => _images = media);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xffCCCCCC)
            ),
          ),
          // header
          SizedBox(
            height: 50,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "All photos",
                    style: TextStyle(fontFamily: 'Creato Display', fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SvgPicture.asset(icQwidArrowDown, width: 24, height: 24),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(2),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: _images.length,
              itemBuilder: (context, index) {
                final asset = _images[index];
                return GestureDetector(
                  onTap: () async {
                    final file = await asset.file;
                    if (file != null) {
                      setState(() => _selected = asset);
                      context.router.pop(file.path);
                      // Get.back(result: file.path);
                    }
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AssetEntityImage(asset, fit: BoxFit.cover),
                      if (_selected == asset)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(Icons.check, size: 18, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}