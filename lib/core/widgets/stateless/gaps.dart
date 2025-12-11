part of '../widgets.dart';

abstract interface class Gaps {
  const Gaps._();

  static SizedBox v(double value) => SizedBox(height: value);
  static SizedBox h(double value) => SizedBox(width: value);
  static SizedBox square(double size) => SizedBox(width: size, height: size);
  static SizedBox v8() => const SizedBox(height: 8);
  static SizedBox v10() => const SizedBox(height: 10);
  static SizedBox v12() => const SizedBox(height: 12);
  static SizedBox v16() => const SizedBox(height: 16);
  static SizedBox v18() => const SizedBox(height: 18);
  static SizedBox v20() => const SizedBox(height: 20);
  static SizedBox v24() => const SizedBox(height: 24);
  static SizedBox v25() => const SizedBox(height: 25);
  static SizedBox v32() => const SizedBox(height: 32);
  static SizedBox h8() => const SizedBox(width: 8);
  static SizedBox h10() => const SizedBox(width: 10);
  static SizedBox h12() => const SizedBox(width: 12);
  static SizedBox h16() => const SizedBox(width: 16);
  static SizedBox h18() => const SizedBox(width: 18);
  static SizedBox h25() => const SizedBox(width: 25);
  static SizedBox square10() => const SizedBox(width: 10, height: 10);
}
