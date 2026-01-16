import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'status_chip.dart';

class DashboardItemCard extends StatelessWidget {
  const DashboardItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Transaction #2341',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              StatusChip(),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Payment received for services rendered',
            style: TextStyle(color: Colors.black54, fontSize: 13.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            'Sep 18, 2025',
            style: TextStyle(fontSize: 12.sp, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
