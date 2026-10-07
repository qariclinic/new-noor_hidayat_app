import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_role.dart';
import '../providers/library_provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/content_card.dart';
import 'bookmarks_screen.dart';
import 'onboarding_screen.dart';
import 'parental_pin_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _switchProfile(BuildContext context) async {
    final profiles = context.read<ProfileProvider>();
    final me = profiles.active!;
    if (me.role == UserRole.child && profiles.parentPin != null) {
      if (!await askParentPin(context, profiles)) return;
    }
    if (!context.mounted) return;
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(children: [
        for (final p in profiles.profiles)
          ListTile(
            title: Text('${p.name} (${p.role.label})'),
            selected: p.id == profiles.activeId,
            onTap: () { profiles.switchTo(p.id); Navigator.pop(context); },
          ),
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('نیا پروفائل'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
          },
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final me = context.watch<ProfileProvider>().active!;
    final lib = context.watch<LibraryProvider>();
    final items = lib.visible(me.role);
    return Scaffold(
      appBar: AppBar(
        title: Text('السلام علیکم، ${me.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BookmarksScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen())),
          ),
          IconButton(icon: const Icon(Icons.switch_account), onPressed: () => _switchProfile(context)),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            onChanged: lib.setQuery,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'تلاش کریں',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: 48,
          child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 8), children: [
            for (final c in lib.categories(me.role))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(c),
                  selected: lib.category == c,
                  onSelected: (s) => lib.setCategory(s ? c : null),
                ),
              ),
          ]),
        ),
        Expanded(
          child: items.isEmpty
              ? const Center(child: Text('کوئی مواد نہیں ملا'))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, i) => ContentCard(item: items[i]),
                ),
        ),
      ]),
    );
  }
}
