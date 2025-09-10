// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:qwid/src/core/constants/app_constants.dart';
import 'package:qwid/src/core/constants/filter_class.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/core/network/response/enum/progress_status.dart';
import 'package:qwid/src/core/shared_prefs/country_storage.dart';
import 'package:qwid/src/core/utils/color_utils.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/build_desc_by_ai_response.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/get_dwpost_freight_response.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/get_free_bump_response.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/get_price_recommend_response.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/search_brands_response.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/upload_image_response.dart';
import 'package:qwid/src/features/create_listing/domain/models/create_listing_model.dart';
import 'package:qwid/src/features/create_listing/domain/models/photo_entry.dart';
import 'package:qwid/src/features/create_listing/domain/models/save_draft_model.dart';
import 'package:qwid/src/features/create_listing/domain/respositories/create_listing_repository.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/filter_item_response.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/filter_size_response.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/get_category_response.dart';
import 'package:qwid/src/features/helper/cubit/helper_cubit.dart';
import 'package:qwid/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
part 'create_listing_state.dart';

class CreateListingCubit extends Cubit<CreateListingState> {
  CreateListingCubit(this.repository) : super(CreateListingState());

  final CreateListingRepository repository;
  final dataStartup = GetIt.instance<HelperCubit>().state.startup;
  final dataSiteSetting = GetIt.instance<HelperCubit>().state.siteSetting;

  void initData({ListingDetailResponseData? dataDetail}) {
    initDataFirstLoad(dataDetail: dataDetail);
    getFreeBump();
  }

  Future<void> initDataFirstLoad(
      {ListingDetailResponseData? dataDetail}) async {
    final cateWomen =
        dataStartup?.categories?.firstWhereOrNull((e) => e.id == 2);
    final isFromAud = await di<CountryStorage>().read();

    final auShippingPrice = isFromAud?.toLowerCase() == kAustralia
        ? '10.00'
        : (dataSiteSetting
                    ?.global?.defaultShippingFee?.defaultNzToAuFeeForNzUser ??
                0)
            .toStringAsFixed(2);

    emit(state.copyWith(
      department: cateWomen,
      nzShippingPrice: isFromAud?.toLowerCase() == kAustralia ? '20.00' : null,
      auShippingPrice: auShippingPrice,
    ));

    if (dataDetail != null) {
      initDataDetail(dataDetail);
    }
  }

  Future<void> getFreeBump() async {
    final response = await repository.getFreeBump();
    response.fold((error) {
      debugPrint('getFreeBump error: ${error.toString()}');
    }, (data) {
      emit(state.copyWith(
        dataFreeBump: data,
      ));
    });
  }

  void initDataDetail(ListingDetailResponseData? dataDetail) async {
    final isFromAud = await di<CountryStorage>().read();
    final pricePattern = dataDetail?.pricePattern;
    final dataColours = dataStartup?.colours?.toColourList() ?? <FilterClass>[];
    List<PhotoEntry>? photos = [];
    List<FilterClass>? colours = [];

    // Xu ly photo
    if (dataDetail?.primaryImage?.data != null) {
      photos.add(PhotoEntry(
        path: '',
        isLoading: false,
        uploadId: '${dataDetail?.primaryImage?.data?.id ?? ''}',
        uploadUrl: dataDetail?.primaryImage?.data?.url ?? '',
      ));
    }

    if (dataDetail?.secondaryImages?.data?.isNotEmpty ?? false) {
      dataDetail?.secondaryImages?.data?.forEach((photo) {
        photos.add(PhotoEntry(
          path: '',
          isLoading: false,
          uploadId: '${photo.id ?? ''}',
          uploadUrl: photo.url ?? '',
        ));
      });
    }

    // Ghép category theo AI
    final tempCategory = dataStartup?.categories
        ?.firstWhereOrNull((e) => e.urlTitle == dataDetail?.category?.urlTitle);
    _getParentCategory(tempCategory, dataDetail?.category?.urlTitle);

    // Mapping sizes
    final candidates = <List<FilterSizeResponse>?>[
      state.category?.genericSizes,
      state.subCategory?.genericSizes,
      state.secondsubCategory?.genericSizes,
    ];

    final dataSizes =
        candidates.firstWhereOrNull((l) => l?.isNotEmpty == true) ??
            const <FilterSizeResponse>[];
    List<FilterSizeResponse>? sizes = [];
    dataDetail?.sizes?.dedupKeepFirst().forEach((s) {
      final item = dataSizes.firstWhereOrNull((e) => e.id == s.id);
      if (item != null) {
        sizes.add(item);
      }
    });

    // Mapping color
    if (dataDetail?.colour?.trim().isNotEmpty ?? false) {
      dataDetail?.colour?.split(',').forEach((e) {
        final color = dataColours.firstWhereOrNull((c) => c.name == e);
        if (color != null) {
          colours.add(color);
        }
      });
    }

    emit(state.copyWith(
      photos: photos,
      title: dataDetail?.title ?? '',
      describle: dataDetail?.description ?? '',
      brand: SearchBrandsResponse(
          id: dataDetail?.brand?.id, name: dataDetail?.brand?.title),
      sizes: sizes,
      colours: colours,
      condition: FilterItemResponse(
          id: dataDetail?.condition?.id,
          title: dataDetail?.condition?.title,
          subTitle: dataDetail?.condition?.subTitle),
      sellingPrice: isFromAud?.toLowerCase() == kAustralia
          ? dataDetail?.priceAudMinusShipping?.toStringAsFixed(2)
          : dataDetail?.priceNzdMinusShipping?.toStringAsFixed(2),
      originalPrice: isFromAud?.toLowerCase() == kAustralia
          ? dataDetail?.priceRetailAud?.toStringAsFixed(2)
          : dataDetail?.priceRetailNzd?.toStringAsFixed(2),
      nzShippingPrice: pricePattern?.shippingToNz?.amount?.toStringAsFixed(2),
      auShippingPrice: pricePattern?.shippingToAu?.amount?.toStringAsFixed(2),
      isUseShipping: pricePattern?.shippingToAu != null,
      isOfferBuyNow: dataDetail?.enableBuyNowPayLater ?? false,
    ));

    getCommission(state.sellingPrice, state.nzShippingPrice);
  }

  /// ADD PHOTO
  void updatePhotoValid(bool v) {
    emit(state.copyWith(isPhotosValid: v));
  }

  Future<UploadImageResponse?> uploadImage(File image) async {
    final response = await repository.uploadImage(image);
    UploadImageResponse? dataReturn;
    response.fold((error) {
      debugPrint('uploadImage error ${error.toString()}');
    }, (data) {
      dataReturn = data;
    });
    return dataReturn;
  }

  Future<UploadImageResponse?> uploadRotateImage(String? pathId) async {
    final response = await repository.rotateImage(pathId);
    UploadImageResponse? dataReturn;
    response.fold((error) {
      debugPrint('uploadRotateImage error ${error.toString()}');
    }, (data) {
      dataReturn = data;
    });
    return dataReturn;
  }

  Future<void> deleteImage(String? pathId) async {
    final response = await repository.deleteImage(pathId);
    response.fold((error) {
      debugPrint('deleteImage error ${error.toString()}');
    }, (data) {});

    if ((state.photos?.length ?? 0) > 1) await buildDescByAi();
  }

  Future<void> addImages(List<XFile> images) async {
    final temp = [...(state.photos ?? const <PhotoEntry>[])];
    temp.addAll(images.map((x) => PhotoEntry(path: x.path)));
    emit(state.copyWith(photos: temp, isPhotosValid: true));

    // Upload images concurrently
    final uploadFutures = temp
        .asMap()
        .entries
        .where((entry) => entry.value.isLoading ?? false)
        .map((entry) async {
      final index = entry.key;
      final photo = entry.value;
      final res = await uploadImage(photo.file);
      final updatedPhoto = res != null
          ? photo.copyWith(
              uploadId: res.id,
              uploadUrl: res.url,
              isLoading: false,
            )
          : photo.copyWith(isLoading: false);
      return MapEntry(index, updatedPhoto);
    });

    // Wait for all uploads to complete
    final results = await Future.wait(uploadFutures);

    // Update the state with the results
    final updatedPhotos = List<PhotoEntry>.from(temp);
    for (var result in results) {
      updatedPhotos[result.key] = result.value;
      // Emit state for each completed upload to update UI incrementally
      emit(state.copyWith(photos: List.from(updatedPhotos)));
    }

    await buildDescByAi();
  }

  void removeImage(String? uploadId) {
    final next = List<PhotoEntry>.of(state.photos ?? <PhotoEntry>[])
      ..removeWhere((f) => f.uploadId == uploadId);

    emit(state.copyWith(
      photos: next,
      isPhotosValid: next.isNotEmpty,
    ));

    // TODO_quangdm neu dang edit thi khi xoa se dua vao list tam, neu save thi moi xoa han
    deleteImage(uploadId);
  }

  Future<void> clearListTempImg() async {
    final tempDir = await getTemporaryDirectory();
    final tempFiles = tempDir
        .listSync()
        .where((file) => file.path.contains('rotated_image_'));
    for (var file in tempFiles) {
      if (file is File && await file.exists()) {
        await file.delete();
        debugPrint('Deleted temporary file: ${file.path}');
      }
    }
  }

  void rotateImage(int index) async {
    final list = List<PhotoEntry>.of(state.photos ?? []);
    final photo = list[index];

    list[index] = photo.copyWith(isLoading: true);
    emit(state.copyWith(photos: list));

    try {
      final file = File(photo.path);
      if (!await file.exists()) {
        return;
      }

      final imageBytes = await file.readAsBytes();
      final originalImage = img.decodeImage(imageBytes);

      if (originalImage == null) {
        return;
      }

      // Rotate the image by 90 degrees
      final fixedImage = img.copyRotate(originalImage, angle: 90);

      // Create a unique temporary file name using timestamp
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final tempFile =
          File('${tempDir.path}/rotated_image_${index}_$timestamp.jpg');
      await tempFile.writeAsBytes(img.encodeJpg(fixedImage));

      final res = await uploadRotateImage(photo.uploadId);
      final updatedRotatePhoto = res != null
          ? photo.copyWith(
              path: tempFile.path,
              uploadId: res.id,
              uploadUrl: res.url,
              isLoading: false,
            )
          : photo.copyWith(isLoading: false);

      list[index] = updatedRotatePhoto;
      emit(state.copyWith(photos: list));
    } catch (e) {
      debugPrint('rotateImage error: $e');
    }
  }

  void reorderImages(int oldIndex, int newIndex) {
    final updatedList = List<PhotoEntry>.of(state.photos ?? []);
    if (newIndex > oldIndex) newIndex -= 1;
    final item = updatedList.removeAt(oldIndex);
    updatedList.insert(newIndex, item);
    emit(state.copyWith(photos: updatedList));
  }

  /// DESCRIPTION
  Future<void> buildDescByAi() async {
    emit(state.copyWith(fetchAIStatus: ProgressStatus.inProgress));

    final response = await repository
        .buildDescByAi(state.photos?.map((e) => e.uploadUrl ?? '').toList());

    response.fold((error) {
      emit(state.copyWith(fetchAIStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        dataAI: data,
        fetchAIStatus: ProgressStatus.success,
      ));
    });

    final data = state.dataAI;

    final tempCategory = dataStartup?.categories
        ?.firstWhereOrNull((e) => e.urlTitle == data?.category);

    // Ghép category theo AI
    _getParentCategory(tempCategory, data?.category);

    // Sau khi đã có department tiến hành tìm kiếm brand theo name va lấy ra phần tử đầu tiên
    if (state.department?.id != null &&
        state.department?.id != 93 &&
        (data?.brand?.isNotEmpty ?? false)) {
      await searchBrands(data?.brand);
    }

    // Lay ra sizes

    final sizes = <FilterSizeResponse>[];
    if (data?.size?.isNotEmpty ?? false) {
      final candidates = <List<FilterSizeResponse>?>[
        state.category?.genericSizes,
        state.subCategory?.genericSizes,
        state.secondsubCategory?.genericSizes,
      ];

      final dataSizes =
          candidates.firstWhereOrNull((l) => l?.isNotEmpty == true) ??
              const <FilterSizeResponse>[];

      final tempSize = dataSizes.firstWhereOrNull((e) =>
          (e.genericSize == data?.size) ||
          ('${e.genericSize}/${e.altSize}' == data?.size));
      if (tempSize?.id != null) {
        sizes.add(tempSize!);
      }
    }

    // Lay ra colours
    final colours = <FilterClass>[];
    data?.colour?.forEach(
      (color) {
        var hexCode = ColorUtils.hexKeyFromLabelString(color);
        colours.add(
          FilterClass(
            id: hexCode,
            name: color,
          ),
        );
      },
    );

    /// lay ra condition theo category cuoi cung hien co
    final id = state.secondsubCategory?.id ??
        state.subCategory?.id ??
        state.category?.id ??
        state.department?.id;

    if (id != null) {
      await getConditions(id);
    }

    final condition = state.dataCondition
        ?.firstWhereOrNull((e) => e.title == data?.condition);

    emit(state.copyWith(
      brand: state.dataBrands?.first,
      sizes: sizes,
      colours: colours,
      condition: condition,
    ));

    if (canCallPriceRecommendation() ?? false) {
      getPriceRecommend();
    }
  }

  void useDescByAi() async {
    emit(state.copyWith(
      title: state.dataAI?.title ?? '',
      describle: state.dataAI?.description ?? '',
    ));
  }

  void _getParentCategory(
    GetCategoryResponse? tempCategory,
    String? aICategory,
  ) {
    if (tempCategory?.parentId != null) {
      final parentTemp = dataStartup?.categories
          ?.firstWhereOrNull((e) => e.id == tempCategory?.parentId);

      if (parentTemp?.parentId != null) {
        _getParentCategory(parentTemp, aICategory);
      } else {
        // == null => Have Department then get sub-category by tempCategory
        GetCategoryResponse? subCategory;
        GetCategoryResponse? secondSubCategory;
        if (dataStartup?.haveChidren(tempCategory?.id ?? -1) ?? false) {
          subCategory = dataStartup?.categories?.firstWhereOrNull(
            (e) =>
                e.parentId == tempCategory?.id &&
                (aICategory?.contains(e.urlTitle ?? '') ?? false),
          );

          // Ktra xem co second sub category khong
          if (dataStartup?.haveChidren(subCategory?.id ?? -1) ?? false) {
            secondSubCategory = dataStartup?.categories?.firstWhereOrNull(
              (e) =>
                  e.parentId == subCategory?.id &&
                  (aICategory?.contains(e.urlTitle ?? '') ?? false),
            );
          }
        }
        emit(state.copyWith(
          department: parentTemp,
          category: tempCategory,
          subCategory: subCategory,
          secondsubCategory: secondSubCategory,
        ));
      }
    }
  }

  void updateTitle(String value) {
    emit(state.copyWith(title: value));
  }

  void updateDescrible(String value) {
    emit(state.copyWith(describle: value));
  }

  void updateDepartment(GetCategoryResponse? value) {
    emit(
      state.copyWith(
        department: value,
        category: GetCategoryResponse(),
        subCategory: GetCategoryResponse(),
        secondsubCategory: GetCategoryResponse(),
        brand: SearchBrandsResponse(),
        condition: FilterItemResponse(),
        sizes: [],
      ),
    );
  }

  void updateCategory(GetCategoryResponse? value) {
    emit(state.copyWith(
      category: value,
      subCategory: GetCategoryResponse(),
      secondsubCategory: GetCategoryResponse(),
      brand: SearchBrandsResponse(),
      condition: FilterItemResponse(),
      sizes: [],
    ));
    if (canCallPriceRecommendation() ?? false) {
      getPriceRecommend();
    }
  }

  void updateSubCategory(GetCategoryResponse? value) {
    emit(state.copyWith(
      subCategory: value,
      secondsubCategory: GetCategoryResponse(),
      condition: FilterItemResponse(),
      sizes: [],
    ));
  }

  void updateSecondSubCategory(GetCategoryResponse? value) {
    emit(state.copyWith(
      secondsubCategory: value,
      condition: FilterItemResponse(),
      sizes: [],
    ));
  }

  /// ITEM INFO
  Future<void> searchBrands(String? textSearch) async {
    emit(state.copyWith(fetchSearchBrandsStatus: ProgressStatus.inProgress));
    final response = await repository.searchBrands(
      textSearch,
      state.category?.id ?? state.department?.id ?? 0,
    );

    response.fold((error) {
      emit(state.copyWith(fetchSearchBrandsStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        dataBrands: data,
        fetchSearchBrandsStatus: ProgressStatus.success,
      ));
    });
  }

  void updateBrand(SearchBrandsResponse? value) {
    emit(state.copyWith(brand: value));
    if (canCallPriceRecommendation() ?? false) {
      getPriceRecommend();
    }
  }

  void updateSizes(List<FilterSizeResponse> value) {
    emit(state.copyWith(sizes: List<FilterSizeResponse>.from(value)));
  }

  void removeSize(FilterSizeResponse value) {
    final temp =
        List<FilterSizeResponse>.from(state.sizes ?? <FilterSizeResponse>[]);

    if (temp.any((e) => e.id == value.id)) {
      temp.removeWhere((e) => e.id == value.id);
    }

    if (!ListEquality().equals(temp, state.sizes)) {
      emit(state.copyWith(sizes: temp));
    }
  }

  void updateColour(List<FilterClass> value) {
    emit(state.copyWith(colours: List<FilterClass>.from(value)));
  }

  void removeColour(FilterClass value) {
    final temp = List<FilterClass>.from(state.colours ?? <FilterClass>[]);

    if (temp.any((e) => e.id == value.id)) {
      temp.removeWhere((e) => e.id == value.id);
    }

    if (!ListEquality().equals(temp, state.colours)) {
      emit(state.copyWith(colours: temp));
    }
  }

  Future<void> getConditions(int? id) async {
    final response = await repository.getConditions(id);

    response.fold((error) {
      debugPrint('getConditions error: ${error.toString()}');
    }, (data) {
      emit(state.copyWith(
        dataCondition: data?.data,
      ));
    });
  }

  void updateCondition(FilterItemResponse? value) {
    emit(state.copyWith(condition: value));
    if (canCallPriceRecommendation() ?? false) {
      getPriceRecommend();
    }
  }

  /// PRICE
  void updateSellingPrice(String value) {
    emit(state.copyWith(sellingPrice: value));
  }

  void updateOriginalPrice(String value) {
    emit(state.copyWith(originalPrice: value));
  }

  bool? canCallPriceRecommendation() {
    return state.brand?.id != null &&
        state.condition?.id != null &&
        state.category?.id != null;
  }

  void getPriceRecommend() async {
    emit(state.copyWith(fetchPriceStatus: ProgressStatus.inProgress));

    final response = await repository.getPriceRecommend(
      state.brand?.id,
      state.condition?.id,
      state.category?.id,
    );

    response.fold((error) {
      emit(state.copyWith(fetchPriceStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        dataPriceRecommend: data,
        fetchPriceStatus: ProgressStatus.success,
      ));
    });
  }

  /// SHIPPING
  void toogleUseShipping(bool value) {
    emit(state.copyWith(isUseShipping: value));
  }

  void updateNzShippingPrice(String value) {
    emit(state.copyWith(nzShippingPrice: value));
  }

  void updateAuShippingPrice(String value) {
    emit(state.copyWith(auShippingPrice: value));
  }

  Future<void> getDwpostFreight(int? id) async {
    final response = await repository.getDwpostFreight(id);

    response.fold((error) {
      debugPrint('getDwpostFreight error: ${error.toString()}');
    }, (data) {
      emit(state.copyWith(dataDwpost: data));
    });
  }

  /// PROMOTE
  void selectedBump(EnumPromoteBump value) {
    emit(state.copyWith(selectedBump: value));
  }

  /// OFFER
  void toogleOfferBuyNow(bool value) {
    emit(state.copyWith(isOfferBuyNow: value));
  }

  /// EARNING
  Future<void> getCommission(
    String? sellPrice,
    String? shippingPrice, {
    bool? isRental = false,
  }) async {
    final response = await repository.getCommission(
      sellPrice,
      shippingPrice,
      isRental: isRental,
    );

    response.fold((error) {
      debugPrint('getCommission error: ${error.toString()}');
    }, (data) {
      emit(state.copyWith(
        buyerPays: (data?.buyerPays ?? 0).toStringAsFixed(2),
        youllEarn: (data?.sellerMakes ?? 0).toStringAsFixed(2),
      ));
    });
  }

  Future<void> createListing({int? detailListingId}) async {
    try {
      emit(state.copyWith(fetchCreateStatus: ProgressStatus.inProgress));

      final obj = CreateListingModel(
        listingId: detailListingId != null ? detailListingId.toString() : '',
        title: state.title,
        brandId: state.brand?.id,
        categoryId: state.category?.id,
        conditionId: state.condition?.id,
        description: state.describle,
        sizeIds: state.sizes?.isNotEmpty ?? false
            ? state.sizes?.map((e) => e.id).join(',')
            : '""',
        colour: state.colours?.isNotEmpty ?? false
            ? state.colours?.map((e) => e.name).join(',')
            : '""',
        price: (state.sellingPrice?.isNotEmpty ?? false)
            ? state.sellingPrice
            : '0',
        priceRetail: (state.originalPrice?.isNotEmpty ?? false)
            ? state.originalPrice
            : '0',
        uploadIds: state.photos?.map((e) => e.uploadId).join(','),
        primaryImageId: state.photos?.isNotEmpty ?? false
            ? state.photos?.first.uploadId
            : null,
        listingSaleType: 'Sale',
        isVintage: false,
        enableBuyNowPayLater: state.isOfferBuyNow,
        shippingToAu: (state.auShippingPrice?.isNotEmpty ?? false)
            ? state.auShippingPrice
            : '0',
        shippingToNz: (state.nzShippingPrice?.isNotEmpty ?? false)
            ? state.nzShippingPrice
            : '0',
        listingItemVersion: 'v2',
      );

      final response = detailListingId != null
          ? await repository.editListing(obj)
          : await repository.createListing(obj);

      response.fold((error) {
        emit(state.copyWith(fetchCreateStatus: ProgressStatus.failure));
      }, (data) {
        clearListTempImg();
        emit(state.copyWith(fetchCreateStatus: ProgressStatus.success));
      });
    } on Exception catch (e) {
      emit(state.copyWith(fetchCreateStatus: ProgressStatus.failure));
      debugPrint('createListing error ${e.toString()}');
    }
  }

  Future<void> saveDraft({int? detailListingId}) async {
    try {
      emit(state.copyWith(fetchDraftStatus: ProgressStatus.inProgress));

      final obj = SaveDraftModel(
        listingId: detailListingId != null ? detailListingId.toString() : '',
        title: state.title,
        brandId: state.brand?.id,
        categoryId: state.category?.id,
        conditionId: state.condition?.id,
        sizeIds: state.sizes?.isNotEmpty ?? false
            ? state.sizes?.map((e) => e.id).join(',')
            : '""',
        colour: state.colours?.isNotEmpty ?? false
            ? state.colours?.map((e) => e.name).join(',')
            : '""',
        price: (state.sellingPrice?.isNotEmpty ?? false)
            ? state.sellingPrice
            : '0',
        uploadIds: state.photos?.map((e) => e.uploadId).join(','),
        primaryImageId: state.photos?.isNotEmpty ?? false
            ? state.photos?.first.uploadId
            : null,
        listingSaleType: 'Sale',
        isVintage: false,
        enableBuyNowPayLater: state.isOfferBuyNow,
        shippingToAu: (state.auShippingPrice?.isNotEmpty ?? false)
            ? state.auShippingPrice
            : '0',
        shippingToNz: (state.nzShippingPrice?.isNotEmpty ?? false)
            ? state.nzShippingPrice
            : '0',
        listingItemVersion: 'v2',
      );

      final response = await repository.saveDraft(obj);

      response.fold((error) {
        emit(state.copyWith(fetchDraftStatus: ProgressStatus.failure));
      }, (data) {
        clearListTempImg();
        emit(state.copyWith(fetchDraftStatus: ProgressStatus.success));
      });
    } on Exception catch (e) {
      emit(state.copyWith(fetchDraftStatus: ProgressStatus.failure));
      debugPrint('Save draft error ${e.toString()}');
    }
  }

  void clearError() {
    emit(state.copyWith(
      fetchCreateStatus: ProgressStatus.initial,
      fetchDraftStatus: ProgressStatus.initial,
    ));
  }

  @override
  Future<void> close() {
    super.emit(CreateListingState());
    return super.close();
  }
}
