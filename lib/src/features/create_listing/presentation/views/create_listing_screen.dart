// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/dialog/custom_dialog.dart';
import 'package:qwid/src/components/divider/custom_divider.dart';
import 'package:qwid/src/components/form/app_form.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/core/network/response/enum/progress_status.dart';
import 'package:qwid/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:qwid/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:qwid/src/features/create_listing/presentation/views/create_add_photo.dart';
import 'package:qwid/src/features/create_listing/presentation/views/create_description.dart';
import 'package:qwid/src/features/create_listing/presentation/views/create_earning.dart';
import 'package:qwid/src/features/create_listing/presentation/views/create_item_info.dart';
import 'package:qwid/src/features/create_listing/presentation/views/create_listing_wrapper_screen.dart';
import 'package:qwid/src/features/create_listing/presentation/views/create_offer.dart';
import 'package:qwid/src/features/create_listing/presentation/views/create_price.dart';
import 'package:qwid/src/features/create_listing/presentation/views/create_promote.dart';
import 'package:qwid/src/features/create_listing/presentation/views/create_shipping.dart';
import 'package:qwid/src/features/helper/cubit/helper_cubit.dart';
import 'package:qwid/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:gif/gif.dart';

@RoutePage(name: createListingScreenName)
class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen>
    with TickerProviderStateMixin {
  ListingDetailResponseData? dataDetail;
  late AppColors appColors;
  final _formKey = GlobalKey<AppFormState>();
  final GlobalKey _photosKey = GlobalKey();
  bool _hasInteracted = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController describeController = TextEditingController();
  final TextEditingController departmentController =
      TextEditingController(text: 'Women');
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController subCategoryController = TextEditingController();
  final TextEditingController secondCategoryController =
      TextEditingController();

  final TextEditingController brandController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController colourController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();

  late FocusNode sellingPriceFocusNode;
  final TextEditingController sellController = TextEditingController();
  final TextEditingController originalController = TextEditingController();

  final TextEditingController nzController = TextEditingController();
  final TextEditingController auController = TextEditingController();

  late final GifController gifController;
  late final GifController gifHighlightController;

  @override
  void initState() {
    super.initState();
    final wrapper =
        context.findAncestorWidgetOfExactType<CreateListingWrapperScreen>();
    if (wrapper?.dataDetail != null) {
      dataDetail = wrapper?.dataDetail;
    }

    gifController = GifController(vsync: this);
    gifHighlightController = GifController(vsync: this);
    sellingPriceFocusNode = FocusNode();

    final isFromAud = context.read<AuthCubit>().state.isFromAud ?? false;
    final dataSiteSetting = GetIt.instance<HelperCubit>().state.siteSetting;
    auController.text = isFromAud
        ? '10.00'
        : (dataSiteSetting
                    ?.global?.defaultShippingFee?.defaultNzToAuFeeForNzUser ??
                0)
            .toStringAsFixed(2);
    nzController.text = isFromAud ? '20.00' : '';
  }

  @override
  void dispose() {
    gifController.dispose();
    gifHighlightController.dispose();
    sellingPriceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>()!;

    return BlocConsumer<CreateListingCubit, CreateListingState>(
      listener: (context, state) {
        if (state.fetchCreateStatus == ProgressStatus.success) {
          // TODO_quangdm navigate to My Account > My Listings > For sale and show dialog
          context.router.maybePop(true);
          _showMessage(
            message: 'Your item has been successfully listed.',
            context: context,
          );
        } else if (state.fetchDraftStatus == ProgressStatus.success) {
          // TODO_quangdm navigate to My Account > My Listings > Draft / Sell Later
          context.router.maybePop(true);
        } else if (state.fetchCreateStatus == ProgressStatus.failure ||
            state.fetchDraftStatus == ProgressStatus.failure) {
          context.read<CreateListingCubit>().clearError();
          CustomDialog.showConfirmDialog(
            context,
            title: 'Something went wrong.',
            positiveText: 'OK',
            positiveColor: appColors.vividBlue,
            onlyConfirmButton: true,
          );
        }
      },
      builder: (context, state) {
        return AppScaffold(
          backgroundColor: appColors.white,
          isLoading: state.fetchCreateStatus == ProgressStatus.inProgress ||
              state.fetchDraftStatus == ProgressStatus.inProgress,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(48.5),
            child: Column(
              children: [
                AppBar(
                  leading: IconButton(
                    padding: EdgeInsets.all(5),
                    icon: SvgPicture.asset(
                      Assets.svgs.icArrowBack,
                      width: 18,
                      height: 18,
                      colorFilter: ColorFilter.mode(
                        appColors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () => context.router.maybePop(),
                  ),
                  toolbarHeight: 48,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  title: Text(
                    dataDetail != null ? 'FINISH EDITING' : 'SELL AN ITEM',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 18,
                      height: 13 / 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                CustomDivider(),
              ],
            ),
          ),
          body: SingleChildScrollView(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: AppForm(
              key: _formKey,
              autovalidateMode: _hasInteracted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ADD PHOTOS
                  SizedBox(key: _photosKey, child: CreateAddPhoto()),
                  CustomDivider(thickness: 3),

                  /// DESCRIPTION
                  CreateDescription(
                    titleController: titleController,
                    describeController: describeController,
                    departmentController: departmentController,
                    categoryController: categoryController,
                    subCategoryController: subCategoryController,
                    secondSubCategoryController: secondCategoryController,
                  ),
                  CustomDivider(thickness: 3),

                  /// ITEM INFO
                  CreateItemInfo(
                    brandController: brandController,
                    sizeController: sizeController,
                    colourController: colourController,
                    conditionController: conditionController,
                  ),
                  CustomDivider(thickness: 3),

                  /// PRICE
                  CreatePrice(
                    sellController: sellController,
                    originalController: originalController,
                    focusNode: sellingPriceFocusNode,
                  ),
                  CustomDivider(thickness: 3),

                  /// SHIPPING
                  CreateShipping(
                    nzController: nzController,
                    auController: auController,
                  ),
                  CustomDivider(thickness: 3),

                  /// PROMOTE
                  if (state.category?.id != null && dataDetail == null) ...[
                    CreatePromote(
                      gifController: gifController,
                      gifHighlightController: gifHighlightController,
                    ),
                    CustomDivider(thickness: 3),
                  ],

                  /// OFFER
                  CreateOffer(),
                  CustomDivider(thickness: 3),

                  /// EARNING
                  CreateEarning(
                    onCreateListing: () async {
                      await _onSubmit(context, state, false);
                    },
                    onSaveDraft: () async {
                      await _onSubmit(context, state, true);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onSubmit(
    BuildContext context,
    CreateListingState state,
    bool isDraft,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_hasInteracted) {
      setState(() {
        _hasInteracted = true;
      });
    }

    if (state.photos?.isEmpty ?? true) {
      if (_photosKey.currentContext != null) {
        context.read<CreateListingCubit>().updatePhotoValid(false);

        Scrollable.ensureVisible(
          _photosKey.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        return;
      }
    }

    if (_formKey.currentState!.validate()) {
      if (isDraft) {
        context
            .read<CreateListingCubit>()
            .saveDraft(detailListingId: dataDetail?.id);
      } else {
        context
            .read<CreateListingCubit>()
            .createListing(detailListingId: dataDetail?.id);
      }
    } else {
      final invalidFields = _formKey.currentState?.getInvalidFields();

      if (invalidFields != null) {
        await Scrollable.ensureVisible(
          invalidFields.first.context,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _showMessage({required String message, required BuildContext context}) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
