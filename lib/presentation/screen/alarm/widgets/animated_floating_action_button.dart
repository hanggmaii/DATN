import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_color.dart';
import '../../../widget/app_touchable.dart';
import 'bubble_menu.dart';

class AnimatedFloatingActionButton extends AnimatedWidget {
  const AnimatedFloatingActionButton({
    super.key,
    required this.items,
    required this.onPress,
    this.backgroundCloseColor = AppColor.primaryColor,
    this.backgroundOpenColor = AppColor.white,
    required Animation animation,
    this.iconData,
    this.animatedIconData,
  }) : super(listenable: animation);

  final List<Bubble> items;
  final void Function() onPress;
  final AnimatedIconData? animatedIconData;
  final Widget? iconData;
  final Color backgroundCloseColor;
  final Color backgroundOpenColor;

  get _animation => listenable;

  Widget buildItem(BuildContext context, int index) {
    final transform = Matrix4.translationValues(
      0.0,
      0.0,
      0.0,
    );

    return Align(
      alignment: Alignment.centerRight,
      child: Transform(
        transform: transform,
        child: Opacity(
          opacity: _animation.value,
          child: BubbleMenu(items[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: _animation.value * MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColor.black.withOpacity(0.5),
        ),
        Transform.translate(
          offset: const Offset(
            0,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: IgnorePointer(
                  ignoring: _animation.value == 0,
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 12.0.sp,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List<Widget>.generate(
                        items.length,
                        (index) => buildItem(context, index),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 260),
                child: AppTouchable(
                  height: 60.0.sp,
                  width: 60.0.sp,
                  padding: EdgeInsets.all(12.0.sp),
                  margin: EdgeInsets.only(
                    top: 8.0.sp,
                    bottom: 24.0.sp,
                    right: 12.0.sp,
                  ),
                  backgroundColor: _animation.value == 0 ? backgroundCloseColor : backgroundOpenColor,
                  onPressed: onPress,
                  child: Icon(
                    _animation.value == 0 ? Icons.add_rounded : Icons.close_rounded,
                    color: _animation.value == 0 ? AppColor.white : AppColor.primaryColor,
                    size: 32.0.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
