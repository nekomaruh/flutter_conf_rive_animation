import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_pull_to_refresh/rive_pull_to_refresh.dart';

class Bow extends StatefulWidget {
  static const String route = "/bow";

  const Bow({super.key});

  @override
  State<Bow> createState() => _MyAppState();
}

class _MyAppState extends State<Bow> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _rivePullToRefreshController?.dispose();
    super.dispose();
  }

  SMITrigger? _bump;
  SMITrigger? _restart;
  SMINumber? _smiNumber;
  SimpleAnimation? _controllerPull;
  SimpleAnimation? _controllerTrigger;
  SimpleAnimation? _controllerLoading;
  SimpleAnimation? _controllerIdle;
  final ScrollController _controller = ScrollController();
  RivePullToRefreshController? _rivePullToRefreshController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bow'),
        ),
        body: RivePullToRefresh(
          timeResize: const Duration(milliseconds: 200),
          onInit: (controller) {
            _rivePullToRefreshController = controller;
          },

          //if the height of rive widget is larger try to upper this value
          kDragContainerExtentPercentage: 0.45,

          dragSizeFactorLimitMax: 1,
          sizeFactorLimitMin: 1,
          percentActiveBump: 1,
          style: RivePullToRefreshStyle.header,
          openHeaderStyle: RiveOpenHeaderStyle.behide,
          curveMoveToPositionBumpStart: Curves.bounceOut,
          onMoveToPositionBumpStart: () {},
          bump: () async {
            //action start anim when stop Scrool
            _bump?.fire();

            _controllerPull?.isActive = true;
            //time play anim
            await Future.delayed(const Duration(seconds: 1));

            _bump?.fire();

            await Future.delayed(const Duration(seconds: 1));

            //close header
            await _rivePullToRefreshController!.close();
            _smiNumber?.value = 0;
            _restart?.fire();

            //call function onRefresh
            _rivePullToRefreshController!.onRefresh!();

            //TimeStartAnim
          },
          callBackNumber: (number) {
            //anim when pull
            _smiNumber?.value = number;
          },
          height: 200,
          riveWidget: RiveAnimation.asset(
            fit: BoxFit.fitWidth,
            'assets/images/pull_to_refresh_halloween.riv',
            artboard: 'New Artboard',
            onInit: _onRiveInit,
          ),

          controller: _controller,
          onRefresh: () async {},
          child: ListView.builder(
            physics: const ClampingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            controller: _controller,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                child: SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      index.toString(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onRiveInit(Artboard artboard) {
    _controllerPull = SimpleAnimation('Pull');
    _controllerTrigger = SimpleAnimation('Trigger');
    _controllerLoading = SimpleAnimation('Loading');
    _controllerIdle = SimpleAnimation('Idle');
    artboard.addController(_controllerPull as RiveAnimationController);
    artboard.addController(_controllerTrigger as RiveAnimationController);
    artboard.addController(_controllerLoading as RiveAnimationController);
    artboard.addController(_controllerIdle as RiveAnimationController);


    _controllerIdle?.isActive = true;
    _controllerPull?.isActive = false;
    _controllerTrigger?.isActive = false;
    _controllerLoading?.isActive = false;



    _controllerPull?.isActiveChanged.addListener(() {
      if (!_controllerPull!.isActive) {
        _controllerTrigger?.isActive = true;
      }
    });

    _controllerTrigger?.isActiveChanged.addListener(() {
      if (!_controllerTrigger!.isActive) {
        _controllerLoading?.isActive = true;
      }
    });

    _controllerIdle?.isActiveChanged.addListener(() {
      if (!_controllerIdle!.isActive) {
        _controllerIdle?.isActive = true;
      }
    });

    _controllerLoading?.isActiveChanged.addListener(() {
      if (!_controllerLoading!.isActive) {
        _controllerLoading?.isActive = true;
      }
    });

  }
}
