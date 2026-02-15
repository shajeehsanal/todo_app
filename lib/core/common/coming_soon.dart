import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComingSoonPage extends ConsumerStatefulWidget {
  const ComingSoonPage({super.key});

  @override
  ConsumerState<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends ConsumerState<ComingSoonPage> {
  String fullText = 'Coming Soon...';
  final displayedTextProvider = StateProvider.autoDispose<String>((ref) => '');
  final isCursorVisibleProvider =
      StateProvider.autoDispose<bool>((ref) => true);
  Timer? _typingTimer;
  Timer? _cursorTimer;

  void _startTyping() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      final currentText = ref.watch(displayedTextProvider);
      if (currentText.length < fullText.length) {
        if (!mounted) return;
        ref
            .read(displayedTextProvider.notifier)
            .update((state) => '$state${fullText[currentText.length]}');
      } else {
        timer.cancel();
        _stopCursorBlinking();
        _restartTyping();
      }
    });
  }

  void _startCursorBlinking() {
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!mounted) return;
      ref.read(isCursorVisibleProvider.notifier).update((state) => !state);
    });
  }

  void _stopCursorBlinking() {
    _cursorTimer?.cancel();
    if (!mounted) return;
    ref.read(isCursorVisibleProvider.notifier).update((state) => false);
  }

  void _restartTyping() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      ref.read(displayedTextProvider.notifier).update((state) => '');
      _startTyping();
      _startCursorBlinking();
    });
  }

  @override
  void initState() {
    super.initState();
    _startTyping();
    _startCursorBlinking();
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayedText = ref.watch(displayedTextProvider);
    final isCursorVisible = ref.watch(isCursorVisibleProvider);
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final fontSize = width > height ? width * 0.05 : height * 0.05;

    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(text: displayedText),
            if (isCursorVisible) const TextSpan(text: '|'), // Blinking Cursor
          ],
        ),
      ),
    );
  }
}
