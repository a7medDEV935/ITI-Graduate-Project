import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

class CustomActionSlider extends StatelessWidget {
  final Future<void> Function() onSuccess;

  const CustomActionSlider({
    super.key,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ActionSlider.standard(
        sliderBehavior: SliderBehavior.stretch,
        rolling: false,
        width: double.infinity,
        height: 60.0,
        toggleColor: Colors.blue,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        backgroundBorderRadius: BorderRadius.circular(5.0),
        foregroundBorderRadius: BorderRadius.circular(5.0),
        icon: const Icon(Icons.shopping_cart_checkout_rounded),
        action: (controller) async {
          controller.loading();
          await Future.delayed(const Duration(seconds: 2));
          controller.success();
          await onSuccess();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: const Center(
          child: Text(
            'Slide to Checkout',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
