import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrentFlagCard extends StatelessWidget {
  const CurrentFlagCard({
    super.key,
    required this.flagAsset,
    required this.countryCode,
  });

  final String flagAsset;
  final String countryCode;

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: countryCode,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: Material(
        color: Colors.transparent,
        child: _FlagImage(asset: flagAsset, width: 140),
      ),
      childWhenDragging: Opacity(
        opacity: 0.25,
        child: _FlagImage(asset: flagAsset, width: 120),
      ),
      child: Semantics(
        button: true,
        label: 'Bandeira para arrastar',
        hint: 'Arraste até o território correspondente no mapa',
        child: _FlagImage(asset: flagAsset, width: 120),
      ),
    );
  }
}

class _FlagImage extends StatelessWidget {
  const _FlagImage({required this.asset, required this.width});

  final String asset;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          asset,
          width: width,
          height: 68,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              Text('Erro ao carregar bandeira: $error'),
        ),
      ),
    );
  }
}
