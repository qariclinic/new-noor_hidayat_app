import 'package:flutter/material.dart';
import '../providers/profile_provider.dart';

Future<String?> _pinDialog(BuildContext context, String title) {
  final c = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        decoration: const InputDecoration(hintText: '4 ہندسوں کا PIN'),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('منسوخ')),
        FilledButton(onPressed: () => Navigator.pop(context, c.text), child: const Text('ٹھیک ہے')),
      ],
    ),
  );
}

/// والدین کا PIN مانگتا ہے؛ درست ہو تو true دیتا ہے۔
Future<bool> askParentPin(BuildContext context, ProfileProvider p) async {
  final pin = await _pinDialog(context, 'والدین کا PIN درج کریں');
  return pin != null && p.verifyPin(pin);
}

/// پہلی بار بچے کا پروفائل بنتے وقت PIN سیٹ کرواتا ہے۔
Future<void> setParentPinFlow(BuildContext context, ProfileProvider p) async {
  final pin = await _pinDialog(context, 'والدین کے لیے نیا PIN بنائیں');
  if (pin != null && pin.length == 4) await p.setParentPin(pin);
}
