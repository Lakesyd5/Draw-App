import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:draw_app_test/src/models/drawing_mode.dart';

class BottomToolBar extends HookWidget {
  const BottomToolBar({
    super.key,
    required this.selectedColor,
    required this.showColorPallet,
    required this.showStrokeWidthSlider,
    required this.drawingMode,
  });

  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<bool> showColorPallet;
  final ValueNotifier<bool> showStrokeWidthSlider;
  final ValueNotifier<DrawingMode> drawingMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w).copyWith(bottom: 30.h),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildIconButton(
            icon: FontAwesomeIcons.pencil,
            size: 28,
            isSelected: drawingMode.value == DrawingMode.pencil,
            onTap: () {
              showColorPallet.value = false;
              showStrokeWidthSlider.value = true;
              drawingMode.value = DrawingMode.pencil;
            },
          ),
          buildIconButton(
            icon: FontAwesomeIcons.palette,
            size: 28,
            isSelected: drawingMode.value == DrawingMode.colorPalette,
            onTap: () {
              showStrokeWidthSlider.value = false;
              showColorPallet.value = true;
              drawingMode.value = DrawingMode.colorPalette;
            },
          ),
          buildIconButton(
            icon: FontAwesomeIcons.eraser,
            size: 28,
            isSelected: drawingMode.value == DrawingMode.eraser,
            onTap: () {
              drawingMode.value = DrawingMode.eraser;
              showStrokeWidthSlider.value = false;
              showColorPallet.value = false;
            },
          ),
        ],
      ),
    );
  }

  Widget buildIconButton({
    required IconData icon,
    required double size,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: isSelected ? 'Selected' : '',
        preferBelow: false,
        child: Container(
          padding: EdgeInsets.all(isSelected ? 5 : 0),
          decoration: isSelected
              ? BoxDecoration(
                  color: isSelected ? Colors.grey : null,
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: Icon(
            icon,
            size: size,
          ),
        ),
      ),
    );
  }
}
