import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_role.dart';
import '../providers/profile_provider.dart';
import 'parental_pin_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _name = TextEditingController();
  UserRole? _role;

  Future<void> _continue() async {
    final profiles = context.read<ProfileProvider>();
    if (_name.text.trim().isEmpty || _role == null) return;
    if (_role == UserRole.child && profiles.parentPin == null) {
      await setParentPinFlow(context, profiles);
      if (profiles.parentPin == null) return; // PIN لازمی ہے
    }
    await profiles.addProfile(_name.text.trim(), _role!);
    if (mounted && Navigator.canPop(context)) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نورِ ہدایت میں خوش آمدید')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'نام', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          const Text('آپ کون ہیں؟'),
          const SizedBox(height: 8),
          for (final r in UserRole.values)
            Card(
              color: _role == r ? Theme.of(context).colorScheme.primaryContainer : null,
              child: ListTile(
                title: Text(r.label),
                trailing: _role == r ? const Icon(Icons.check_circle) : null,
                onTap: () => setState(() => _role = r),
              ),
            ),
          const Spacer(),
          FilledButton(onPressed: _continue, child: const Text('آگے بڑھیں')),
        ]),
      ),
    );
  }
}
