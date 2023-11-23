import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/routing/routes.dart';
import 'package:go_router_responsive/util/reponsive_utility.dart';

class MasterDetailResponsiveView extends StatefulWidget {
  final Widget master;
  final Widget? detail;
  final Widget? detailPlaceholder;

  const MasterDetailResponsiveView.detail({
    super.key,
    required this.master,
    required Widget this.detail,
  }) : detailPlaceholder = null;

  const MasterDetailResponsiveView.master({
    super.key,
    required this.master,
    required Widget this.detailPlaceholder,
  }) : detail = null;

  factory MasterDetailResponsiveView.fromRoute({
    required GoRouterState state,
    required Routes masterRoute,
    required Widget master,
    required Widget child,
  }) {
    // Если путь совпадает с master-виджетом, то в "узком" формате будет
    // отображаться он. Иначе на экране будет отображаться detail,
    // а master-виджет будет скрыт под ним.
    final isOnlyMaster = state.fullPath?.endsWith(masterRoute.path) ?? false;
    if (isOnlyMaster) {
      return MasterDetailResponsiveView.master(
        master: master,
        detailPlaceholder: child,
      );
    }
    return MasterDetailResponsiveView.detail(
      master: master,
      detail: child,
    );
  }

  @override
  State<MasterDetailResponsiveView> createState() =>
      _MasterDetailResponsiveViewState();
}

class _MasterDetailResponsiveViewState
    extends State<MasterDetailResponsiveView> {
  var explicityShowDetail = false;
  var isTwoPane = false;

  @override
  void didChangeDependencies() {
    isTwoPane = ResponsiveUtility.isBiggerThanMobile(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MasterDetailResponsiveView oldWidget) {
    if (oldWidget.detail != null && widget.detail == null) {
      // При отображании в формате master-detail эта логика не нужна.
      if (isTwoPane) return;
      // Если мы находимся в "узком" формате, и происходит возвращение
      // с экрана detail, нужно подождать завершения анимации перехода,
      // прежде чем скрывать detail, чтобы избежать резкого перехода.
      explicityShowDetail = true;
      // 300мс - длительность стандартной анимации перехода MaterialPage.
      Timer(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        setState(() => explicityShowDetail = false);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.detail != null || explicityShowDetail
          ? [_buildMaster(), _buildDetail()]
          : [_buildDetail(), _buildMaster()],
    );
  }

  Widget _buildMaster() {
    return Align(
      key: const ValueKey('master'),
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: isTwoPane ? 0.4 : 1.0,
        child: widget.master,
      ),
    );
  }

  Widget _buildDetail() {
    return Align(
      key: const ValueKey('detail'),
      alignment: Alignment.centerRight,
      child: FractionallySizedBox(
        alignment: Alignment.centerRight,
        widthFactor: isTwoPane ? 0.6 : 1.0,
        child: widget.detail ?? widget.detailPlaceholder!,
      ),
    );
  }
}
