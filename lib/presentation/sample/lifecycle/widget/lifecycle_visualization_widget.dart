import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:rxdart/rxdart.dart';

class LifecycleVisualizationWidget extends StatefulWidget {
  const LifecycleVisualizationWidget({super.key});

  @override
  State<LifecycleVisualizationWidget> createState() =>
      _LifecycleVisualizationWidgetState();
}

class _LifecycleVisualizationWidgetState
    extends State<LifecycleVisualizationWidget> {
  late final StreamController<LifecycleState> _stateController;
  late Stream<LifecycleState> _stateStream;
  final _random = Random();
  final _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _stateController = StreamController<LifecycleState>.broadcast();
    _stateStream =
        _stateController.stream.interval(const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _stateController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LifecycleVisualizationCubit(),
      child: Column(
        children: [
          BlocBuilder<LifecycleVisualizationCubit, LifecycleVisualizationState>(
            builder: (context, state) {
              final widget = Center(
                child: LifecycleCallbackWidgetWrapper(
                  key: _globalKey,
                  stateController: _stateController,
                  color: state.color,
                ),
              );
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade300,
                    child: (LifecycleVisualizationWidgetPosition.left ==
                            state.position)
                        ? widget
                        : null,
                  ),
                  const SizedBox(width: 40),
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade300,
                    child: (LifecycleVisualizationWidgetPosition.right ==
                            state.position)
                        ? widget
                        : null,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 30),
          LifecycleVisualizationItemWidgetWrapper(
            label: 'initState',
            stream: _stateStream
                .where((state) => state == LifecycleState.initState),
          ),
          const Icon(Icons.arrow_downward),
          LifecycleVisualizationItemWidgetWrapper(
            label: 'didChangeDependencies',
            stream: _stateStream.where(
                (state) => state == LifecycleState.didChangeDependencies),
          ),
          const Icon(Icons.arrow_downward),
          LifecycleVisualizationItemWidgetWrapper(
            label: 'build',
            stream:
                _stateStream.where((state) => state == LifecycleState.build),
          ),
          const Icon(Icons.arrow_downward),
          LifecycleVisualizationItemWidgetWrapper(
            label: 'deactivate',
            stream: _stateStream
                .where((state) => state == LifecycleState.deactivate),
          ),
          const Icon(Icons.arrow_downward),
          LifecycleVisualizationItemWidgetWrapper(
            label: 'dispose',
            stream:
                _stateStream.where((state) => state == LifecycleState.dispose),
          ),
          const SizedBox(height: 30),
          BlocBuilder<LifecycleVisualizationCubit, LifecycleVisualizationState>(
            builder: (context, state) {
              final cubit = context.read<LifecycleVisualizationCubit>();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (state.position ==
                      LifecycleVisualizationWidgetPosition.none) ...[
                    ElevatedButton(
                      onPressed: () {
                        cubit.setWidget();
                      },
                      child: const Text('Set'),
                    ),
                  ],
                  if (state.position !=
                      LifecycleVisualizationWidgetPosition.none) ...[
                    ElevatedButton(
                      onPressed: () {
                        final color = Colors.primaries[
                            _random.nextInt(Colors.primaries.length)];
                        cubit.updateColor(color);
                      },
                      child: const Text('Update'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.swapPosition();
                      },
                      child: const Text('Swap'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.removeWidget();
                      },
                      child: const Text('Remove'),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

enum LifecycleState {
  initState,
  didChangeDependencies,
  build,
  didUpdateWidget,
  deactivate,
  dispose,
}
