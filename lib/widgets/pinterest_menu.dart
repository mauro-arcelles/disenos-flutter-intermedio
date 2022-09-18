import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final Function onPressed;
  final IconData icon;

  PinterestButton({
    required this.onPressed,
    required this.icon,
  });
}

class PinterestMenu extends StatelessWidget {
  final bool mostrar;

  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<PinterestButton> items;

  // final List<PinterestButton> items = [
  //   PinterestButton(
  //       onPressed: () {
  //         print('Icon pie_chart');
  //       },
  //       icon: Icons.pie_chart),
  //   PinterestButton(
  //       onPressed: () {
  //         print('Icon search');
  //       },
  //       icon: Icons.search),
  //   PinterestButton(
  //       onPressed: () {
  //         print('Icon notifications');
  //       },
  //       icon: Icons.notifications),
  //   PinterestButton(
  //       onPressed: () {
  //         print('Icon supervised_user_circle');
  //       },
  //       icon: Icons.supervised_user_circle)
  // ];

  const PinterestMenu({
    super.key,
    this.mostrar = true,
    this.backgroundColor = Colors.white,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.blueGrey,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(backgroundColor, activeColor, inactiveColor),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: (mostrar) ? 1 : 0,
        child: _PinterestMenuBackground(
          child: _MenuItems(menuItems: items),
        ),
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;

  const _PinterestMenuBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Provider.of<_MenuModel>(context).backgroundColor;

    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: -5,
          )
        ],
      ),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;

  const _MenuItems({
    super.key,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          menuItems.length,
          (index) => _PinterestMenuButton(
            index: index,
            item: menuItems[index],
          ),
        ),
      ),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  final int index;
  final PinterestButton item;

  const _PinterestMenuButton({
    super.key,
    required this.index,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final itemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;
    final activeColor = Provider.of<_MenuModel>(context).activeColor;
    final inactiveColor = Provider.of<_MenuModel>(context).inactiveColor;

    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).itemSeleccionado = index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Icon(
        item.icon,
        size: itemSeleccionado == index ? 35 : 25,
        color: itemSeleccionado == index ? activeColor : inactiveColor,
      ),
    );
  }
}

class _MenuModel extends ChangeNotifier {
  int _itemSeleccionado = 0;
  late Color _backgroundColor;
  late Color _activeColor;
  late Color _inactiveColor;

  int get itemSeleccionado => _itemSeleccionado;

  _MenuModel(backgroundColor, activeColor, inactiveColor) {
    _backgroundColor = backgroundColor;
    _activeColor = activeColor;
    _inactiveColor = inactiveColor;
  }

  set itemSeleccionado(int index) {
    _itemSeleccionado = index;
    notifyListeners();
  }

  Color get backgroundColor => _backgroundColor;

  Color get activeColor => _activeColor;

  Color get inactiveColor => _inactiveColor;
}
