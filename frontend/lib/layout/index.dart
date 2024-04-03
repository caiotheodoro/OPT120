import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/button/index.dart';
import 'package:sidebarx/sidebarx.dart';

class CommonLayout extends StatelessWidget {
  final String pageTitle;
  final List<Map<String, dynamic>> items;
  final Widget Function(BuildContext context, Map<String, dynamic> item)
      itemBuilder;
  final List<Widget> formFields;
  final Function() onSubmit;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  CommonLayout({
    super.key,
    required this.pageTitle,
    required this.items,
    required this.itemBuilder,
    required this.formFields,
    required this.onSubmit,
  });

  int getCurrentRoutePosition({BuildContext? context}) {
    const List<String> routes = [
      '/users',
      '/activity',
      '/user-activities',
    ];

    final currentRoute = ModalRoute.of(context!)!.settings.name;

    return routes.indexOf(currentRoute!);
  }

  @override
  Widget build(BuildContext context) {
    CustomButtonStyle cancelStyle = CustomButtonStyle(
      backgroundColor: Colors.white, // Example background color
      hoverColor: Colors.grey[200]!, // Example hover color
      borderColor: Colors.grey[350]!, // Example border color
      borderRadius: 8.0, // Example border radius
      padding: 10.0, // Example padding
    );

    CustomButtonStyle submitStyle = CustomButtonStyle(
      backgroundColor: const Color(0xFF178FFE), // Example background color
      hoverColor: const Color(0xFF27568E),
      borderColor: Colors.grey[350]!, // Example border color
      borderRadius: 8.0, // Example border radius
      padding: 10.0, // Example padding
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(pageTitle),
        elevation: 0,
        actions: const <Widget>[
          SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30.0),
          width: 800,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          child: DataTable(
            headingTextStyle: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontFamily: 'Inter',
            ),
            columns: items.first.keys
                .map((key) => DataColumn(label: Text(key.toUpperCase())))
                .toList(),
            rows: items
                .map((item) => DataRow(
                      cells: item.keys
                          .map((key) => DataCell(Text(item[key].toString())))
                          .toList(),
                    ))
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
        tooltip: 'Criar ${pageTitle.toLowerCase()}',
        child: const Icon(Icons.add),
      ),
      drawer: SidebarX(
        showToggleButton: false,
        controller: SidebarXController(
            selectedIndex: getCurrentRoutePosition(context: context)),
        items: [
          SidebarXItem(
            icon: Icons.verified_user,
            label: 'Usuarios',
            onTap: () {
              Navigator.of(context).pushNamed('/users');
            },
          ),
          SidebarXItem(
            icon: Icons.archive,
            label: 'Atividades',
            onTap: () {
              Navigator.of(context).pushNamed('/activity');
            },
          ),
          SidebarXItem(
            icon: Icons.supervised_user_circle_sharp,
            label: 'Atividades do usuario',
            onTap: () {
              Navigator.of(context).pushNamed('/user-activities');
            },
          ),
        ],
      ),
      endDrawer: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Drawer(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Registrar ${pageTitle.toLowerCase()}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ...formFields,
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: cancelStyle.getStyle(),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: onSubmit,
                          style: submitStyle.getStyle(),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Enviar',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
