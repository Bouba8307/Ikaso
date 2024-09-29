import 'package:flutter/material.dart';
import 'package:ikaso/Admin/view/dashboard/header.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [Header()],
        ),
      ),
    );
  }
}
