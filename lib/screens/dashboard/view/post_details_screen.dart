import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view_model/dashboard_view_model.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: dashboardViewModel,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              'P O S T  D E T A I L S',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.black87),
                onPressed: () {
                  dashboardViewModel.goToEditPost();
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dashboardViewModel.selectedPost?.title ?? "",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    dashboardViewModel.selectedPost?.body ?? "",
                    style: TextStyle(color: Colors.black54, fontSize: 13.sp),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
