import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history = globals.quizHistory;
    final total = globals.totalQuizzesCompleted;
    final avg = globals.averageScore;
    final best = globals.bestScore;
    final questionsAnswered = globals.totalQuestionsAnswered;
    final correctAnswers = globals.totalCorrectAnswers;

    // Count quizzes by type
    final mcqCount = history.where((r) => r.quizType == 'mcq').length;
    final typingCount = history.where((r) => r.quizType == 'typing').length;
    final matchingCount = history.where((r) => r.quizType == 'matching').length;
    final mixedCount = history.where((r) => r.quizType == 'mixed').length;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Progress')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.amber, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      total == 0 ? 'No quizzes yet' : '$total Quizzes Completed',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (total > 0)
                      Text(
                        'Average Score: ${avg.round()}%',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    if (total == 0)
                      Text(
                        'Complete a quiz to start tracking your progress!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Stats grid
            const Text(
              'Statistics',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Best Score',
                    total > 0 ? '$best%' : '--',
                    Icons.star,
                    Colors.amber,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Questions',
                    '$questionsAnswered',
                    Icons.help_outline,
                    Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Correct',
                    '$correctAnswers',
                    Icons.check_circle_outline,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Accuracy',
                    questionsAnswered > 0
                        ? '${((correctAnswers / questionsAnswered) * 100).round()}%'
                        : '--',
                    Icons.track_changes,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Quiz type breakdown
            const Text(
              'Quiz Breakdown',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            _buildBreakdownRow('Multiple Choice', mcqCount, Icons.quiz, Colors.blue),
            _buildBreakdownRow('Typing', typingCount, Icons.keyboard, Colors.green),
            _buildBreakdownRow('Matching', matchingCount, Icons.swap_horiz, Colors.orange),
            _buildBreakdownRow('Mixed', mixedCount, Icons.shuffle, Colors.purple),
            const SizedBox(height: 24),

            // Recent quizzes
            const Text(
              'Recent Quizzes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            if (history.isEmpty)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'No quiz history yet.\nGo take a quiz!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
              )
            else
              ...history.reversed.take(10).map((result) => _buildHistoryItem(result)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownRow(String label, int count, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: count > 0 ? color : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(globals.QuizResult result) {
    final date = DateTime.tryParse(result.date);
    final dateStr = date != null
        ? '${date.month}/${date.day}/${date.year}'
        : result.date;
    final pct = result.percentage.round();
    final color = pct >= 70 ? Colors.green : (pct >= 40 ? Colors.orange : Colors.red);
    final typeLabel = {
      'mcq': 'Multiple Choice',
      'typing': 'Typing',
      'matching': 'Matching',
      'mixed': 'Mixed',
    }[result.quizType] ?? result.quizType;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  '$pct%',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    typeLabel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${result.score}/${result.totalQuestions} correct',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Text(
              dateStr,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
