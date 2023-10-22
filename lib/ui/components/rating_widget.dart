import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.voteAverage});

  final dynamic voteAverage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/full_star.svg'),
        const SizedBox(width: 7),
        Text('$voteAverage/10')
      ],
    );
  }
}