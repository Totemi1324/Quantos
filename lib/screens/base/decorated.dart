import 'package:flutter/material.dart';
import 'package:flutter_gen/gen/assets.gen.dart';

import '../settings_screen.dart';

class Decorated extends StatefulWidget {
  final Widget body;

  const Decorated({required this.body, super.key});

  @override
  State<Decorated> createState() => _DecoratedState();
}

class _DecoratedState extends State<Decorated> {
  late ImageProvider _image;

  @override
  void initState() {
    super.initState();
    _image = Assets.images.background.provider();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-0.6, -0.7),
          radius: 2,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
          stops: const [0.0, 1.0],
        ),
        image: DecorationImage(
          image: _image,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: ModalRoute.of(context)?.canPop == true
              ? IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 40,
                  ),
                )
              : null,
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(SettingsScreen.routeName),
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 5),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.settings_rounded,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        body: widget.body,
      ),
    );
  }
}
