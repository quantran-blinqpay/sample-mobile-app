// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/components/dialog/custom_dialog.dart';
import 'package:qwid/src/components/image/app_image.dart';
import 'package:qwid/src/components/loading_indicator/app_modal_loader.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/core/utils/image_utils.dart';
import 'package:qwid/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:qwid/src/router/router.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class CreateAddPhoto extends StatelessWidget {
  CreateAddPhoto({super.key});
  late AppColors appColors;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<CreateListingCubit, CreateListingState>(
          // buildWhen: (previous, current) =>
          //     previous.photos != current.photos ||
          //     previous.isPhotosValid != current.isPhotosValid,
          builder: (context, state) {
            return Container(
              height: 150,
              padding: const EdgeInsets.all(16),
              child: DottedBorder(
                options: RectDottedBorderOptions(
                  dashPattern: state.isPhotosValid ?? false ? [8, 8] : [8, 0],
                  padding: EdgeInsets.symmetric(vertical: 8),
                  color: state.isPhotosValid ?? false
                      ? appColors.gainsboro
                      : appColors.red,
                ),
                child: Center(
                  child: state.photos?.isEmpty ?? true
                      ? ElevatedAppButton(
                          onPressed: () {
                            _onPickImages(context);
                          },
                          padding: EdgeInsets.zero,
                          bgColor: appColors.white,
                          radius: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: appColors.black),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, color: appColors.black),
                                SizedBox(width: 4),
                                Text(
                                  'Add Photos',
                                  style: AppStyles.of(context).copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            children: [
                              ReorderableListView.builder(
                                onReorder: (oldIndex, newIndex) {
                                  if (newIndex ==
                                      ((state.photos?.length ?? 0) + 1)) {
                                    return;
                                  } else {
                                    context
                                        .read<CreateListingCubit>()
                                        .reorderImages(oldIndex, newIndex);
                                  }
                                },
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: (state.photos?.length ?? 0),
                                proxyDecorator: (child, index, animation) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: child,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  final image = state.photos![index];

                                  return Stack(
                                    key: image.uploadId?.isNotEmpty ?? false
                                        ? Key(image.uploadId!)
                                        : Key(image.path),
                                    clipBehavior: Clip.none,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          final bool isUsingPath = state.photos
                                                  ?.any((e) =>
                                                      e.path.isNotEmpty) ??
                                              false;
                                          var imageUrls = <String>[];
                                          if (isUsingPath) {
                                            imageUrls = state.photos
                                                    ?.map((e) => e.path)
                                                    .toList() ??
                                                <String>[];
                                          } else {
                                            imageUrls = state.photos
                                                    ?.map((e) =>
                                                        e.uploadUrl ?? '')
                                                    .toList() ??
                                                <String>[];
                                          }

                                          context.router.push(
                                            PreviewImageScreenRoute(
                                              imageUrls: imageUrls,
                                              initialIndex: index,
                                              usingPath: isUsingPath,
                                              heroTag:
                                                  'createListingPhoto$index',
                                            ),
                                          );
                                        },
                                        child: Opacity(
                                          opacity: (image.isLoading ?? false)
                                              ? 0.5
                                              : 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: SizedBox(
                                              width: 120,
                                              height: 120,
                                              child: image.path.isNotEmpty
                                                  ? Image.file(
                                                      File(image.path),
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (_, __, ___) =>
                                                              const Icon(
                                                                  Icons.error),
                                                    )
                                                  : AppImage(
                                                      imageUrl:
                                                          image.uploadUrl ??
                                                              ''),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: ElevatedAppButton(
                                          onPressed: () async {
                                            await CustomDialog
                                                .showConfirmDialog(
                                              context,
                                              title: 'Confirmation',
                                              subtitle:
                                                  'Are you sure you want to delete this image?',
                                              positiveText: 'Delete',
                                              onPositive: () async {
                                                context
                                                    .read<CreateListingCubit>()
                                                    .removeImage(
                                                        image.uploadId);

                                                if ((state.photos?.length ??
                                                        0) >
                                                    1) {
                                                  context
                                                      .read<
                                                          CreateListingCubit>()
                                                      .buildDescByAi();
                                                } else {
                                                  context
                                                      .read<
                                                          CreateListingCubit>()
                                                      .clearListTempImg();
                                                }
                                              },
                                            );
                                          },
                                          width: 24,
                                          height: 24,
                                          bgColor: appColors.white,
                                          padding: EdgeInsets.all(7),
                                          radius: 100,
                                          child: SvgPicture.asset(
                                            Assets.svgs.icClose,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: ElevatedAppButton(
                                          onPressed: () {
                                            context
                                                .read<CreateListingCubit>()
                                                .rotateImage(index);
                                          },
                                          width: 24,
                                          height: 24,
                                          bgColor: appColors.white,
                                          padding: EdgeInsets.all(0),
                                          radius: 100,
                                          child: Icon(
                                            Icons.refresh_rounded,
                                            size: 16,
                                            color: appColors.black,
                                          ),
                                        ),
                                      ),
                                      if (image.isLoading ?? false)
                                        Positioned.fill(
                                          child: AppLoadingIndicator(
                                            shadowColor: Colors.transparent,
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                              Center(
                                key: Key('add_photo_create'),
                                child: ElevatedAppButton(
                                  onPressed: () {
                                    _onPickImages(context);
                                  },
                                  bgColor: appColors.white,
                                  radius: 6,
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border:
                                          Border.all(color: appColors.black),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: appColors.black,
                                      size: 21,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            );
          },
        ),
        Row(
          children: [
            SizedBox(width: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: appColors.coralBlue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'NEW',
                style: AppStyles.of(context).copyWith(
                  color: appColors.vividBlue,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'Click and drag to change the order of your photos.',
                style: AppStyles.of(context).copyWith(
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 24),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFFFF37D7),
                Color(0xFF7B00FF),
                Color(0xFF0022EC),
              ],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: appColors.white,
                size: 20,
              ),
              SizedBox(width: 16),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Add photos of the item's tag to auto-detect brand, size, and more! ",
                        style: AppStyles.of(context).copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: appColors.white,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // TODO_quangdm show screen toggle AI
                          },
                        text: 'AI Settings',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: appColors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: '. ',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: appColors.white,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // TODO_quandm show dialog
                          },
                        text: 'Photo tips',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: appColors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' →',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: appColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onPickImages(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return CupertinoActionSheet(
          title: Text('Add Photo'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(ctx).pop();
                try {
                  final images = await ImagePicker()
                      .pickMultiImage(limit: 20)
                      .catchError((e) {
                    if (e != null) {
                      ImageUtils.handleImagePermission(
                          context, e as PlatformException);
                    }
                    return <XFile>[];
                  });
                  if (images.isNotEmpty) {
                    context.read<CreateListingCubit>().addImages(images);
                  }
                } catch (e) {
                  debugPrint('Upload file error: $e');
                  rethrow;
                }
              },
              child: Text(
                'Choose a Photo',
                style: AppStyles.of(context).copyWith(
                  color: appColors.vibrantBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(ctx).pop();
                final photo = await ImagePicker()
                    .pickImage(source: ImageSource.camera)
                    .catchError((e) {
                  if (e != null) {
                    ImageUtils.handleImagePermission(
                        context, e as PlatformException);
                  }
                  return null;
                });
                if (photo?.path != null) {
                  context.read<CreateListingCubit>().addImages([photo!]);
                }
              },
              child: Text(
                'Take a Photo',
                style: AppStyles.of(context).copyWith(
                  color: appColors.vibrantBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {},
            child: Text(
              'Cancel',
              style: AppStyles.of(context).copyWith(
                color: appColors.vibrantBlue,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}
