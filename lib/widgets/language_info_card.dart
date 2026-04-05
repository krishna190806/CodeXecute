import 'package:flutter/material.dart';
import '../services/compiler_service.dart';

class LanguageInfoCard extends StatelessWidget {
  final String language;

  const LanguageInfoCard({required this.language, Key? key}) : super(key: key);

  Color getLanguageColor() {
    switch (language) {
      case 'Python':
        return const Color(0xFF3776AB);
      case 'Java':
        return const Color(0xFFEA2D2E);
      case 'C++':
        return const Color(0xFF00599C);
      default:
        return Colors.purple;
    }
  }

  IconData getLanguageIcon() {
    switch (language) {
      case 'Python':
        return Icons.circle;
      case 'Java':
        return Icons.coffee;
      case 'C++':
        return Icons.add;
      default:
        return Icons.code;
    }
  }

  String getLanguageDescription() {
    switch (language) {
      case 'Python':
        return 'A high-level, interpreted language known for simplicity and readability. Perfect for beginners and data science.';
      case 'Java':
        return 'A versatile, object-oriented language with strong typing. Widely used for enterprise applications.';
      case 'C++':
        return 'A powerful language offering low-level memory access and high performance. Ideal for system programming.';
      default:
        return 'Programming language';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getLanguageColor();
    final version = CompilerService.getLanguageVersion(language);
    final features = CompilerService.getLanguageFeatures(language);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(getLanguageIcon(), color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    version,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            getLanguageDescription(),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Key Features:',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: features.map((feature) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withOpacity(0.4)),
                ),
                child: Text(
                  feature,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CodeStats extends StatelessWidget {
  final int lines;
  final int characters;
  final int functions;
  final String size;

  const CodeStats({
    required this.lines,
    required this.characters,
    required this.functions,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard('📝 Lines', lines.toString()),
        const SizedBox(width: 8),
        _buildStatCard('💾 Size', size),
        const SizedBox(width: 8),
        _buildStatCard('🔧 Functions', functions.toString()),
      ],
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E24),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
