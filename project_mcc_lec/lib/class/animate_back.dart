// import 'dart:math' as math;

import 'package:animated_background/animated_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AnimatedBackgroundCustom extends StatefulWidget {
  const AnimatedBackgroundCustom({Key? key}) : super(key: key);

  @override
  State<AnimatedBackgroundCustom> createState() => _AnimatedBackgroundCustomState();
}

class _AnimatedBackgroundCustomState extends State<AnimatedBackgroundCustom> with TickerProviderStateMixin{

  int _behaviourIndex = 0;
  Behaviour? _behaviour;

  ParticleOptions particleOptions = ParticleOptions(
    image: Image.asset('assets/Logo/Logo.png'),
    // baseColor: Colors.blue,
    // spawnOpacity: 0.0,
    // opacityChangeRate: 10,
    // minOpacity: 0.1,
    // maxOpacity: 0.4,
    spawnMinSpeed: 50,
    spawnMaxSpeed: 100,
    spawnMinRadius: 20,
    spawnMaxRadius: 70,
    particleCount: 10,
  );

  var particlePaint = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 1.0;

  bool _showSettings = false;

  @override
  Widget build(BuildContext context) {

    return AnimatedBackground( 
      vsync: this, 
      behaviour: _behaviour = _buildBehaviour(),
      // behaviour: RandomParticleBehaviour(),
      child: Container(),
    );
  }

  Behaviour _buildBehaviour() {
    return RandomParticleBehaviour(
      options: particleOptions,
      paint: particlePaint,
    );
    // return SpaceBehaviour();
  }
}

