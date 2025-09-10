// ignore_for_file: must_be_immutable

import 'package:qwid/src/components/image/app_image.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:qwid/src/features/item_detail/presentation/cubit/item_detail_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionDetailItem extends StatelessWidget {
  QuestionDetailItem({super.key, required this.data});

  final ListingDetailResponseData? data;
  late AppColors? appColors;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    // TODO_(Quangdm): Need condition to show or not
    return BlocBuilder<ItemDetailCubit, ItemDetailState>(
      buildWhen: (previous, current) =>
          previous.dataQuestion != current.dataQuestion,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 17, 12, 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Questions & Answers',
                      style: AppStyles.of(context).copyWith(
                        color: appColors!.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '${state.dataQuestion?.data?.length ?? 0} ANSWERED'
                        .toUpperCase(),
                    style: AppStyles.of(context).copyWith(
                      color: appColors!.black,
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (state.dataQuestion?.data?.isNotEmpty ?? false)
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.dataQuestion?.data?.length ?? 0,
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => SizedBox(height: 16),
                  itemBuilder: (BuildContext context, int index) {
                    final question = state.dataQuestion?.data?[index];
                    return Column(
                      children: [
                        /// Question
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 42,
                              width: 42,
                              child: ClipOval(
                                child: AppImage(
                                    imageUrl:
                                        question?.user?.data?.profilePicture ??
                                            ''),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${question?.user?.data?.displayName}  ·  ${question?.updatedAt?.date != null ? DateFormat('MMMM d').format(question!.updatedAt!.date!) : ''}  · ${question?.updatedAt?.date != null ? DateFormat('h:mma').format(question!.updatedAt!.date!) : ''}',
                                        style: AppStyles.of(context).copyWith(
                                          color: appColors!.dimGray,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 6),
                                    padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
                                    decoration: BoxDecoration(
                                      color: appColors!.whiteSmoke,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      question?.question ?? '',
                                      style: AppStyles.of(context).copyWith(
                                        color: appColors!.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),

                        /// Answer
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${data?.user?.data?.displayName}  ·  ${question?.answer?.data?.updatedAt?.date != null ? DateFormat('MMMM d').format(question!.answer!.data!.updatedAt!.date!) : ''}  · ${question?.answer?.data?.updatedAt?.date != null ? DateFormat('h:mma').format(question!.answer!.data!.updatedAt!.date!) : ''}',
                                  style: AppStyles.of(context).copyWith(
                                    color: appColors!.dimGray,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 6),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 7, 10, 7),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xFFECEEFB),
                                              Color(0xFFFFBFF3),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          question?.answer?.data?.answer ?? '',
                                          style: AppStyles.of(context).copyWith(
                                            color: appColors!.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12),
                                SizedBox(
                                  height: 21,
                                  width: 21,
                                  child: ClipOval(
                                    child: AppImage(
                                        imageUrl:
                                            data?.user?.data?.profilePicture ??
                                                ''),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    );
                  },
                )
              else
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  alignment: Alignment.center,
                  child: Text(
                    'There are no questions on this listing yet - be the first to ask!',
                    style: AppStyles.of(context).copyWith(
                      color: appColors!.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
