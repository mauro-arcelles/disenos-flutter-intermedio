import 'package:disenos/retos/cuadrado_animado_screen.dart';
import 'package:disenos/screens/emergency_screen.dart';
import 'package:disenos/screens/graficas_circulares_screen.dart';
import 'package:disenos/screens/headers_screen.dart';
import 'package:disenos/screens/pinterest_screen.dart';
import 'package:disenos/screens/slideshow_screen.dart';
import 'package:disenos/screens/sliver_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final pageRoutes = <_Route>[
  _Route(FontAwesomeIcons.slideshare, 'Slideshow', const SlideShowScreen()),
  _Route(FontAwesomeIcons.truckMedical, 'Emergencia', const EmergencyScreen()),
  _Route(FontAwesomeIcons.heading, 'Encabezados', const HeadersPage()),
  _Route(FontAwesomeIcons.peopleCarryBox, 'Cuadro Animado', const CuadradoAnimadoScreen()),
  _Route(FontAwesomeIcons.circleNotch, 'Barra Progreso', const GraficasCircularesScreen()),
  _Route(FontAwesomeIcons.pinterest, 'Pinterest', const PinterestScreen()),
  _Route(FontAwesomeIcons.mobile, 'Slivers', const SliverListScreen()),
];

class _Route {
  final IconData icon;
  final String titulo;
  final Widget page;

  _Route(this.icon, this.titulo, this.page);
}
