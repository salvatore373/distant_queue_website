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

import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterboilerplate/localization.dart';
import 'package:website/routes/contacts_route.dart';
import 'package:website/routes/for_businesses_route.dart';
import 'package:website/routes/for_customers_route.dart';
import 'package:website/routes/home_route.dart';

import 'data/colors_and_themes.dart';
import 'data/localized_strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DistantQueue',
      navigatorObservers: [AnalyticsRouteObserver(analytics: analytics())],
      localizationsDelegates: [
        StringsLocalizationDelegate(Strings.localizedValues),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('it'), // Italian
      ],
      theme: ThemeData(
        colorScheme: DistantQueueColors.colorScheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        popupMenuTheme: DistantQueueThemes.popupMenuButtonTheme,
      ),
      routes: {
        HomeRoute.routeName: (context) => HomeRoute(),
        ForBusinessesRoute.routeName: (context) => ForBusinessesRoute(),
        ForCustomersRoute.routeName: (context) => ForCustomersRoute(),
        ContactsRoute.routeName: (context) => ContactsRoute(),
      },
      initialRoute: HomeRoute.routeName,
    );
  }
}

class AnalyticsRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final Analytics analytics;

  AnalyticsRouteObserver({required this.analytics});

  void _sendPageView(PageRoute<dynamic> route) {
    var pageName = route.settings.name;
    if (analytics != null) {
      analytics.setCurrentScreen(pageName);
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is PageRoute) {
      _sendPageView(route);
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute is PageRoute) {
      _sendPageView(newRoute);
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendPageView(previousRoute);
    }
    super.didPop(route, previousRoute);
  }
}
