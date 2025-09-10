import 'package:auto_route/auto_route.dart';
import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/bottom_sheet/bottom_sheet.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/components/text_field/custom_text_field.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/core/network/response/enum/progress_status.dart';
import 'package:qwid/src/features/authentication/presentation/widgets/country_bottom_sheet.dart';
import 'package:qwid/src/features/payment/domain/repositories/payment_repository.dart';
import 'package:qwid/src/features/payment/presentation/bottomsheets/payment_address/address_input_field/address_input_field.dart';
import 'package:qwid/src/features/payment/presentation/bottomsheets/payment_address/payment_address_cubit.dart';
import 'package:qwid/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:qwid/src/features/payment/presentation/widgets/delivery_method/arrow_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentWrapperAddress extends StatelessWidget {
  const PaymentWrapperAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final localCountries = context.read<PaymentCubit>().state.localCountries;
    return MultiBlocProvider(
      providers: [
        BlocProvider<PaymentAddressCubit>(create: (context) => PaymentAddressCubit(
            di<PaymentRepository>())..loadLocalCountries(localCountries ?? [])),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<PaymentAddressCubit, PaymentAddressState>(
              listener: (context, state) {
                if(state.createAddressStatus == ProgressStatus.success) {
                  context.router.pop(state.addressResponse?.data);
                  _showMessage(message: 'Success!', context: context);
                } else if(state.createAddressStatus == ProgressStatus.failure) {
                  context.router.pop();
                  _showMessage(message: 'Creating an address has been failed!', context: context);
                }
                /// do something here
              }),
        ], child: PaymentAddress(),
      ),
    );
  }

  void _showMessage({required String message, required BuildContext context}) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}

class PaymentAddress extends StatefulWidget {
  const PaymentAddress({super.key});

  @override
  State<PaymentAddress> createState() => _PaymentAddressState();
}

class _PaymentAddressState extends State<PaymentAddress> {

  bool _showDeliveryInput = false;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: SizedBox(
              width: double.infinity,
              child: Text(
                'Add address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.all(5),
                icon: SvgPicture.asset(
                  Assets.svgs.icClose,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15),
              _buildCountry(context),
              SizedBox(height: 12),
              _buildFirstname(context),
              SizedBox(height: 12),
              _buildLastname(context),
              SizedBox(height: 12),
              _buildCompany(context),
              SizedBox(height: 12),
              _buildAddress(context),
              SizedBox(height: 12),
              _buildPhone(context),
              SizedBox(height: 12),
              !_showDeliveryInput
                  ? _buildCollapseDeliveryInstruction(context)
                  : _buildExpandDeliveryInstruction(context),
              GestureDetector(
                onTap: () {
                  context.router.pop();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Cancel',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: appColors.dimGray,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              BlocBuilder<PaymentAddressCubit, PaymentAddressState>(
                builder: (context, state) {
                  final validCountry = state.country != null;
                  final validFirstName = state.firstName?.isNotEmpty ?? false;
                  final validLastName = state.lastName?.isNotEmpty ?? false;
                  final validCompany = state.company?.isNotEmpty ?? false;
                  final validAddress = state.selectedAddress != null;
                  final validPhone = state.phone?.isNotEmpty ?? false;
                  bool isValid = validCountry && validFirstName && validLastName && validAddress;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: AppButton(
                      isLoading: state.createAddressStatus == ProgressStatus.inProgress,
                      title: 'Save address',
                      onPressed: !isValid ? null: () {
                        print('quanth: save address country: ${state.country?.countryName}');
                        print('quanth: save address firstName: ${state.firstName}');
                        print('quanth: save address lastName: ${state.lastName}');
                        print('quanth: save address company: ${state.company}');
                        print('quanth: save address address: ${state.address}');
                        print('quanth: save address phone: ${state.country?.phoneCode ?? ''}${state.phone ?? ''}');
                        context.read<PaymentAddressCubit>().createAddress();
                      },
                      backgroundColor: isValid ? appColors.black : appColors.black.withAlpha(80),
                      textColor: appColors.white,
                      radius: 5,
                    ),
                  );
                },
              ),
              SizedBox(height: 40,),
            ],
          ),
        ],
      ),
    );
  }

  final TextEditingController cityController = TextEditingController();
  Widget _buildCountry(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Country/Region',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: appColors.mediumGray,
            ),
          ),
          SizedBox(height: 9),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: appColors.silverSand),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: BlocBuilder<PaymentAddressCubit, PaymentAddressState>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        height: 50,
                        backgroundColor: Colors.transparent,
                        onTap: () async {
                          await showFMBS(
                            context: context,
                            builder: (builder) => CountryBottomSheet(
                              initialItem: state.country,
                              countries: state.localCountries ?? [],
                            ),
                          ).then(
                                (country) {
                              if (country != null) {
                                context.read<PaymentAddressCubit>().updateCountry(country);
                                cityController.text = country.countryName;
                              }
                            },
                          );
                        },
                        controller: cityController,
                        hintText: '',
                        readOnly: true,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: ArrowBox(isDown: true, color: Colors.transparent,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  final TextEditingController firstNameController = TextEditingController();
  Widget _buildFirstname(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'First name',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: appColors.mediumGray,
            ),
          ),
          SizedBox(height: 9),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: appColors.silverSand),
            ),
            child: CustomTextFormField(
              height: 50,
              controller: firstNameController,
              backgroundColor: Colors.transparent,
              keyboardType: TextInputType.name,
              hintText: '',
              onChanged: (text) {
                context.read<PaymentAddressCubit>().updateFirstName(text);
              },
            ),
          ),
        ],
      ),
    );
  }

  final TextEditingController lastNameController = TextEditingController();
  Widget _buildLastname(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last name',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: appColors.mediumGray,
            ),
          ),
          SizedBox(height: 9),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: appColors.silverSand),
            ),
            child: CustomTextFormField(
              height: 50,
              controller: lastNameController,
              backgroundColor: Colors.transparent,
              keyboardType: TextInputType.name,
              hintText: '',
              onChanged: (text) {
                context.read<PaymentAddressCubit>().updateLastName(text);
              },
            ),
          )
        ],
      ),
    );
  }

  final TextEditingController companyController = TextEditingController();
  Widget _buildCompany(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Company (Optional)',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: appColors.mediumGray,
            ),
          ),
          SizedBox(height: 9),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: appColors.silverSand),
            ),
            child: CustomTextFormField(
              height: 50,
              controller: companyController,
              backgroundColor: Colors.transparent,
              keyboardType: TextInputType.name,
              hintText: '',
              onChanged: (text) {
                context.read<PaymentAddressCubit>().updateCompany(text);
              },
            ),
          )
        ],
      ),
    );
  }

  final TextEditingController addressController = TextEditingController();
  Widget _buildAddress(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<PaymentAddressCubit, PaymentAddressState>(
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state.country == null,
          child: Opacity(
            opacity: state.country == null ? 0.5: 1.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start typing address...',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: appColors.mediumGray,
                    ),
                  ),
                  SizedBox(height: 9),
                  _buildSuggestion(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuggestion(BuildContext context){
    return AddressInputField(addressController: addressController);
  }

  final TextEditingController phoneController = TextEditingController();
  Widget _buildPhone(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phone (optional)',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: appColors.mediumGray,
            ),
          ),
          SizedBox(height: 9),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: appColors.silverSand),
            ),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: BlocBuilder<PaymentAddressCubit, PaymentAddressState>(
                      builder: (context, state) {
                        return Text(
                          state.country?.phoneCode ?? '--',
                          style: AppStyles.of(context).copyWith(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: CustomTextFormField(
                    backgroundColor: Colors.transparent,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    hintText: 'Enter phone number',
                    onChanged: (phone) {
                      context.read<PaymentAddressCubit>().updatePhone(phone);
                      // context.read<RegisterCubit>().validatePhone(phone);
                    },
                  ),
                ),
                BlocBuilder<PaymentAddressCubit, PaymentAddressState>(
                  builder: (context, state) {
                    return Text(
                      state.country?.flag ?? '',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 4.0),
                  child: ArrowBox(isDown: true, color: Colors.transparent,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCollapseDeliveryInstruction(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _showDeliveryInput = !_showDeliveryInput;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: const [
            Icon(Icons.add, size: 20),
            SizedBox(width: 12),
            Text(
              'Delivery instructions',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final TextEditingController deliveryController = TextEditingController();
  Widget _buildExpandDeliveryInstruction(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: appColors.silverSand),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, state) {
                  return CustomTextFormField(
                    backgroundColor: Colors.transparent,
                    controller: deliveryController,
                    hintText: 'Add delivery note...',
                    maxLines: 3,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(icEdge, width: 9, height: 9,),
            )
          ],
        ),
      ),
    );
  }
}