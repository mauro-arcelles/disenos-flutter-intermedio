import 'package:disenos/routes/routes.dart';
import 'package:disenos/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseños en Flutter'),
      ),
      drawer: _MenuPrincipal(),
      body: const _ListaOpciones(),
    );
  }
}

class _ListaOpciones extends StatelessWidget {
  const _ListaOpciones({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: pageRoutes.length,
      separatorBuilder: (context, i) => Divider(color: appTheme.primaryColorLight),
      itemBuilder: (context, i) => ListTile(
        leading: FaIcon(pageRoutes[i].icon, color: appTheme.colorScheme.secondary),
        title: Text(pageRoutes[i].titulo),
        trailing: Icon(Icons.chevron_right, color: appTheme.colorScheme.secondary),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[i].page));
        },
      ),
    );
  }
}

class _MenuPrincipal extends StatelessWidget {
  const _MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);

    return Drawer(
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                height: 200,
                child: CircleAvatar(
                  backgroundColor: appTheme.currentTheme.colorScheme.secondary,
                  child: const Text('AM', style: TextStyle(fontSize: 50)),
                ),
              ),
              const Expanded(
                child: _ListaOpciones(),
              ),
              ListTile(
                leading: Icon(Icons.lightbulb_outline, color: appTheme.currentTheme.colorScheme.secondary),
                title: const Text('Dark Mode'),
                trailing: Switch.adaptive(
                  value: appTheme.darkTheme,
                  activeColor: appTheme.currentTheme.colorScheme.secondary,
                  onChanged: (value) {
                    appTheme.darkTheme = value;
                  },
                ),
              ),
              SafeArea(
                bottom: true,
                top: false,
                left: false,
                right: false,
                child: ListTile(
                  leading: Icon(Icons.add_to_home_screen, color: appTheme.currentTheme.colorScheme.secondary),
                  title: const Text('Custom Theme'),
                  trailing: Switch.adaptive(
                    value: appTheme.customTheme,
                    activeColor: appTheme.currentTheme.colorScheme.secondary,
                    onChanged: (value) {
                      appTheme.customTheme = value;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
