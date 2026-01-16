import 'package:flutter/material.dart';

import '../widgets/dashboard_item_card.dart';
import '../widgets/profile_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            /// Profile Summary Card
            ProfileCard(),

            const SizedBox(height: 24),

            /// Section Title
            const Text(
              'Recent Items',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            /// Items List
            Expanded(
              child: ListView.separated(
                itemCount: 6,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return const DashboardItemCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
