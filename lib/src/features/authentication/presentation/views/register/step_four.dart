part of '../register/register_screen.dart';

class StepFour extends StatefulWidget {
  final List<GenericSize>? usualSizes;
  final List<GenericSize>? waistSizes;
  final List<GenericSize>? shoeSizes;

  const StepFour({
    required this.usualSizes,
    required this.waistSizes,
    required this.shoeSizes,
    super.key,
  });

  @override
  State<StepFour> createState() => _StepFourState();
}

class _StepFourState extends State<StepFour> {
  // final List<String> selected = [];
  bool isAlwaysFilter = true;
  final isAlwaysFilterController = SwitchController();

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return AppScaffold(
      backgroundColor: appColors.lavender,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            Text(
              "Your sizes",
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
                "Let us know your sizes to automatically filter by items that will fit you (optional).",
                style: AppStyles.of(context).copyWith(
                  fontSize: 14,
                  height: 18 / 14,
                  fontWeight: FontWeight.w400,
                  color: appColors.outerSpace,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "Always filter by my size",
                    style: AppStyles.of(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                CustomSwitch(
                  controller: isAlwaysFilterController,
                  onChanged: (value) {
                    isAlwaysFilterController.value = value;
                  },
                ),
                SizedBox(width: 16),
              ],
            ),
            _buildUsualSize(),
            _buildWaistSize(),
            _buildShoeSize(),
            const SizedBox(height: 100)
          ],
        ),
      ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 30),
          child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              final isActivated = (state.selectedUsualSizes?.isNotEmpty ?? false)
                || (state.selectedWaistSizes?.isNotEmpty ?? false)
                || (state.selectedShoeSizes?.isNotEmpty ?? false);
              return AppButton(
                title: 'Get Started',
                onPressed: !isActivated ? null : () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<RegisterCubit>().syncSize();
                },
                backgroundColor: isActivated
                    ? appColors.registerButtonColor
                    : appColors.registerUnactivatedButtonColor,
                textColor: appColors.registerTextButtonColor,
              );
            },
          ),
        )
    );
  }

  Widget _buildUsualSize() {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Container(
      margin: EdgeInsets.fromLTRB(16, 15, 16, 0),
      padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Clothing Size",
                  style: AppStyles.of(context).copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                "NZ / AU",
                style: AppStyles.of(context).copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: appColors.outerSpace,
                ),
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 11,
            childAspectRatio: 78 / 36,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 16),
            children: (widget.usualSizes ?? []).map((item) {
              return BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return _buildTag(
                    onPressed: () {
                      if (state.selectedUsualSizes?.contains(item) ?? false) {
                        state.selectedUsualSizes?.remove(item);
                      } else {
                        state.selectedUsualSizes?.add(item);
                      }
                      context.read<RegisterCubit>().updateSelectedUsualSizes(
                          state.selectedUsualSizes ?? []);
                    },
                    item,
                    isSelected: state.selectedUsualSizes?.contains(item) ??
                        false,
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWaistSize() {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Container(
      margin: EdgeInsets.fromLTRB(16, 15, 16, 0),
      padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Waist Size",
                  style: AppStyles.of(context).copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                "Inches",
                style: AppStyles.of(context).copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: appColors.outerSpace,
                ),
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 11,
            childAspectRatio: 78 / 36,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 16),
            children: (widget.waistSizes ?? []).map((item) {
              return BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return _buildTag(
                    onPressed: () {
                      if (state.selectedWaistSizes?.contains(item) ?? false) {
                        state.selectedWaistSizes?.remove(item);
                      } else {
                        state.selectedWaistSizes?.add(item);
                      }
                      context.read<RegisterCubit>().updateSelectedWaistSizes(
                          state.selectedWaistSizes ?? []);
                    },
                    item,
                    isSelected: state.selectedWaistSizes?.contains(item) ??
                        false,
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildShoeSize() {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Container(
      margin: EdgeInsets.fromLTRB(16, 15, 16, 0),
      padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Shoe Size",
                  style: AppStyles.of(context).copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                "US / EU",
                style: AppStyles.of(context).copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: appColors.outerSpace,
                ),
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 11,
            childAspectRatio: 78 / 36,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 16),
            children: (widget.shoeSizes ?? []).map((item) {
              return BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return _buildTag(
                    onPressed: () {
                      if (state.selectedShoeSizes?.contains(item) ?? false) {
                        state.selectedShoeSizes?.remove(item);
                      } else {
                        state.selectedShoeSizes?.add(item);
                      }
                      context.read<RegisterCubit>().updateSelectedShoeSizes(state.selectedShoeSizes ?? []);
                    },
                    item,
                    isSelected: state.selectedShoeSizes?.contains(item) ?? false,
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  ElevatedAppButton _buildTag(GenericSize item, {
    bool isSelected = false,
    required Function()? onPressed
  }) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return ElevatedAppButton(
      onPressed: onPressed,
      bgColor: Colors.white,
      padding: EdgeInsets.zero,
      radius: 5,
      child: AspectRatio(
        aspectRatio: 78 / 36,
        child: Container(
          alignment: Alignment.center,
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
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.5, color: appColors.silverSand),
          ),
          child: Text(
            '${item.genericSize} / ${item.altSize}',
            style: AppStyles.of(context).copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
