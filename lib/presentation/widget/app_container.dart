import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_color.dart';

class AppContainer extends GetView {
  const AppContainer({
    super.key,
    this.appBar,
    this.onWillPop,
    this.bottomNavigationBar,
    this.child,
    this.backgroundColor,
    this.coverScreenWidget,
    this.resizeToAvoidBottomInset = false,
    this.floatingActionButton,
    this.showBanner = false,
    this.isCollapsible = true,
    this.leftPadding,
    this.rightPadding,
    this.bottomPadding,
    this.onPopInvoked,
  });

  final PreferredSizeWidget? appBar;
  final Future<bool> Function()? onWillPop;
  final Widget? bottomNavigationBar;
  final Widget? child;
  final Color? backgroundColor;
  final Widget? coverScreenWidget;
  final bool? resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final bool showBanner;
  final bool isCollapsible;
  final bool canWillPop = false;
  final PopInvokedCallback? onPopInvoked;
  final double? leftPadding;
  final double? rightPadding;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canWillPop,
      onPopInvoked: (didPop) {
        onPopInvoked?.call(didPop);
      },
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              backgroundColor: backgroundColor ?? AppColor.backgroundColor,
              appBar: appBar,
              body: SizedBox(
                width: Get.width,
                height: Get.height,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: leftPadding ?? 0,
                    right: rightPadding ?? 0,
                    bottom: MediaQuery.of(context).padding.bottom + (bottomPadding ?? 0),
                  ),
                  child: child ?? const SizedBox.shrink(),
                ),
              ),
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
            ),
          ),
          coverScreenWidget == null ? const SizedBox.shrink() : coverScreenWidget!,
        ],
      ),
    );
  }
}
