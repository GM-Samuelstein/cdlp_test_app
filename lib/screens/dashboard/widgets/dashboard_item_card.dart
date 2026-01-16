import 'package:flutter/material.dart';

import 'status_chip.dart';

class DashboardItemCard extends StatelessWidget {
  const DashboardItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
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
          const SizedBox(height: 8),
          const Text(
            'Payment received for services rendered',
            style: TextStyle(color: Colors.black54, fontSize: 13),
          ),
          const SizedBox(height: 12),
          const Text(
            'Sep 18, 2025',
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
