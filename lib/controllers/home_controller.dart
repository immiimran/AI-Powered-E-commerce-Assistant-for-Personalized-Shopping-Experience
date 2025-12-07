import 'dart:async';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  // carousel index
  final carouselIndex = 0.obs;

  // Chips selection
  final selectedFilter = 'Newest'.obs;

  // Countdown for flash sale
  final hours = 0.obs;
  final minutes = 0.obs;
  final seconds = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startFlashSaleCountdown(
        durationInSeconds: 2 * 60 * 60 + 30); // example 2h30s
  }

  void setCarouselIndex(int idx) => carouselIndex.value = idx;

  void setFilter(String filter) => selectedFilter.value = filter;

  // Start a simple countdown timer
  void _startFlashSaleCountdown({required int durationInSeconds}) {
    int remaining = durationInSeconds;
    _tick(remaining);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remaining <= 0) {
        timer.cancel();
        hours.value = minutes.value = seconds.value = 0;
      } else {
        remaining--;
        _tick(remaining);
      }
    });
  }

  void _tick(int remaining) {
    final h = remaining ~/ 3600;
    final m = (remaining % 3600) ~/ 60;
    final s = remaining % 60;
    hours.value = h;
    minutes.value = m;
    seconds.value = s;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
