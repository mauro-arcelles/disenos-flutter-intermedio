import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> children;
  final bool dotsUp;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryBullet;
  final double secondaryBullet;

  const Slideshow({
    super.key,
    required this.children,
    this.dotsUp = false,
    this.primaryColor = Colors.pink,
    this.secondaryColor = Colors.grey,
    this.primaryBullet = 12.0,
    this.secondaryBullet = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(primaryColor, secondaryColor, primaryBullet, secondaryBullet),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              if (dotsUp) _Dots(cantidad: children.length),
              Expanded(child: _Slides(slides: children)),
              if (!dotsUp) _Dots(cantidad: children.length),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int cantidad;

  const _Dots({
    super.key,
    required this.cantidad,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          cantidad,
          (index) => _Dot(index: index),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlideshowModel>(context);

    double tamano;
    Color color;

    if (ssModel.currentPage >= index - 0.5 && ssModel.currentPage < index + 0.5) {
      tamano = ssModel.primaryBullet;
      color = ssModel.primaryColor;
    } else {
      tamano = ssModel.secondaryBullet;
      color = ssModel.secondaryColor;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: tamano,
      height: tamano,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides({
    super.key,
    required this.slides,
  });

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      Provider.of<_SlideshowModel>(context, listen: false).currentPage = pageViewController.page!;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        children: widget.slides.map((slide) => _Slide(child: slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget child;

  const _Slide({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: child,
    );
  }
}

class _SlideshowModel extends ChangeNotifier {
  double _currentPage = 0;
  late Color _colorPrimario;
  late Color _colorSecundario;

  late double _primaryBullet;
  late double _secondaryBullet;

  _SlideshowModel(colorPrimario, colorSecundario, primaryBullet, secondaryBullet) {
    _colorPrimario = colorPrimario;
    _colorSecundario = colorSecundario;
    _primaryBullet = primaryBullet;
    _secondaryBullet = secondaryBullet;
  }

  double get currentPage => _currentPage;

  set currentPage(double currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  Color get primaryColor => _colorPrimario;

  set primaryColor(Color color) {
    _colorPrimario = color;
    notifyListeners();
  }

  Color get secondaryColor => _colorSecundario;

  set secondaryColor(Color color) {
    _colorSecundario = color;
    notifyListeners();
  }

  double get primaryBullet => _primaryBullet;

  set primaryBullet(double size) {
    _primaryBullet = size;
    notifyListeners();
  }

  double get secondaryBullet => _secondaryBullet;

  set secondaryBullet(double size) {
    _secondaryBullet = size;
    notifyListeners();
  }
}
