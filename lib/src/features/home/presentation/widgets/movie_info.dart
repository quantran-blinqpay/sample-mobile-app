import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:designerwardrobe/src/components/button/text_button.dart';
import 'package:designerwardrobe/src/core/utils/datetime.dart';
import 'package:designerwardrobe/src/features/home/domain/models/movie.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/movie_selector_cubit.dart';

import '../../../../configs/app_themes/app_themes.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieSelectorCubit, MovieSelectorState>(
      buildWhen: (previous, current) => current is MovieSelectorSelected,
      builder: (context, state) {
        if (state is MovieSelectorSelected) {
          final appColors = Theme.of(context).extension<AppColors>();
          final data = state.movie;
          return Container(
            color: appColors?.black,
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _info(context, data),
                  _bookingButton(context, data)
                ]),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _info(BuildContext context, MovieModel movie) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        movie.name ?? '',
        style: AppStyles.of(context),
      ),
      Text(
        DateTimeUtil.formatDurationAndCinemaDate(
            durationInMinutes: movie.duration, dateTime: movie.startDate),
        style: AppStyles.of(context),
      )
    ]);
  }

  Widget _bookingButton(BuildContext context, MovieModel movie) {
    final appColors = Theme.of(context).extension<AppColors>();
    return CustomTextButton(
      border: Border.all(color: Colors.white, width: 1.5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      backgroundColor: appColors?.red,
      textStyle: AppStyles.of(context),
      text: 'home.button.booking'.tr(),
      onTap: () {},
    );
  }
}
