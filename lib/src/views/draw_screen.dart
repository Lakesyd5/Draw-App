import 'package:draw_app_test/src/models/drawing_mode.dart';
import 'package:draw_app_test/src/models/sketch.dart';
import 'package:draw_app_test/src/widgets/bottom_tool_bar.dart';
import 'package:draw_app_test/src/widgets/canvas.dart';
import 'package:draw_app_test/src/widgets/color_pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DrawScreen extends HookWidget {
  const DrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final showColorPallet = useState<bool>(false);
    final showStrokeWidthSlider = useState<bool>(false);

    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xfff2f3f7),
            child: SketchCanvas(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              selectedColor: selectedColor,
              strokeSize: strokeSize,
              eraserSize: eraserSize,
              currentSketch: currentSketch,
              allSketches: allSketches,
              drawingMode: drawingMode,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomToolBar(
              selectedColor: selectedColor,
              showColorPallet: showColorPallet,
              showStrokeWidthSlider: showStrokeWidthSlider,
              drawingMode: drawingMode,
            ),
          ),
          Visibility(
            visible: showColorPallet.value,
            child: Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: ColorPallet(selectedColor: selectedColor),
            ),
          ),
          Visibility(
            visible: showStrokeWidthSlider.value,
            child: Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Slider(
                value: strokeSize.value,
                min: 0,
                max: 50,
                activeColor: selectedColor.value,
                onChanged: (val) {
                  strokeSize.value = val;
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
