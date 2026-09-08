import 'package:flutter/material.dart';

void main() {
  runApp(const KaraokeApp());
}

class KaraokeApp extends StatelessWidget {
  const KaraokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Karaoke',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, String>> songs = const [
    {
      'title': 'Tum Hi Ho',
      'singer': 'Arijit Singh',
    },
    {
      'title': 'Kesariya',
      'singer': 'Arijit Singh',
    },
    {
      'title': 'Apna Bana Le',
      'singer': 'Arijit Singh',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎤 Karaoke'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Welcome! 🎶',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Choose a song and start singing!',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 25),

          const Text(
            'Popular Songs 🎵',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...songs.map(
            (song) => Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.music_note),
                ),
                title: Text(song['title']!),
                subtitle: Text(song['singer']!),
                trailing: const Icon(
                  Icons.play_circle_fill,
                  size: 32,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongPage(
                        title: song['title']!,
                        singer: song['singer']!,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SongPage extends StatelessWidget {
  final String title;
  final String singer;

  const SongPage({
    super.key,
    required this.title,
    required this.singer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Singing 🎤'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 65,
                child: Icon(
                  Icons.music_note,
                  size: 65,
                ),
              ),

              const SizedBox(height: 25),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                singer,
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 35),

              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.mic),
                label: const Text('Sing Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
