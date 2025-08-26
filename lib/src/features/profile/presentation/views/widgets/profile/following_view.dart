import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';

class FollowingView extends StatelessWidget {
  FollowingView({super.key});

  final List<Map<String, String>> users = [
    {
      'name': 'Aidan B',
      'username': '@designerwardrobe',
      'avatar':
          'https://i0.wp.com/studiolorier.com/wp-content/uploads/2018/10/Profile-Round-Sander-Lorier.jpg?ssl=1', // Replace with your image URL
    },
    {
      'name': 'Ellie C',
      'username': '@elliec',
      'avatar':
          'https://images.squarespace-cdn.com/content/v1/58e167a8414fb5c0b2b8c13e/1503561540900-K0FXVM3QNP4843AJGQCD/Circle+Profile.jpg', // Replace with your image URL
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.separated(
        itemCount: users.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final user = users[index];
          return Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(user['avatar']!),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name']!,
                        style: AppStyles.of(context)
                            .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Text(
                        user['username']!,
                        style: AppStyles.of(context).copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.red[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
