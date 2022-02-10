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
import 'package:website/commons/users_base_route.dart';

/// The route to describe the application to business owners
class ForBusinessesRoute extends StatelessWidget {
  static const routeName = '/forBusinesses';

  /// The link to the Owner app on Google Play
  final appGooglePlayLink =
      'https://play.google.com/store/apps/details?id=com.distant_queue.owner';

  /// The link to the Owner app on the App Store
  final appAppStoreLink = 'https://apps.apple.com/app/id1523553911';

  @override
  Widget build(BuildContext context) {
    final localization = StringsLocalization.of(context)!;

    final storeBadgesFooter = StoreBadges(
      googlePlayLink: appGooglePlayLink,
      appStoreLink: appAppStoreLink,
    );

    return IllustratedBaseRoute(
      title: localization.getString('for_businesses_route_title')!,
      subtitle: localization.getString('for_businesses_route_subtitle'),
      descriptiveIllustrations: [
        DescriptiveIllustration(
          illustrationPath: 'assets/illustrations/download_owner.png',
          descriptionTitle: localization.getString('download_owner_ill_title')!,
          descriptionText: localization.getString('download_owner_ill_text'),
          descriptionTextToBoldify: localization.getString('completely_free'),
          descriptionFooter: storeBadgesFooter,
          direction: DescriptiveIllustrationDirection.illustrationOnLeft,
        ),
        DescriptiveIllustration(
          illustrationPath: 'assets/illustrations/create_shop.png',
          descriptionTitle: localization.getString('create_business_ill_title')!,
          descriptionText: localization.getString('create_business_ill_text'),
          direction: DescriptiveIllustrationDirection.illustrationOnRight,
        ),
        DescriptiveIllustration(
          illustrationPath: 'assets/illustrations/scan_qr.png',
          descriptionTitle: localization.getString('scan_ticket_ill_title')!,
          descriptionText: localization.getString('scan_ticket_ill_text'),
          direction: DescriptiveIllustrationDirection.illustrationOnLeft,
        ),
      ],
    );
  }
}
