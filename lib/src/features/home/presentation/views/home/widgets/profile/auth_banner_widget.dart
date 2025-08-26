import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/components/dialog/signin_dialog.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBannerWidget extends StatelessWidget {
  const AuthBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return state.isSignedIn
                      ? SizedBox.shrink()
                      : ColoredBox(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Subtitle
                                const Text(
                                  "Sign in to access your Designer Wardrobe account",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Buttons Row
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              context.router
                                                  .push(RegisterScreenRoute());
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            child: const Text(
                                              "SIGN UP",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: SizedBox(
                                          height: 50,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              context.router
                                                  .push(SignInScreenRoute());
                                            },
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            child: const Text(
                                              "SIGN IN",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                },
              ),
              ColoredBox(
                color: Colors.transparent,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (context.read<AuthCubit>().state.isSignedIn) {
                          context.router
                              .push(CreateListingWrapperScreenRoute());
                        } else {
                          await showDialog(
                            context: context,
                            builder: (context) => SigninDialog(
                              title: 'Join DW',
                              subTitle:
                                  'Buy & sell pre-loved designer fashion! Join us now.',
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "LIST AN ITEM",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
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
}
