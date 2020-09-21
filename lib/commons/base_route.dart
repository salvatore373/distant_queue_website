/*
 * "DistantQueue - website": A website to explain the DistantQueue service to customers
 * Copyright (C) 2020  Salvatore Michele Rago
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutterboilerplate/dimens_const.dart';
import 'package:flutterboilerplate/localization.dart';
import 'package:footer/footer.dart' as FooterViewFooter;
import 'package:footer/footer_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website/commons/utils.dart';
import 'package:website/commons/widgets.dart';
import 'package:website/data/colors_and_themes.dart';
import 'package:website/routes/contacts_route.dart';
import 'package:website/routes/for_businesses_route.dart';
import 'package:website/routes/for_customers_route.dart';

/// The items of the menu button
enum _MenuButtonItems {
  forBusinesses,
  forCustomers,
  contact,
}

/// The widget to place at the bottom of the web page
class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = StringsLocalization.of(context);

    final copyright = Text(
      localization.getString('copyright_text'),
      style: theme.textTheme.caption,
    );

    final creatorSpan = Text.rich(
      TextSpan(
        text: '${localization.getString('creator_credit')} ',
        children: [
          WidgetSpan(
            child: InkWell(
              onTap: () {
                launch('https://github.com/salvatore373/distantqueue_website');
              },
              child: Text(
                localization.getString('and_hosted_on_github'),
                style: theme.textTheme.caption.copyWith(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
      style: theme.textTheme.caption.copyWith(fontWeight: FontWeight.bold),
    );

    return Container(
      constraints: BoxConstraints.expand(height: 144.0),
      decoration: BoxDecoration(gradient: DistantQueueColors.primaryGradient),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DistantQueueLogo(),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: copyright,
          ),
          Padding(
            padding: CommonDimensions.topDividerPadding,
            child: creatorSpan,
          ),
        ],
      ),
    );
  }
}

/// The top bar to navigate in the site
class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = StringsLocalization.of(context);

    Widget navigationButtons;
    if (getScreenSize(context) == ScreenSizes.small) {
      // The application is running on a small screen, then display only a
      // menu button
      navigationButtons = PopupMenuButton(
        child: Icon(Icons.menu),
        onSelected: (_MenuButtonItems selectedItem) {
          final navigator = Navigator.of(context);
          switch (selectedItem) {
            case _MenuButtonItems.forBusinesses:
              navigator.pushNamed(ForBusinessesRoute.routeName);
              break;
            case _MenuButtonItems.forCustomers:
              navigator.pushNamed(ForCustomersRoute.routeName);
              break;
            case _MenuButtonItems.contact:
              navigator.pushNamed(ContactsRoute.routeName);
              break;
          }
        },
        itemBuilder: (context) => <PopupMenuEntry<_MenuButtonItems>>[
          PopupMenuItem<_MenuButtonItems>(
            value: _MenuButtonItems.forBusinesses,
            child: Text(localization.getString('for_businesses')),
          ),
          PopupMenuItem<_MenuButtonItems>(
            value: _MenuButtonItems.forCustomers,
            child: Text(localization.getString('for_customers')),
          ),
          PopupMenuItem<_MenuButtonItems>(
            value: _MenuButtonItems.contact,
            child: Text(localization.getString('contacts')),
          ),
        ],
      );
    } else {
      // The application is running on a bug screen, then display all the
      // navigation buttons.
      navigationButtons = Row(
        children: [
          FlatButton(
            child: Text(localization.getString('for_businesses')),
            onPressed: () {
              Navigator.of(context).pushNamed(ForBusinessesRoute.routeName);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 56.0),
            child: FlatButton(
              child: Text(localization.getString('for_customers')),
              onPressed: () {
                Navigator.of(context).pushNamed(ForCustomersRoute.routeName);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 56.0),
            child: ContactsButton(),
          ),
        ],
      );
    }

    return Container(
      padding: CommonDimensions.largeOverallPadding,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DistantQueueLogo(),
            Padding(
              padding: CommonDimensions.leftDividerPadding,
              child: navigationButtons,
            ),
          ],
        ),
      ),
    );
  }
}

/// The base structure of a route in this app
class BaseRoute extends StatefulWidget {
  /// The content of this route
  final Widget child;

  BaseRoute({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  _BaseRouteState createState() => _BaseRouteState();
}

class _BaseRouteState extends State<BaseRoute> {
  ThemeData _theme;

  @override
  void didChangeDependencies() {
    _theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final navigationBarStack = Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: widget.child,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: NavigationBar(),
        ),
      ],
    );

    final content = FooterView(
      flex: 10,
      children: [navigationBarStack],
      footer: FooterViewFooter.Footer(
        child: Footer(),
        padding: const EdgeInsets.all(0.0),
      ),
    );

    return WillPopScope(
      // Disable the drag to navigate back
      onWillPop: () async => false,
      child: Scaffold(
        body: NeumorphicTheme(
          theme: NeumorphicThemeData(
            baseColor: _theme.colorScheme.secondary,
            variantColor: _theme.colorScheme.secondaryVariant,
          ),
          child: content,
        ),
      ),
    );
  }
}
