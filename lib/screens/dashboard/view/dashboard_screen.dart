import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../_core_/app_widgets/loading_widget.dart';
import '../../../_core_/repositories/auth_repository.dart';
import '../view_model/dashboard_view_model.dart';
import '../widgets/post_item_card.dart';
import '../widgets/profile_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: ListenableBuilder(
        listenable: dashboardViewModel,
        builder: (context, child) {
          return RefreshIndicator(
            onRefresh: () async {
              await dashboardViewModel.fetchPosts();
            },
            child: Scaffold(
              backgroundColor: const Color(0xFFF5F7FA),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text(
                  'D A S H B O A R D',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.black87),
                    onPressed: () {
                      dashboardViewModel.logout(context);
                    },
                  ),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),

                    /// Profile Summary Card
                    ProfileCard(user: authRepository.loggedInUser),

                    SizedBox(height: 24.h),

                    /// Section Title
                    Text(
                      'Recent Posts',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    /// Items List
                    Expanded(
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: dashboardViewModel.posts.isEmpty
                            ? 1
                            : dashboardViewModel.posts.length,
                        separatorBuilder: (_, _) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          if (dashboardViewModel.isLoading) {
                            return LoadingWidget(
                              width: double.infinity,
                              height: 100.h,
                            );
                          }

                          if (dashboardViewModel.posts.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.h),
                              child: Center(
                                child: Text(
                                  'No posts available.\nPull down to refresh.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            );
                          }

                          final post = dashboardViewModel.posts[index];
                          return PostItemCard(post: post);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: dashboardViewModel.goToCreatePost,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
