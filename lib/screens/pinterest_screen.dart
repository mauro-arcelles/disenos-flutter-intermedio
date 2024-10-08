import 'package:disenos/theme/theme.dart';
import 'package:disenos/widgets/pinterest_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PinterestScreen extends StatelessWidget {
  const PinterestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: Scaffold(
        // body: PinterestMenu(),
        body: Stack(
          children: const [
            PinterestGrid(),
            _PinterestMenuLocation(),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  const _PinterestMenuLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mostrar = Provider.of<_MenuModel>(context).mostrar;
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    int leftContainerWidth = 0;
    if (MediaQuery.of(context).size.width > 500) {

      leftContainerWidth = 300;
    }

    print(MediaQuery.of(context).size.width);

    return Positioned(
      bottom: 30,
      left: ((MediaQuery.of(context).size.width - leftContainerWidth) / 2) - (250 / 2),
      child: PinterestMenu(
        mostrar: mostrar,
        backgroundColor: appTheme.scaffoldBackgroundColor,
        activeColor: appTheme == ThemeData.dark() ? appTheme.colorScheme.secondary : Colors.red,
        // inactiveColor: Colors.white,
        items: [
          PinterestButton(onPressed: () {}, icon: Icons.pie_chart),
          PinterestButton(onPressed: () {}, icon: Icons.search),
          PinterestButton(onPressed: () {}, icon: Icons.notifications),
          PinterestButton(onPressed: () {}, icon: Icons.supervised_user_circle)
        ],
      ),
    );
  }
}

class PinterestGrid extends StatefulWidget {
  const PinterestGrid({super.key});

  @override
  State<PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List items = List.generate(200, (index) => index);
  ScrollController scrollController = ScrollController();
  double scrollAnterior = 0;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.offset > scrollAnterior && scrollAnterior > 0) {
        Provider.of<_MenuModel>(context, listen: false).mostrar = false;
      } else {
        Provider.of<_MenuModel>(context, listen: false).mostrar = true;
      }

      scrollAnterior = scrollController.offset;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count;
    if (MediaQuery.of(context).size.width > 500) {
      count = 3;
    } else {
      count = 2;
    }

    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      crossAxisCount: count,
      // mainAxisSpacing: 0,
      // crossAxisSpacing: 0,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _PinterestItem(index: index);
      },
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;

  const _PinterestItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: (index % 2 + 2) * 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('$index'),
        ),
      ),
    );
  }
}

class _MenuModel extends ChangeNotifier {
  bool _mostrar = true;

  bool get mostrar => _mostrar;

  set mostrar(bool value) {
    _mostrar = value;
    notifyListeners();
  }
}
