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
import 'package:url_launcher/url_launcher.dart';
import 'package:website/commons/users_base_route.dart';

/// The route to give information on how to contact us
class ContactsRoute extends StatelessWidget {
  static const routeName = '/contacts';

  /// The email address to use as contact information
  final _contactsEmail = 'distant.queue.app@gmail.com';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = StringsLocalization.of(context)!;
    final textTheme = theme.textTheme.headline5!;

    final contactsInfo = Text.rich(TextSpan(
      text: localization.getString('contacts_ill_text'),
      style: textTheme.copyWith(
        color: theme.colorScheme.onSecondary,
      ),
      children: [
        WidgetSpan(
          child: InkWell(
            child: SelectableText(
              ' $_contactsEmail',
              style: textTheme.copyWith(color: Colors.blue),
            ),
            onTap: () {
              launch('mailto:$_contactsEmail');
            },
          ),
        ),
      ],
    ));

    return IllustratedBaseRoute(
      title: localization.getString('contact_us')!,
      showContactsRedirect: false,
      descriptiveIllustrations: [
        DescriptiveIllustration(
          illustrationPath: 'assets/illustrations/contacts.png',
          descriptionTitle: localization.getString('contacts_ill_title')!,
          descriptionFooter: contactsInfo,
          direction: DescriptiveIllustrationDirection.illustrationOnLeft,
        ),
      ],
    );
  }
}
