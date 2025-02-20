import 'package:flutter/material.dart';
import 'model/product.dart';

// ✅ Added velocity constant (104)
const double _kFlingVelocity = 2.0;

class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    required this.currentCategory,
    required this.frontLayer,
    required this.backLayer,
    required this.frontTitle,
    required this.backTitle,
    Key? key,
  }) : super(key: key);

  @override
  _BackdropState createState() => _BackdropState();
}

// ✅ Added _BackdropState class (104)
class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _controller.isCompleted ? -_kFlingVelocity : _kFlingVelocity);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    return Stack(
      key: _backdropKey,
      children: <Widget>[
        // ✅ Wrapped backLayer in ExcludeSemantics widget (104)
        ExcludeSemantics(
          excluding: _controller.status != AnimationStatus.completed,
          child: widget.backLayer,
        ),
        widget.frontLayer,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: _toggleBackdropLayerVisibility,
      ),
      title: _BackdropTitle(
        listenable: _controller.view,
        onTap: _toggleBackdropLayerVisibility,
        frontTitle: widget.frontTitle,
        backTitle: widget.backTitle,
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.tune),
          onPressed: () {},
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(builder: _buildStack),
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final VoidCallback onTap;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    required Animation<double> listenable,
    required this.onTap,
    required this.frontTitle,
    required this.backTitle,
    Key? key,
  }) : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.titleLarge!,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Stack(
              children: [
                Opacity(
                  opacity: CurvedAnimation(
                    parent: ReverseAnimation(animation),
                    curve: Curves.fastOutSlowIn,
                  ).value,
                  child: backTitle,
                ),
                Opacity(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  ).value,
                  child: frontTitle,
                ),
              ],
            ),
          ),            
        ],
      ),
    );
  }
}
