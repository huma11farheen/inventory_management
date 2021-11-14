import 'package:flutter/material.dart';
import 'package:inventory_management/ui/home_page/custom_app_bar.dart';
import 'package:inventory_management/ui/list_details/supplier_page/supplier_list.dart';
import 'package:inventory_management/ui/raw_material/raw_material_history.dart';

import '../../colors.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final items = [
      ListItem(
          title: 'Home',
          icon: 'images/icons/home.jpg',
          onTap: () {
            Navigator.of(context).pop();
          }),
      ListItem(
        title: 'Setting',
        icon: 'images/icons/setting.jpg',
      ),
      ListItem(
        title: 'User_management',
        icon: 'images/icons/user_management.jpg',
      ),
      ListItem(
        title: 'List_details',
        icon: 'images/icons/list_details.jpg',
        subCategory: [
          ListItem(
              title: 'Suppliers',
              icon: null,
              onTap: () {
                Navigator.of(context)
                    .popAndPushNamed(SupplierListPage.routeName);
              }),
          ListItem(
            title: 'Buyers',
            icon: null,
          ),
          ListItem(
            title: 'Warehouse location',
            icon: null,
          ),
          ListItem(
            title: 'Goods',
            icon: null,
          ),
          ListItem(
            title: 'Machines',
            icon: null,
          ),
        ],
      ),
      ListItem(
        title: 'Purchase',
        icon: 'images/icons/purchase.jpg',
      ),
      ListItem(
          title: 'Raw Material',
          icon: 'images/icons/raw_material.jpg',
          onTap: () {
            Navigator.of(context).popAndPushNamed(RawMaterialHistory.routeName);
          }),
      ListItem(
        title: 'Production',
        icon: 'images/icons/production.jpg',
      ),
      ListItem(
        title: 'Goods',
        icon: 'images/icons/goods.jpg',
      ),
      ListItem(
        title: 'Printing',
        icon: 'images/icons/printing.jpg',
      ),
      ListItem(
        title: 'Wastage',
        icon: 'images/icons/wastage.jpg',
      ),
      ListItem(
        title: 'Shipment',
        icon: 'images/icons/shipment.jpg',
      ),
      ListItem(
        title: 'Logout',
        icon: 'images/icons/signout.jpg',
      ),
    ];
    final titleStyle =
        Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white);
    final extendedAppBarHeight = MediaQuery.of(context).size.height * 0.45;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: extendedAppBarHeight,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topRight,
                  radius: 1.5,
                  colors: <Color>[
                    Color(0xff33CEFF),
                    Color(0xff30AAFF),
                  ],
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final topPadding = MediaQuery.of(context).padding.top;

                  final maxVisibleAreaHeight =
                      extendedAppBarHeight + topPadding;
                  final headerHeight = kToolbarHeight + topPadding;
                  final centerTitleOpacity =
                      (constraints.maxHeight - headerHeight) /
                          (maxVisibleAreaHeight - headerHeight);

                  final headerFollowButtonOpacity = 1 - centerTitleOpacity;

                  final visibility = constraints.maxHeight > 56 + 86;
                  return Container(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Opacity(
                            opacity: centerTitleOpacity,
                            child: Visibility(
                              visible: visibility,
                              child: ScrollLane(
                                height: constraints.maxHeight,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: kBottomNavigationBarHeight - 8),
                            child: Opacity(
                              opacity: headerFollowButtonOpacity,
                              child: Text(
                                'Available Raw Material',
                                style: titleStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
        body: const Body(),
      ),
      drawer: Drawer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage("images/logo.jpg"),
                        fit: BoxFit.contain,
                      ),
                      shape: BoxShape.circle,
                    ),
                    height: 80,
                    width: 80,
                  ),
                  Text(
                    'BiteCope',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ]),
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.5,
                colors: <Color>[
                  Color(0xff33CEFF),
                  Color(0xff30AAFF),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return item.subCategory != null
                      ? ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: EdgeInsets.zero,
                          title: Text(item.title),
                          trailing: const Icon(Icons.keyboard_arrow_down),
                          leading: SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset(items[index].icon)),
                          children: item.subCategory
                              .map((e) => ListTile(
                                    contentPadding:
                                        const EdgeInsets.only(left: 64),
                                    title: Text(e.title),
                                    onTap: e.onTap ?? () {},
                                  ))
                              .toList(),
                        )
                      : ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(items[index].title),
                          onTap: item?.onTap ?? () {},
                          leading: SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset(items[index].icon)),
                        );
                },
                itemCount: items.length,
              ),
            ),
          )
        ],
      )),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final tableHeaderStyle =
        textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold);

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return ListTile(
                      title: Text(
                        'Goods',
                        style: tableHeaderStyle,
                      ),
                      trailing: Text(
                        'Quantity',
                        style: tableHeaderStyle,
                      ),
                    );
                  }
                  return Container(
                    color: index % 2 != 0 ? lightBlue : Colors.white,
                    child: ListTile(
                      title: Text('ITEM No.$index'),
                      trailing: Text(
                        '${index * 12333}',
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListItem {
  final String icon;
  final String title;
  final List<ListItem> subCategory;
  final VoidCallback onTap;

  ListItem(
      {this.onTap,
      @required this.icon,
      @required this.title,
      this.subCategory});
}
