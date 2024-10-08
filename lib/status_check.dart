import 'package:flutter/material.dart';

class StatusCheckScreen extends StatelessWidget {
  const StatusCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        // Date & Time
        Text(
          '更新日時 2024年09月01日 12:00',
          style: TextStyle(color: Colors.grey),
        ),

        // Door Section
        SectionTitle(title: 'Doors'),
        StatusRow(
          label: 'Door Status',
          status: 'Closed',
        ),
        StatusRow(
          label: 'Door Lock',
          status: 'Unlocked',
        ),

        // Window Section
        SectionTitle(title: 'Windows'),
        StatusRow(
          label: 'Windows',
          status: 'Closed',
        ),

        // Lamp Section
        SectionTitle(title: 'Lights'),
        StatusRow(
          label: 'Headlights',
          status: 'OFF',
        ),
        StatusRow(
          label: 'Taillights',
          status: 'OFF',
        ),
        StatusRow(
          label: 'Hazard Lights',
          status: 'OFF',
        ),

        // Additional Sections
        SectionTitle(title: 'Other'),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  final String label;
  final String status;

  const StatusRow({
    super.key,
    required this.label,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                status,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey, // 線の色を灰色に設定
            thickness: 1.0, // 線の太さを設定
          ),
        ],
      ),
    );
  }
}
