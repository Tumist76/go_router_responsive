import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/util/reponsive_utility.dart';
import 'package:go_router_responsive/widget/material_page_transitionable.dart';

class MasterDetailResponsiveView extends StatelessWidget {
  final Widget master;
  final Widget? detail;

  const MasterDetailResponsiveView({
    super.key,
    required this.master,
    this.detail,
  });

  static Page<T> buildRoute<T>({
    required BuildContext context,
    required String routeName,
    required Widget Function(BuildContext) masterBuilder,
    Widget Function(BuildContext)? detailBuilder,
  }) {
    print('called MasterDetailResponsiveView.buildRoute');
    final page = MasterDetailResponsiveView(
      master: masterBuilder(context),
      detail: detailBuilder?.call(context),
    );
    return MaterialPageTransitionable<T>(
      withTransition: !ResponsiveUtility.isBiggerThanMobile(context),
      child: page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: _buildViews(context));
  }

  List<Widget> _buildViews(BuildContext context) {
    if (!ResponsiveUtility.isBiggerThanMobile(context)) {
      return [Flexible(flex: 1, child: detail ?? master)];
    }
    return [
      Flexible(flex: 1, child: master),
      Flexible(flex: 2, child: detail ?? _buildPlaceholder()),
    ];
  }

  Widget _buildPlaceholder() {
    return Center(child: Text('No detail selected'));
  }
}
