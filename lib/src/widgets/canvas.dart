import 'package:draw_app_test/src/models/drawing_mode.dart';
import 'package:draw_app_test/src/models/sketch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SketchCanvas extends HookWidget {
  final double height;
  final double width;
  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<double> strokeSize;
  final ValueNotifier<double> eraserSize;
  final ValueNotifier<DrawingMode> drawingMode;
  final ValueNotifier<Sketch?> currentSketch;
  final ValueNotifier<List<Sketch>> allSketches;

  const SketchCanvas({
    super.key,
    required this.height,
    required this.width,
    required this.selectedColor,
    required this.strokeSize,
    required this.eraserSize,
    required this.drawingMode,
    required this.currentSketch,
    required this.allSketches,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        sketchAllPaths(context),
        sketchCurrentPath(context),
      ],
    );
  }

  Widget sketchAllPaths(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        height: height,
        width: width,
        child: CustomPaint(
          painter: SketchPainter(
            sketches: allSketches.value,
          ),
        ),
      ),
    );
  }

  Widget sketchCurrentPath(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.globalToLocal(event.position);

        currentSketch.value = Sketch(
          points: [offset],
          color: drawingMode.value == DrawingMode.eraser
              ? const Color(0xfff2f3f7)
              : selectedColor.value,
          size: strokeSize.value,
        );
      },
      onPointerMove: (event) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.globalToLocal(event.position);

        final points = List<Offset>.from(currentSketch.value?.points ?? [])
          ..add(offset);
        currentSketch.value = Sketch(
          points: points,
          color: drawingMode.value == DrawingMode.eraser
              ? const Color(0xfff2f3f7)
              : selectedColor.value,
          size: strokeSize.value,
        );
      },
      onPointerUp: (event) {
        allSketches.value = List.from(allSketches.value)
          ..add(currentSketch.value!);
      },
      child: RepaintBoundary(
        child: SizedBox(
          height: height,
          width: width,
          child: CustomPaint(
            painter: SketchPainter(
              sketches:
                  currentSketch.value == null ? [] : [currentSketch.value!],
            ),
          ),
        ),
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<Sketch> sketches;

  SketchPainter({required this.sketches});

  @override
  void paint(Canvas canvas, Size size) {
    for (Sketch sketch in sketches) {
      final points = sketch.points;

      final path = Path();
      path.moveTo(points.first.dx, points.first.dy);

      for (int i = 1; i < points.length - 1; ++i) {
        final p0 = points[i];
        final p1 = points[i + 1];
        path.quadraticBezierTo(
          p0.dx,
          p0.dy,
          (p0.dx + p1.dx) / 2,
          (p0.dy + p1.dy) / 2,
        );
      }

      Paint paint = Paint()
        ..color = sketch.color
        ..strokeWidth = sketch.size
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
