import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final porcentaje;
  final Color colorPrimario;

  const RadialProgress({
    super.key,
    required this.porcentaje,
    this.colorPrimario = Colors.blue,
  });

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late double porcentajeAnterior;

  @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;

    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward(from: 0.0);

    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _MiRadialProgress(
              (widget.porcentaje - diferenciaAnimar) + (diferenciaAnimar * animationController.value),
              widget.colorPrimario,
            ),
          ),
        );
      },
    );
  }
}

class _MiRadialProgress extends CustomPainter {
  final porcentaje;
  final Color colorPrimario;

  _MiRadialProgress(
    this.porcentaje,
    this.colorPrimario,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(
      center: const Offset(0, 0),
      radius: 180,
    );

    const Gradient gradiente = LinearGradient(
      colors: <Color>[
        Color(0xffC012FF),
        Color(0xff6D05E8),
        Colors.red,
      ],
    );

    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width * 0.5, size.height * 0.5);
    double radio = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radio, paint);

    // Arco
    final paintArco = Paint()
      ..strokeWidth = 10
      // ..color = colorPrimario
      ..shader = gradiente.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    double arcAngle = 2 * pi * (porcentaje / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radio),
      -pi / 2,
      arcAngle,
      false,
      paintArco,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
