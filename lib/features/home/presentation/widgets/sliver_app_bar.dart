import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/core/widgets/search_widget.dart';
import 'package:whatsapp_assessment/features/home/presentation/widgets/tab_bar_config.dart';
import 'package:whatsapp_assessment/generated/translations/locale_keys.g.dart';

class HomeSliverAppBar extends StatelessWidget {
  final bool isCollapsed;
  final TabAppBarConfig config;
  final List<Text> titles;
  final int currentIndex;

  const HomeSliverAppBar({
    super.key,
    required this.isCollapsed,
    required this.config,
    required this.titles,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 153.0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      bottom: isCollapsed ? _buildBorder() : null,
      title: _buildTitle(context),
      flexibleSpace: _buildFlexibleSpace(context),
    );
  }

  PreferredSize _buildBorder() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.navBarBorder, width: 0.2),
          ),
        ),
        child: SizedBox(width: double.infinity, height: 0.2),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: Stack(
        children: [
          // Left widget
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Align(child: config.leftWidget ?? const SizedBox(width: 0)),
          ),
          // Right widgets
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: config.rightWidgets ?? [],
            ),
          ),
          // Title
          if (isCollapsed)
            Positioned(
              left: 45,
              right: 60,
              top: 0,
              bottom: 0,
              child: Transform.translate(
                offset: const Offset(10, 0),
                child: Center(
                  child: Text(
                    titles[currentIndex].data ?? '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 16.8,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFlexibleSpace(BuildContext context) {
    return FlexibleSpaceBar(
      titlePadding: EdgeInsets.zero,
      background: ColoredBox(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: kToolbarHeight - 10,
              bottom: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isCollapsed)
                  Text(
                    titles[currentIndex].data ?? '',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 33.3,
                    ),
                  ),
                if (!isCollapsed) const SizedBox(height: 10),
                if (!isCollapsed)
                  SearchWidget(
                    hintText: currentIndex == 3
                        ? tr(LocaleKeys.askMetaAIOrSearch)
                        : tr(LocaleKeys.search),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
