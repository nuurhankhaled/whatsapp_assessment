import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/helpers/spacing.dart';
import 'package:whatsapp_assessment/features/chats/presentation/widgets/filter_container.dart';

class FiltersListViewWidget extends StatelessWidget {
  const FiltersListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return FilterContainer(filterIndex: index);
        },
        separatorBuilder: (context, index) {
          return horizontalSpace(8);
        },
        shrinkWrap: true,
        itemCount: 4,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
