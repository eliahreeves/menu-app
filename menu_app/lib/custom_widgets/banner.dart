import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee/marquee.dart';

import 'package:menu_app/providers/banner_text_provider.dart';

class Banner extends ConsumerWidget {
  const Banner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerText = ref.watch(bannerTextProvider);
    return bannerText.when(
      data: (value) => value.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                height: 30,
                color: const Color.fromARGB(100, 0, 60, 108),
                child: Marquee(
                  text: (value).trim().replaceAll(r'\n', ''),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: 20,
                  velocity: 30,
                  showFadingOnlyWhenScrolling: true,
                  fadingEdgeStartFraction: 0.1,
                  fadingEdgeEndFraction: 0.1,
                  startPadding: 10,
                ),
              ),
            )
          : const SizedBox(
              height: 10,
            ),
      error: (_, __) => const SizedBox(
        height: 10,
      ),
      loading: () => const SizedBox(
        height: 10,
      ),
    );
  }
}
