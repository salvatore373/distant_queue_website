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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterboilerplate/dimens_const.dart';
import 'package:flutterboilerplate/localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website/commons/base_route.dart';
import 'package:website/commons/utils.dart';
import 'package:website/commons/widgets.dart';
import 'package:website/data/colors_and_themes.dart';

/// The maximum width of the title and subtitle of the header
const _kHeaderTextMaxWidth = 704.0;

/// The width of the section to redirect to the contacts route
const _kQuestionsSectionHeight = 248.0;

/// The width of the badges inside a [StoreBadges] widget
const _kStoreBadgesWidth = 224.0;

/// All the possible ways to arrange the illustration and the description in
/// a [DescriptiveIllustration] widget
enum DescriptiveIllustrationDirection {
  illustrationOnLeft,
  illustrationOnRight,
}

/// A widget displaying the store badges that redirect to the Google PLay and
/// App Store links.
class StoreBadges extends StatelessWidget {
  final String googlePlayLink;
  final String appStoreLink;

  StoreBadges({
    Key? key,
    required this.googlePlayLink,
    required this.appStoreLink,
  })  : assert(googlePlayLink != null),
        assert(appStoreLink != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = StringsLocalization.of(context)!;
    final theme = Theme.of(context);

    final languageCode = localization.locale.languageCode;
    final playStoreBadgePath =
        'assets/app-store-badges/google-play-badge-$languageCode.png';
    final appStoreBadgePath =
        'assets/app-store-badges/app-store-badge-$languageCode.png';
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 16.0,
          children: [
            InkWell(
              child: Container(
                width: _kStoreBadgesWidth,
                child: Image.asset(playStoreBadgePath),
              ),
              onTap: () {
                launch(googlePlayLink);
              },
            ),
            InkWell(
              child: Container(
                width: _kStoreBadgesWidth,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset(appStoreBadgePath),
                ),
              ),
              onTap: () {
                launch(appStoreLink);
              },
            ),
          ],
        ),
        Flexible(
          child: Text(
            localization.getString('store_badges_credits')!,
            style: theme.textTheme.overline!.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

/// The section to redirect the user to the contacts route
class _QuestionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = StringsLocalization.of(context)!;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          localization.getString('do_you_have_any_question')!,
          style: theme.textTheme.headline4!.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSecondary,
          ),
        ),
        Padding(
          padding: CommonDimensions.topDividerPadding,
          child: ContactsButton(onPrimary: false),
        ),
      ],
    );

    return Container(
      constraints: BoxConstraints.expand(height: _kQuestionsSectionHeight),
      decoration: BoxDecoration(
        gradient: DistantQueueColors.secondaryGradient,
        borderRadius: BorderRadius.vertical(top: Radius.circular(36.0)),
      ),
      child: Padding(
        padding: CommonDimensions.largeOverallPadding,
        child: content,
      ),
    );
  }
}

/// An illustration with a descriptive text on the side
class DescriptiveIllustration extends StatelessWidget {
  /// The path to the illustration
  final String illustrationPath;

  /// The title of the text next to the illustration
  final String descriptionTitle;

  /// The text below the title next to the illustration
  final String? descriptionText;

  /// The words in [descriptionText] to display in bold
  final String? descriptionTextToBoldify;

  /// An optional widget to place below the description
  final Widget? descriptionFooter;

  /// The direction of the descriptive illustration
  final DescriptiveIllustrationDirection direction;

  DescriptiveIllustration({
    Key? key,
    required this.illustrationPath,
    required this.descriptionTitle,
    this.descriptionText,
    this.descriptionFooter,
    this.descriptionTextToBoldify,
    this.direction = DescriptiveIllustrationDirection.illustrationOnLeft,
  })  : assert(illustrationPath != null),
        assert(descriptionTitle != null),
        super(key: key);

  /// Returns the widget to use as description, with the right section in bold
  Widget createDescriptionTextWidget(TextStyle textStyle) {
    if (descriptionTextToBoldify == null) {
      return Text(descriptionText!, style: textStyle);
    }

    final startIndex = descriptionText!.indexOf(descriptionTextToBoldify!);
    final boldEndIndex = startIndex + descriptionTextToBoldify!.length;

    // Divide the text in sections
    final preBold = descriptionText!.substring(0, startIndex);
    final bold = descriptionText!.substring(startIndex, boldEndIndex);
    final postBold = descriptionText!.substring(boldEndIndex);

    return Text.rich(
      TextSpan(
        text: preBold,
        children: [
          TextSpan(
            text: bold,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: postBold),
        ],
      ),
      style: textStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = getScreenSize(context);

    final illustration = Image.asset(
      illustrationPath,
      width: 550.0,
      height: 430.0,
    );

    final padding = screenSize == ScreenSizes.small
        ? CommonDimensions.topDividerPadding
        : (direction == DescriptiveIllustrationDirection.illustrationOnLeft
            ? CommonDimensions.leftDividerPadding
            : CommonDimensions.rightDividerPadding);
    final description = Flexible(
      child: Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                descriptionTitle,
                style: theme.textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              descriptionText == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: createDescriptionTextWidget(
                        theme.textTheme.headline5!.copyWith(
                          color: theme.colorScheme.onSecondary,
                        ),
                      ),
                    ),
              descriptionFooter == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: descriptionFooter,
                    ),
            ],
          )),
    );

    Widget content;
    if (screenSize == ScreenSizes.small) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [illustration, description],
      );
    } else {
      final rowElements =
          direction == DescriptiveIllustrationDirection.illustrationOnLeft
              ? [illustration, description]
              : [description, illustration];
      content = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: rowElements,
      );
    }

    return Container(
      constraints: BoxConstraints(maxWidth: 1240.0),
      child: content,
    );
  }
}

/// The base structure of a route with a title and illustrations as content
class IllustratedBaseRoute extends StatelessWidget {
  /// The text to place at the top of the route
  final String title;

  /// The text to place below [title]
  final String? subtitle;

  /// The list of illustrations and relative text to show
  final List<DescriptiveIllustration> descriptiveIllustrations;

  /// Whether to show a section where the user is redirected to the
  /// contacts route.
  final bool showContactsRedirect;

  IllustratedBaseRoute({
    Key? key,
    required this.title,
    this.subtitle,
    required this.descriptiveIllustrations,
    this.showContactsRedirect = true,
  })  : assert(title != null),
        assert(descriptiveIllustrations != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final header = RouteHeader(
      child: Container(
        constraints: BoxConstraints(maxWidth: _kHeaderTextMaxWidth),
        padding: CommonDimensions.sidesPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.headline3!.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
              ),
            ),
            subtitle == null
                ? Container()
                : Padding(
                    padding: CommonDimensions.topDividerPadding,
                    child: Text(
                      subtitle!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );

    final illustrationsColumn = Column(
      children: descriptiveIllustrations
          .map((ill) => Padding(
                padding: const EdgeInsets.only(top: 56.0),
                child: ill,
              ))
          .toList(),
    );

    return BaseRoute(
      child: Container(
        color: theme.colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            header,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 36.0,
              ),
              child: illustrationsColumn,
            ),
            showContactsRedirect
                ? Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: _QuestionsSection(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
