import 'package:flood_mobile/Blocs/graph_bloc/graph_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowChartButton extends StatelessWidget {
  const ShowChartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: ElevatedButton(
        key: Key("Show Chart Button"),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          backgroundColor:
              BlocProvider.of<SpeedGraphBloc>(context).state.showChart
                  ? Color(0xff39C481)
                  : Color(0xff39C481).withAlpha(70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Container(
          height: 30,
          width: 30,
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => RotationTransition(
                    turns: child.key == ValueKey('icon1')
                        ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                        : Tween<double>(begin: 0.75, end: 1).animate(anim),
                    child: ScaleTransition(scale: anim, child: child),
                  ),
              child: BlocProvider.of<SpeedGraphBloc>(context).state.showChart ==
                      true
                  ? Icon(
                      Icons.close,
                      key: const ValueKey('icon1'),
                      size: 30,
                    )
                  : Image.asset(
                      'assets/images/line-chart.png',
                      height: 23,
                      width: 23,
                    )),
        ),
        onPressed: (() {
          BlocProvider.of<SpeedGraphBloc>(context)
              .add(ChangeChartStatusEvent());
        }),
      ),
    );
  }
}
