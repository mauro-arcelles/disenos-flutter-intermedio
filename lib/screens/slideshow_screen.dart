import 'package:disenos/theme/theme.dart';
import 'package:disenos/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SlideShowScreen extends StatelessWidget {
  const SlideShowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLarge;

    if (MediaQuery.of(context).size.height > 500) {
      isLarge = true;
    } else {
      isLarge = false;
    }

    const children = [
      Expanded(child: CustomSlideshow()),
      Expanded(child: CustomSlideshow()),
    ];

    return Scaffold(
      body: isLarge ? Column(children: children) : Row(children: children),
    );
  }
}

class CustomSlideshow extends StatelessWidget {
  const CustomSlideshow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);

    return Slideshow(
      primaryBullet: 15,
      secondaryBullet: 12,
      // dotsUp: true,
      primaryColor: appTheme.currentTheme == ThemeData.dark() ? appTheme.currentTheme.colorScheme.secondary : Colors.pink,
      // secondaryColor: Colors.green,
      children: [
        SvgPicture.asset('assets/svgs/slide-1.svg'),
        SvgPicture.asset('assets/svgs/slide-2.svg'),
        SvgPicture.asset('assets/svgs/slide-3.svg'),
        SvgPicture.asset('assets/svgs/slide-4.svg'),
        SvgPicture.asset('assets/svgs/slide-5.svg'),
      ],
    );
  }
}
