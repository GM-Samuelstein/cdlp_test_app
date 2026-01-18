import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../_core_/models/post_model.dart';
import '../../../_core_/services/navigation_service/navigation_service.dart';
import '../view_model/dashboard_view_model.dart';

class PostItemCard extends StatelessWidget {
  final PostModel post;

  const PostItemCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dashboardViewModel.setSelectedPost(post);
        navigationService.navigateTo(
          destinationScreen: AppRoutes.postDetailsScreen,
        );
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.title, style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(
                post.body.length > 60
                    ? '${post.body.substring(0, 60)}...'
                    : post.body,
                style: TextStyle(color: Colors.black54, fontSize: 13.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
