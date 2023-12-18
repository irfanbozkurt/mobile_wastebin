import 'package:flutter/material.dart';

import 'login.dart';
import 'model/product.dart';

const double _kFlingVelocity = 2;

class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    Key? key,
    required this.currentCategory,
    required this.frontLayer,
    required this.backLayer,
    required this.frontTitle,
    required this.backTitle,
  }) : super(key: key);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdopTitle extends AnimatedWidget {
  final void Function() onPress;
  final Widget frontTitle;
  final Widget backTitle;

  final Animation<double> _listenable;

  const _BackdopTitle(
      {Key? key,
      required Animation<double> listenable,
      required this.onPress,
      required this.frontTitle,
      required this.backTitle})
      : _listenable = listenable,
        super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = _listenable;
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.titleLarge!,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: Row(
          children: [
            SizedBox(
              width: 72,
              child: IconButton(
                padding: const EdgeInsets.only(right: 8),
                onPressed: onPress,
                icon: Stack(
                  children: [
                    Opacity(
                      opacity: animation.value,
                      child: const ImageIcon(
                          AssetImage('assets/slanted_menu.png')),
                    ),
                    FractionalTranslation(
                      translation: Tween<Offset>(
                              begin: Offset.zero, end: const Offset(1, 0))
                          .evaluate(animation),
                      child: const ImageIcon(AssetImage('assets/diamond.png')),
                    )
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Opacity(
                  opacity: CurvedAnimation(
                          parent: ReverseAnimation(animation),
                          curve: const Interval(0.5, 1))
                      .value,
                  child: FractionalTranslation(
                    child: backTitle,
                    translation: Tween<Offset>(
                            begin: Offset.zero, end: const Offset(0.5, 0))
                        .evaluate(animation),
                  ),
                ),
                Opacity(
                  opacity: CurvedAnimation(
                          parent: animation, curve: const Interval(0.5, 1))
                      .value,
                  child: FractionalTranslation(
                    child: frontTitle,
                    translation: Tween<Offset>(
                            begin: Offset.zero, end: const Offset(0, 0))
                        .evaluate(animation),
                  ),
                )
              ],
            )
          ],
        ));
  }
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  // Handle the animation / controller
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    // Setup a new animation controller at every initState
    _controller = AnimationController(
        vsync: this, value: 1, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _frontLayerVisible {
    return [AnimationStatus.completed, AnimationStatus.forward]
        .contains(_controller.status);
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  @override
  void didUpdateWidget(covariant Backdrop old) {
    super.didUpdateWidget(old);

    widget.currentCategory != old.currentCategory
        ? _toggleBackdropLayerVisibility()
        : _controller.fling(velocity: _kFlingVelocity);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 256;
    final layerSize = constraints.biggest;
    final layerTop = layerSize.height - layerTitleHeight;

    return Stack(
      key: _backdropKey,
      children: [
        widget.backLayer,
        PositionedTransition(
            rect: RelativeRectTween(
                    begin: RelativeRect.fromLTRB(
                        0, layerTop, 0, layerTop - layerSize.height),
                    end: const RelativeRect.fromLTRB(0, 0, 0, 0))
                .animate(_controller.view),
            child: _FrontLayer(
              child: widget.frontLayer,
              onTap: _toggleBackdropLayerVisibility,
            ))
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      title: _BackdopTitle(
        listenable: _controller.view,
        onPress: _toggleBackdropLayerVisibility,
        frontTitle: widget.frontTitle,
        backTitle: widget.backTitle,
      ),
      actions: [
        IconButton(
            onPressed: () {
              // TODO: Add open login (104)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
            },
            icon: const Icon(
              Icons.search,
              semanticLabel: 'login',
            )),
        IconButton(
            onPressed: () {
              // TODO: Add open login (104)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
            },
            icon: const Icon(
              Icons.tune,
              semanticLabel: 'login',
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: LayoutBuilder(builder: _buildStack),
    );
  }
}

class _FrontLayer extends StatelessWidget {
  // TODO: add on-tap callback
  const _FrontLayer({Key? key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            // behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              height: 40,
              alignment: AlignmentDirectional.centerStart,
            ),
          ),
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}
