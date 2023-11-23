import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/util/reponsive_utility.dart';
import 'package:go_router_responsive/ui/common/routing/material_page_transitionable.dart';

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

  @override
  State<MasterDetailResponsiveView> createState() =>
      _MasterDetailResponsiveViewState();
}

class _MasterDetailResponsiveViewState
    extends State<MasterDetailResponsiveView> {
  // var isTwoPane = false;
  // var isPlaceholderVisible = true;
  var explicityShowDetail = false;

  @override
  void didChangeDependencies() {
    //
    // isPlaceholderVisible = isTwoPane && widget.detail == null;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MasterDetailResponsiveView oldWidget) {
    if (oldWidget.detail != widget.detail) {
      // isPlaceholderVisible = false;
      if (widget.detail == null) {
        explicityShowDetail = true;
      }
      Timer(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        // isPlaceholderVisible = true;
        print('widget.detail == null: ${widget.detail == null}');
        if (widget.detail == null) {
          explicityShowDetail = false;
        }
        setState(() {});
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final isTwoPane = ResponsiveUtility.isBiggerThanMobile(context);
    print('');
    print('explicityShowDetail: $explicityShowDetail');
    print('isTwoPane: $isTwoPane');
    return Stack(
      children: widget.detail != null || explicityShowDetail
          ? [
              _buildMaster(isTwoPane: isTwoPane),
              _buildDetail(isTwoPane: isTwoPane),
            ]
          : [
              _buildDetail(isTwoPane: isTwoPane),
              _buildMaster(isTwoPane: isTwoPane),
            ],
    );
  }

  Widget _buildMaster({required bool isTwoPane}) {
    return Align(
      key: const ValueKey('master'),
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: isTwoPane ? 0.4 : 1.0,
        child: widget.master,
      ),
    );
  }

  Widget _buildDetail({required bool isTwoPane}) {
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
