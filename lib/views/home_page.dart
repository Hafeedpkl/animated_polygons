import 'dart:math';

import 'package:flutter/material.dart';
import 'package:animated_polygons/utils/shape_painter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;
  final Tween<double> _radiusTween = Tween(begin: 0.0, end: 200);
  final Tween<double> _rotationTween = Tween(begin: -pi, end: pi);
  Animation<double>? animation2;
  AnimationController? controller2;
  var _sides = 3.0;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    animation = _rotationTween.animate(controller!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller!.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller!.forward();
        }
      });
    animation2 = _radiusTween.animate(controller2!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2!.forward();
        }
      });
    controller!.forward();
    controller2!.forward();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: animation!,
            builder: (context, child) => CustomPaint(
              painter: ShapePainter(
                  sides: _sides,
                  radius: animation2!.value,
                  radians: animation!.value),
              child: Container(),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Text('Sides'),
        ),
        Slider(
          min: 3,
          max: 10,
          label: _sides.toInt().toString(),
          value: _sides,
          divisions: 7,
          onChanged: (value) {
            setState(() {
              _sides = value;
            });
          },
        )
      ],
    ));
  }
}
