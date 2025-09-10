import 'dart:io';

import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:qwid/src/features/home/presentation/views/home/presenters/setting_presenter.dart';
import 'package:qwid/src/features/home/presentation/views/home/widgets/profile/setting_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ColoredBox(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SettingItemWidget(
                      onTap: () {},
                      item: SettingPresenter(
                          icon: icProfileSettings,
                          text: "Settings",
                          isNew: false)),
                ),
              ),
              ColoredBox(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    color: appColors!.silverSand,
                    height: 0.5,
                  ),
                ),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return ColoredBox(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SettingItemWidget(
                          onTap: (){
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text("Logout", style: AppStyles.of(context).copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),),
                                  content: Text("Are you sure you want to log out?",
                                    style: AppStyles.of(context).copyWith(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text("Cancel",
                                        style: AppStyles.of(context).copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      isDestructiveAction: true, // makes the button red
                                      child: Text("Log Out",
                                        style: AppStyles.of(context).copyWith(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                      onPressed: () {
                                        context.read<AuthCubit>().signOut();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          item: SettingPresenter(
                              icon: icProfileLogout,
                              text: "Log Out",
                              isNew: false)),
                    ),
                  );
                },
              ),
              ColoredBox(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    color: appColors.silverSand,
                    height: 0.5,
                  ),
                ),
              ),
              ColoredBox(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: FutureBuilder<String>(
                        future: getDeviceInfo(),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return const CircularProgressIndicator();
                            case ConnectionState.active:
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Text(
                                  snapshot.data ?? '',
                                  style: AppStyles.of(context).copyWith(
                                    color: appColors.manatee,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }
                          }
                        }),
                  ),
                ),
              )
            ],
          );
        },
        // Or, uncomment the following line:
        childCount: 1,
      ),
    );
  }

  Future<String> getDeviceInfo() async {
    return 'Version 1.0.5 (6)';
  }
}
