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
import 'package:website/commons/base_route.dart';
import 'package:website/data/colors_and_themes.dart';
import 'package:website/routes/for_businesses_route.dart';
import 'package:website/routes/for_customers_route.dart';

/// The height of the background of the header
const _kHeaderHeight = 544.0;

/// THe height of the [_StrengthsSection]
const _kStrengthsSectionHeight = 320.0;

/// The width of on the elements of the [_StrengthsSection]
const _kStrengthsListItemWidth = 304.0;

/// The width and height of a [_RedirectionButton]
const _kRedirectionButtonSize = 480.0;

/// The width and height of a [_UseCaseIcon]
const _kUseCaseIconSize = 248.0;

/// The header of the home page, containing the app's logo, name and description
class _HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = StringsLocalization.of(context);
    final theme = Theme.of(context);

    final background = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipPath(
          clipper: BottomCurveClipper(),
          child: Container(
            height: _kHeaderHeight,
            decoration: BoxDecoration(
              gradient: DistantQueueColors.primaryGradient,
            ),
          ),
        ),
      ],
    );

    final logoAndDescription = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 124.0,
          child: Image.asset('assets/images/customer.png'),
        ),
        Padding(
          padding: CommonDimensions.topDividerPadding,
          child: Text(
            localization.getString('app_name'),
            style: theme.textTheme.headline4.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        Padding(
          padding: CommonDimensions.topDividerPadding,
          child: Text(
            localization.getString('home_screen_app_description'),
            textAlign: TextAlign.center,
            style: theme.textTheme.headline6.copyWith(
              fontWeight: FontWeight.normal,
              color: theme.colorScheme.onPrimary,
            ),
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
            padding: const EdgeInsets.symmetric(
              vertical: 148.0,
              horizontal: 8.0,
            ),
            child: logoAndDescription,
          ),
        ),
      ],
    );
  }
}

/// The expandable rectangles that fill the [_StrengthsSection]
class _StrengthsListItem extends StatefulWidget {
  /// The text to display at the top of the rectangle and when it is collapsed
  final String title;

  /// The text to display below the title when it is expanded
  final String description;

  _StrengthsListItem({
    Key key,
    @required this.title,
    @required this.description,
  })  : assert(title != null),
        assert(description != null),
        super(key: key);

  @override
  _StrengthsListItemState createState() => _StrengthsListItemState();
}

class _StrengthsListItemState extends State<_StrengthsListItem>
    with SingleTickerProviderStateMixin {
  ThemeData _theme;

  // Whether the widget is expanded to show the item description
  bool _isExpanded = false;

  // The animation stuff to expand the rectangle
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    initAnimation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _theme = Theme.of(context);

    final platform = _theme.platform;
    if (platform == TargetPlatform.android ||
        platform == TargetPlatform.iOS ||
        platform == TargetPlatform.fuchsia) {
      _animationController.value = 1.0;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Initialize the animation and its controller
  void initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );

    // Set the widget initial expansion based on the given parameter
    _animationController.value = _isExpanded ? 1.0 : 0.0;

    // Get the state of the expandable section
    _animationController.addStatusListener((status) {
      setState(() {
        _isExpanded = status == AnimationStatus.completed;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = Text(
      widget.title.toUpperCase(),
      style: _theme.textTheme.headline5.copyWith(
        fontWeight: FontWeight.bold,
        color: _theme.colorScheme.onPrimary,
      ),
    );

    final description = SizeTransition(
        sizeFactor: _animation,
        axis: Axis.vertical,
        child: Padding(
          padding: CommonDimensions.topDividerPadding,
          child: Container(
            child: Text(
              // widget.description, Cannot use this code for a Flutter web bug
              _isExpanded ? widget.description : '',
              style: _theme.textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.normal,
                color: _theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ));

    final columnElements = <Widget>[title];
    if (_isExpanded) columnElements.add(description);

    return InkWell(
      onTap: () {},
      onHover: (isEntering) {
        if (isEntering) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: _kStrengthsListItemWidth,
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 2.0, color: _theme.colorScheme.onPrimary),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title,
            description,
          ],
        ),
      ),
    );
  }
}

/// The section of the home page that lists the app's strengths
class _StrengthsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StringsLocalization _localization = StringsLocalization.of(context);
    ThemeData _theme = Theme.of(context);

    final title = Text(
      _localization.getString('why_choose_app'),
      textAlign: TextAlign.center,
      style: _theme.textTheme.headline3.copyWith(
        color: _theme.colorScheme.onPrimary,
      ),
    );

    final strengthsList = Wrap(
      direction: Axis.horizontal,
      spacing: 16.0,
      runSpacing: 16.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        _StrengthsListItem(
          title: _localization.getString('free'),
          description: _localization.getString('free_item_description'),
        ),
        _StrengthsListItem(
          title: _localization.getString('easy_to_use'),
          description: _localization.getString('easy_to_use_item_description'),
        ),
        _StrengthsListItem(
          title: _localization.getString('innovative'),
          description: _localization.getString('innovative_item_description'),
        ),
      ],
    );

    return Container(
      constraints: BoxConstraints(minHeight: _kStrengthsSectionHeight),
      padding: CommonDimensions.sidesPadding,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title,
            Padding(
              padding: const EdgeInsets.only(top: 56.0),
              child: strengthsList,
            ),
          ],
        ),
      ),
    );
  }
}

/// A button of the [_RedirectionSection] that redirects to the
/// customers' or businesses' section.
class _RedirectionButton extends StatelessWidget {
  /// The path to the icon to place in this button
  final String iconPath;

  /// The main text to display in this button
  final String title;

  /// The text to display below the title in this button
  final String description;

  /// The function to call when this button is pressed
  final VoidCallback onTap;

  _RedirectionButton({
    Key key,
    @required this.iconPath,
    @required this.title,
    @required this.description,
    this.onTap,
  })  : assert(iconPath != null),
        assert(title != null),
        assert(description != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final icon = Image.asset(iconPath, width: 232.0, height: 232.0);

    final titleWidget = Text(
      title.toUpperCase(),
      style: theme.textTheme.headline4.copyWith(
        color: theme.colorScheme.onSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
    final descriptionWidget = Text(
      description,
      textAlign: TextAlign.center,
      style: theme.textTheme.headline6.copyWith(
        color: theme.colorScheme.onSecondary,
        fontWeight: FontWeight.normal,
      ),
    );

    final iconButton = Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(24.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Icon(
          Icons.arrow_forward_ios,
          size: 20.0,
          color: theme.colorScheme.onSecondary,
        ),
      ),
    );

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: titleWidget,
        ),
        Padding(
          padding: CommonDimensions.topDividerPadding,
          child: descriptionWidget,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: iconButton,
        ),
      ],
    );

    return Container(
      width: _kRedirectionButtonSize,
      constraints: BoxConstraints(minHeight: _kRedirectionButtonSize),
      child: NeumorphicButton(
        onPressed: onTap,
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
        ),
        child: Padding(
          padding: CommonDimensions.standardOverallPadding,
          child: content,
        ),
      ),
    );
  }
}

/// One of the icon that fills the [_UseCasesSection]
class _UseCaseIcon extends StatelessWidget {
  final String text;
  final String iconPath;

  _UseCaseIcon({
    Key key,
    @required this.text,
    @required this.iconPath,
  })  : assert(text != null),
        assert(iconPath != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final icon = Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(48.0)),
      ),
      child: Container(
        width: 72.0,
        height: 72.0,
        padding: const EdgeInsets.all(24.0),
        child: Image.asset(
          iconPath,
          width: 24.0,
          height: 24.0,
        ),
      ),
    );

    final textWidget = Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.headline5.copyWith(
        color: theme.colorScheme.onSecondary,
        fontWeight: FontWeight.w500,
      ),
    );

    return SizedBox(
      width: _kUseCaseIconSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          Padding(
            padding: CommonDimensions.topDividerPadding,
            child: textWidget,
          ),
        ],
      ),
    );
  }
}

/// The section included in the [_RedirectionSection] that illustrates when
/// to use DistantQueue.
class _UseCasesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = StringsLocalization.of(context);
    final theme = Theme.of(context);

    final title = Text(
      localization.getString('suitable_for'),
      style: theme.textTheme.headline3.copyWith(
        color: theme.colorScheme.onSecondary,
        fontWeight: FontWeight.w500,
      ),
    );

    final casesList = Wrap(
      direction: Axis.horizontal,
      runSpacing: 36.0,
      spacing: 8.0,
      runAlignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        _UseCaseIcon(
          text: localization.getString('supermarkets'),
          iconPath: 'assets/icons/supermarket.png',
        ),
        _UseCaseIcon(
          text: localization.getString('hairdressers'),
          iconPath: 'assets/icons/hairdresser.png',
        ),
        _UseCaseIcon(
          text: localization.getString('clinics'),
          iconPath: 'assets/icons/clinic.png',
        ),
        _UseCaseIcon(
          text: localization.getString('offices'),
          iconPath: 'assets/icons/office.png',
        ),
        _UseCaseIcon(
          text: localization.getString('medical_offices'),
          iconPath: 'assets/icons/doctor.png',
        ),
        _UseCaseIcon(
          text: localization.getString('banks'),
          iconPath: 'assets/icons/bank.png',
        ),
        _UseCaseIcon(
          text: localization.getString('shops'),
          iconPath: 'assets/icons/shop.png',
        ),
        _UseCaseIcon(
          text: localization.getString('restaurants'),
          iconPath: 'assets/icons/restaurant.png',
        ),
        _UseCaseIcon(
          text: localization.getString('any_kind_of_business'),
          iconPath: 'assets/icons/more.png',
        ),
      ],
    );

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title,
        Padding(
          padding: const EdgeInsets.only(top: 36.0),
          child: casesList,
        ),
      ],
    );

    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16.0)),
        depth: 2,
      ),
      child: Padding(
        padding: CommonDimensions.largeOverallPadding,
        child: content,
      ),
    );
  }
}

/// The section of the home page that redirects the user to the customers' or
/// the businesses' apps.
class _RedirectionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = StringsLocalization.of(context);

    final redirectionButtons = Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceEvenly,
      direction: Axis.horizontal,
      spacing: 16.0,
      runSpacing: 16.0,
      children: [
        _RedirectionButton(
          iconPath: 'assets/icons/shop.png',
          title: localization.getString('for_businesses'),
          description: localization.getString('business_button_description'),
          onTap: () {
            Navigator.of(context).pushNamed(ForBusinessesRoute.routeName);
          },
        ),
        _RedirectionButton(
          iconPath: 'assets/icons/user.png',
          title: localization.getString('for_customers'),
          description: localization.getString('customers_button_description'),
          onTap: () {
            Navigator.of(context).pushNamed(ForCustomersRoute.routeName);
          },
        ),
      ],
    );

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        redirectionButtons,
        Padding(
          padding: const EdgeInsets.only(top: 104.0),
          child: _UseCasesSection(),
        ),
      ],
    );

    return Container(
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

/// Clips a widget replacing the bottom side with a Bezier curve
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final curveHeight = 80;

    var path = Path();
    path.lineTo(0, size.height - curveHeight);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - curveHeight,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// The website home page
class HomeRoute extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseRoute(
      child: Container(
        color: theme.colorScheme.primaryVariant,
        child: Column(
          children: [
            _HomeHeader(),
            _StrengthsSection(),
            _RedirectionSection(),
          ],
        ),
      ),
    );
  }
}
