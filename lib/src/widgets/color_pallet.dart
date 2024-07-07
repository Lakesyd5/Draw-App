import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorPallet extends HookWidget {
  const ColorPallet({
    super.key,
    required this.selectedColor,
  });

  final ValueNotifier<Color> selectedColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ColorContainer(
            color: Colors.red,
            onTap: () => selectedColor.value = Colors.red,
            selectedColor: selectedColor,
          ),
          ColorContainer(
            color: Colors.blue,
            onTap: () => selectedColor.value = Colors.blue,
            selectedColor: selectedColor,
          ),
          ColorContainer(
            color: Colors.yellow,
            onTap: () => selectedColor.value = Colors.yellow,
            selectedColor: selectedColor,
          ),
          ColorContainer(
            color: Colors.black,
            onTap: () => selectedColor.value = Colors.black,
            selectedColor: selectedColor,
          ),
          ColorContainer(
            color: Colors.purple,
            onTap: () => selectedColor.value = Colors.purple,
            selectedColor: selectedColor,
          ),
          ColorContainer(
            color: Colors.orange,
            onTap: () => selectedColor.value = Colors.orange,
            selectedColor: selectedColor,
          ),
          ColorContainer(
            color: Colors.grey,
            onTap: () => selectedColor.value = Colors.grey,
            selectedColor: selectedColor,
          ),
          ColorContainer(
            color: Colors.green,
            onTap: () => selectedColor.value = Colors.green,
            selectedColor: selectedColor,
          ),
        ],
      ),
    );
  }
}

class ColorContainer extends HookWidget {
  const ColorContainer({
    super.key,
    required this.color,
    required this.onTap,
    required this.selectedColor,
  });

  final Color color;
  final VoidCallback onTap;
  final ValueNotifier<Color> selectedColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20.h,
        width: 20.h,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedColor.value == color ? Colors.white : Colors.black,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
