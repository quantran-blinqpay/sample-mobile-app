part of '../register/register_screen.dart';

class StepThree extends StatefulWidget {
  final AppColors appColors;

  final TextEditingController searchController;

  final List<BrandTag> brandTags;

  const StepThree({
    required this.brandTags,
    required this.appColors,
    required this.searchController,
    super.key,
  });

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {

  @override
  void initState() {
    super.initState();
    context.read<RegisterCubit>().initIds(widget.brandTags..sort((a, b) => a.idx.compareTo(b.idx)));
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return AppScaffold(
          isLoading: state.batchUpdateFrequencyStatus == ProgressStatus.inProgress,
          backgroundColor: widget.appColors.lavender,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 12),
                Text(
                  "Favourite brands",
                  style: AppStyles.of(context).copyWith(
                    fontSize: 24,
                    height: 31 / 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Add your favourite brands to personalise your shopping experience.",
                    style: AppStyles.of(context).copyWith(
                      fontSize: 14,
                      height: 18 / 14,
                      fontWeight: FontWeight.w400,
                      color: widget.appColors.outerSpace,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (state.ids?.isNotEmpty ?? false)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 11,
                      children: [
                        for (final item in state.ids ?? [])
                          _buildTag(item,
                            onPressed: () {
                              /// ids
                              if (state.ids?.contains(item) ?? false) {
                                state.ids?.remove(item);
                              } else {
                                state.ids?.add(item);
                              }
                              context.read<RegisterCubit>().updateIds((state.ids ?? [])..sort((a, b) => a.idx.compareTo(b.idx)));
                              /// original
                              if (state.originalIds?.contains(item) ?? false) {
                                state.originalIds?.remove(item);
                              } else {
                                state.originalIds?.add(item);
                              }
                              context.read<RegisterCubit>().updateOriginalIds((state.originalIds ?? [])..sort((a, b) => a.idx.compareTo(b.idx)));
                            },
                            isSelected: true,
                          )
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: CustomTextFormField(
                    height: 40,
                    controller: widget.searchController,
                    hintText: 'Search brands',
                    prefixIcon: Container(
                      width: 12,
                      height: 12,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        Assets.svgs.icSearch2,
                      ),
                    ),
                    shape: ShapeTextFieldButton.circle,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Recommended",
                  style: AppStyles.of(context).copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                if (state.originalIds?.isNotEmpty ?? false)
                  Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10,
                    runSpacing: 11,
                    children: [
                      for (final item in state.originalIds ?? [])
                        _buildTag(item,
                          onPressed: () {
                            /// ids
                            if (state.ids?.contains(item) ?? false) {
                              state.ids?.remove(item);
                            } else {
                              state.ids?.add(item);
                            }
                            context.read<RegisterCubit>().updateIds((state.ids ?? [])..sort((a, b) => a.idx.compareTo(b.idx)));
                            /// original
                            if (state.originalIds?.contains(item) ?? false) {
                              state.originalIds?.remove(item);
                            } else {
                              state.originalIds?.add(item);
                            }
                            context.read<RegisterCubit>().updateOriginalIds((state.originalIds ?? [])..sort((a, b) => a.idx.compareTo(b.idx)));
                          },
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 30),
            child: BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                final isActivated = (state.ids?.isNotEmpty ?? false);
                return AppButton(
                  title: 'Save Brand',
                  onPressed: !isActivated ? null : () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await showFMBS(
                      context: context,
                      builder: (builder) =>
                          NotificationPreferencesBottomSheet(
                            initialItem: state.frequency,
                            countries: ['Daily', 'Weekly', 'Never'],
                          ),
                    ).then((frequency) {
                      debugPrint('quanth: frequency = ${frequency}');
                      if (frequency != null) {
                        context.read<RegisterCubit>().updateFrequency(frequency);
                        context.read<RegisterCubit>().batchUpdateFrequency();
                      }
                    });
                  },
                  backgroundColor: isActivated
                      ? appColors.registerButtonColor
                      : appColors.registerUnactivatedButtonColor,
                  textColor: appColors.registerTextButtonColor,
                );
              },
            ),
          ),
        );
      },
    );
  }

  ElevatedAppButton _buildTag(BrandTag item, {
    required Function()? onPressed,
    bool isSelected = false,
  }) {
    return ElevatedAppButton(
      onPressed: onPressed,
      bgColor: Colors.white,
      padding: EdgeInsets.zero,
      radius: 80,
      child: Container(
        padding: EdgeInsets.fromLTRB(14, 13, 14, 13),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFFC7AD),
              Color(0xFFFFC0EF),
            ],
          )
              : null,
          borderRadius: BorderRadius.circular(80),
          border: Border.all(width: 0.8, color: widget.appColors.platinum),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.name,
              style: AppStyles.of(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 16),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : widget.appColors.lavender,
              ),
              child: Icon(
                isSelected ? Icons.close : Icons.add,
                color: Colors.black,
                size: isSelected ? 12 : 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
