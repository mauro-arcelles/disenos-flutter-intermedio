import 'package:disenos/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliverListScreen extends StatelessWidget {
  const SliverListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _Titulo(),
      body: Stack(
        children: const [
          _MainScroll(),
          Positioned(
            bottom: -10,
            right: 0,
            child: _BotonNewList(),
          ),
        ],
      ),
    );
  }
}

class _BotonNewList extends StatelessWidget {
  const _BotonNewList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Container(
      width: size.width * 0.9,
      height: 80,
      child: MaterialButton(
        onPressed: () {},
        color: appTheme == ThemeData.dark() ? appTheme.colorScheme.secondary : const Color(0xffED6762),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
        ),
        child: Text(
          'CREATE NEW LIST',
          style: TextStyle(
            color: appTheme.scaffoldBackgroundColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}

class _MainScroll extends StatelessWidget {
  final items = const [
    _ListItem(titulo: 'Orange', color: Color(0xffF08F66)),
    _ListItem(titulo: 'Family', color: Color(0xffF2A38A)),
    _ListItem(titulo: 'Subscriptions', color: Color(0xffF7CDD5)),
    _ListItem(titulo: 'Books', color: Color(0xffFCEBAF)),
    _ListItem(titulo: 'Orange', color: Color(0xffF08F66)),
    _ListItem(titulo: 'Family', color: Color(0xffF2A38A)),
    _ListItem(titulo: 'Subscriptions', color: Color(0xffF7CDD5)),
    _ListItem(titulo: 'Books', color: Color(0xffFCEBAF)),
    _ListItem(titulo: 'Orange', color: Color(0xffF08F66)),
    _ListItem(titulo: 'Family', color: Color(0xffF2A38A)),
    _ListItem(titulo: 'Subscriptions', color: Color(0xffF7CDD5)),
    _ListItem(titulo: 'Books', color: Color(0xffFCEBAF)),
    _ListItem(titulo: 'Orange', color: Color(0xffF08F66)),
    _ListItem(titulo: 'Family', color: Color(0xffF2A38A)),
    _ListItem(titulo: 'Subscriptions', color: Color(0xffF7CDD5)),
    _ListItem(titulo: 'Books', color: Color(0xffFCEBAF)),
  ];

  const _MainScroll({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return CustomScrollView(
      slivers: [
        // SliverAppBar(
        //   backgroundColor: Colors.red,
        // ),
        SliverPersistentHeader(
          floating: true,
          delegate: _SliverCustomHeaderDelegate(
            maxHeight: 170,
            minHeight: 200,
            child: Container(
              color: appTheme.scaffoldBackgroundColor,
              child: const _Titulo(),
            ),
          ),
        ),

        SliverList(
          delegate: SliverChildListDelegate([
            ...items,
            const SizedBox(
              height: 100,
            )
          ]),
        ),
      ],
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverCustomHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => minHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _SliverCustomHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}

class _Titulo extends StatelessWidget {
  const _Titulo({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30, width: double.infinity),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Text(
            'New',
            style: TextStyle(
              color: appTheme == ThemeData.dark() ? Colors.grey : const Color(0xff532128),
              fontSize: 50,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
            children: [
              const SizedBox(width: 100),
              Positioned(
                bottom: 8,
                child: Container(
                  width: 120,
                  height: 8,
                  color: appTheme == ThemeData.dark() ? Colors.grey : const Color(0xffF7CDD5),
                ),
              ),
              const Text('List', style: TextStyle(color: Color(0xffD93A30), fontSize: 50, fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final String titulo;
  final Color color;

  const _ListItem({
    Key? key,
    required this.titulo,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(30),
      height: 130,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: appTheme == ThemeData.dark() ? Colors.grey : color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        titulo,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
      ),
    );
  }
}
