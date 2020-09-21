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
import 'package:flutterboilerplate/localization.dart';
import 'package:website/data/colors_and_themes.dart';
import 'package:website/routes/contacts_route.dart';
import 'package:website/routes/home_route.dart';

/// The height of the background of the header
const _kHeaderHeight = 380.0;

/// A widget with the DistantQueue app logo and name, that, when clicked,
/// redirects to the home page.
class DistantQueueLogo extends StatelessWidget {
  final bool interactive;
  final bool onPrimary;

  DistantQueueLogo({
    Key key,
    this.interactive = false,
    this.onPrimary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = StringsLocalization.of(context);

    final color =
        onPrimary ? theme.colorScheme.onPrimary : theme.colorScheme.onSecondary;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(HomeRoute.routeName);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 36.0,
            height: 36.0,
            child: Image.asset('assets/images/customer.png'),
          ),
          Text(
            localization.getString('app_name'),
            style: theme.textTheme.caption.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// The button that redirects the user to the contacts route
class ContactsButton extends StatelessWidget {
  /// Whether the button will be displayed on the primary or on the
  /// secondary color.
  final bool onPrimary;

  ContactsButton({
    Key key,
    this.onPrimary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = StringsLocalization.of(context);

    final color =
        onPrimary ? theme.colorScheme.onPrimary : theme.colorScheme.onSecondary;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: FlatButton(
        textColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
        child: Text(localization.getString('contacts')),
        onPressed: () {
          Navigator.of(context).pushNamed(ContactsRoute.routeName);
        },
      ),
    );
  }
}

/// The widget to place at the top of a route, under the navigation bar
class RouteHeader extends StatelessWidget {
  /// The widget to place on the background at the bottom of the header
  final Widget child;

  RouteHeader({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final background = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: _kHeaderHeight,
          decoration: BoxDecoration(
            gradient: DistantQueueColors.primaryGradient,
          ),
        ),
      ],
    );

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: background,
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 48.0),
            child: child,
          ),
        ),
      ],
    );
  }
}
