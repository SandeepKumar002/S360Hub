import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/auth_state.dart';

class ModuleSelectionPage extends ConsumerWidget {
  const ModuleSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Module'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authServiceProvider).signOut(),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _ModuleCard(title: 'Nexus', icon: Icons.hub, color: Colors.blue, onTap: () => context.go('/nexus')),
          _ModuleCard(title: 'Pulse', icon: Icons.monitor_heart, color: Colors.red, onTap: () => context.go('/pulse')),
          _ModuleCard(title: 'Staffie', icon: Icons.people_alt, color: Colors.orange, onTap: () => context.go('/staffie')),
          _ModuleCard(title: 'Recruit', icon: Icons.work_outline, color: Colors.teal, onTap: () => context.go('/recruit')),
          _ModuleCard(title: 'Performance', icon: Icons.trending_up, color: Colors.purple, onTap: () => context.go('/performance')),
          _ModuleCard(title: 'Shield', icon: Icons.shield, color: Colors.green, onTap: () => context.go('/shield')),
          _ModuleCard(title: 'Committee', icon: Icons.groups_2, color: Colors.brown, onTap: () => context.go('/committee')),
          _ModuleCard(title: 'Finac', icon: Icons.attach_money, color: Colors.indigo, onTap: () => context.go('/finac')),
          _ModuleCard(title: 'Taxforge', icon: Icons.account_balance, color: Colors.deepOrange, onTap: () => context.go('/taxforge')),
          _ModuleCard(title: 'Ledgie', icon: Icons.book, color: Colors.blueGrey, onTap: () => context.go('/ledgie')),
          _ModuleCard(title: 'Contracforce', icon: Icons.gavel, color: Colors.black54, onTap: () => context.go('/contracforce')),
          _ModuleCard(title: 'Comm', icon: Icons.chat, color: Colors.lightBlue, onTap: () => context.go('/comm')),
          _ModuleCard(title: 'Survey', icon: Icons.poll, color: Colors.amber, onTap: () => context.go('/survey')),
          _ModuleCard(title: 'Knowledge', icon: Icons.school, color: Colors.pink, onTap: () => context.go('/knowledge')),
          _ModuleCard(title: 'Training', icon: Icons.model_training, color: Colors.cyan, onTap: () => context.go('/training')),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ModuleCard({required this.title, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
