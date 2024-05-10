import 'package:datn/presentation/widget/app_header.dart';
import 'package:flutter/material.dart';

import '../widget/app_container.dart';

class AllInsightScreen extends StatelessWidget {
  const AllInsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: "Insights",
          ),
          Expanded(child: ListView.builder(
            itemBuilder: (context, index) {
              return Container();
            },
          ))
        ],
      ),
    );
  }
}
