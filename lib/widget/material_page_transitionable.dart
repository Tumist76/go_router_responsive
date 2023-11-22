import 'package:flutter/material.dart';

class MaterialPageTransitionable<T> extends MaterialPage<T> {
  const MaterialPageTransitionable({
    required this.withTransition,
    required super.child,
  });

  final bool withTransition;

  @override
  Route<T> createRoute(BuildContext context) {
    return _PageBasedMaterialPageRoute<T>(
      withTransition: withTransition,
      page: this,
      allowSnapshotting: allowSnapshotting,
    );
  }
}

class _PageBasedMaterialPageRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  _PageBasedMaterialPageRoute({
    required MaterialPage<T> page,
    required this.withTransition,
    super.allowSnapshotting,
  }) : super(settings: page) {
    assert(opaque);
  }

  final bool withTransition;

  MaterialPage<T> get _page => settings as MaterialPage<T>;

  @override
  Duration get transitionDuration =>
      withTransition ? super.transitionDuration : Duration.zero;

  @override
  Widget buildContent(BuildContext context) {
    return _page.child;
  }

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';
}
