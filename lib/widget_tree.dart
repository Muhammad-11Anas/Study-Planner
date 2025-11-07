import 'package:flutter/material.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tasks = [
      {
        'title': 'Read OS Chapter 3',
        'subtitle': 'CPU  Scheduling basics',
        'progress': 0.3,
      },
      {
        'title': 'Implement Stack in C++',
        'subtitle': 'Use array-based implementation',
        'progress': 0.6,
      },
      {
        'title': 'Flutter Layout Practice',
        'subtitle': 'Row / Column / Stack examples',
        'progress': 0.1,
      },
      {
        'title': 'Revise DBMS Notes',
        'subtitle': 'Normalization & keys',
        'progress': 0.8,
      },
    ];
    return Scaffold(
      body: CustomScrollView(
        // 🔹 This is the Sliver Scroll View (CustomScrollView + slivers)
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Study Planner'),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.tealAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 160,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Today's Focus",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Finish 2 key tasks and revise OS concepts.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: -10,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Start Session'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: _TaskCard(
                  title: task['title'],
                  subtitle: task['subtitle'],
                  progress: task['progress'],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;

  const _TaskCard({
    required this.title,
    required this.subtitle,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // leading circular progress using Stack again (optional, another Stack)
            SizedBox(
              height: 40,
              width: 40,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(value: progress, strokeWidth: 4),
                  Center(
                    child: Text(
                      '${(progress * 100).round()}%',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // text column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
