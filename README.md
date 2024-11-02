# 🇵🇪 Flutter Conf LATAM - Rive Animation Workshop

This app is based on the presentation of Rive Animations at Flutter Conf LATAM by Boris Benalcázar.

Source: https://github.com/phucho2306/RivePullToRefresh/blob/main/example/lib/pages/bow.dart

<img class="center" src="https://github.com/user-attachments/assets/7fec49f1-4aa3-4608-9553-ba3f375556b0" img/>

# 1. Code

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

# 2. Explanation

The app is a pull to refresh that shows the animation when you pull it. This animation is based on a state machine that shows different images on the timeline. These are the possible states:

- Idle: When the animation is inactive
- Pull: When you drag and the pull to refresh is executed
- Loading: When the animation is initialized
- Trigger: Launches the animation

Each time a state is executed, the next state must be launched through the controllers, to execute the desired animation presented in the Rive Artwork.
