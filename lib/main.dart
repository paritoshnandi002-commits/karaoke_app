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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF05031D),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  const Icon(
                    Icons.music_note,
                    size: 42,
                    color: Color(0xFFFF5BD7),
                  ),
                  const Text(
                    'Karaoke',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF26104F),
                    child: const Icon(Icons.notifications_none),
                  ),
                  const SizedBox(width: 8),
                  const CircleAvatar(
                    backgroundColor: Color(0xFFE946C4),
                    child: Icon(Icons.person),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.only(left: 45),
                child: Text(
                  'Sing • Feel • Be You ♥',
                  style: TextStyle(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 22),

              // HERO CARD
              Container(
                width: double.infinity,
                height: 310,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF172B70),
                      Color(0xFF76106E),
                    ],
                  ),
                  border: Border.all(
                    color: Color(0xFFFF39C8),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x665D20FF),
                      blurRadius: 25,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '♛',
                      style: TextStyle(
                        color: Color(0xFFFFD21F),
                        fontSize: 24,
                      ),
                    ),
                    const Text(
                      'Your Voice',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const Text(
                      'Your Stage ♥',
                      style: TextStyle(
                        color: Color(0xFFFF8DDD),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Sing your favorite songs\n'
                      'and connect with people\n'
                      'who love music! ♥',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.mic),
                      label: const Text(
                        'Sing Now  →',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF39B8),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // CATEGORIES
              Container(
                height: 125,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFF10144A),
                  border: Border.all(
                    color: const Color(0x334C78FF),
                  ),
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    Category(Icons.local_fire_department, 'Popular'),
                    Category(Icons.favorite, 'Love'),
                    Category(Icons.star, 'Bengali'),
                    Category(Icons.music_note, 'Hindi'),
                    Category(Icons.sentiment_satisfied, 'Sad'),
                    Category(Icons.apps, 'More'),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // TITLE
              const Row(
                children: [
                  Text(
                    '♛',
                    style: TextStyle(
                      color: Color(0xFFFFD21F),
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Popular Songs',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Top trending songs for you ♥',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    'See All  ›',
                    style: TextStyle(
                      color: Color(0xFFB9C8FF),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              const SongCard(
                number: '1',
                title: 'Tum Hi Ho',
                artist: 'Arijit Singh',
                tag: '🔥 Most Popular',
              ),

              const SongCard(
                number: '2',
                title: 'Kesariya',
                artist: 'Arijit Singh',
                tag: '↗ Trending',
              ),

              const SongCard(
                number: '3',
                title: 'Apna Bana Le',
                artist: 'Arijit Singh',
                tag: '☆ For You',
              ),

              const SongCard(
                number: '4',
                title: 'Let’s Sing Together',
                artist: 'Music connects hearts ♥',
                tag: '♫ For You',
              ),
            ],
          ),
        ),
      ),

      // BOTTOM BAR
      bottomNavigationBar: Container(
        height: 75,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF08092B),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: const Color(0x444C6CFF),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(Icons.home, 'Home', true),
            NavItem(Icons.explore, 'Explore', false),

            CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFFFF36BE),
              child: Icon(
                Icons.mic,
                size: 34,
                color: Colors.white,
              ),
            ),

            NavItem(Icons.groups, 'Room', false),
            NavItem(Icons.person_outline, 'Profile', false),
          ],
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final IconData icon;
  final String name;

  const Category(this.icon, this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFF48C5),
                  Color(0xFF743EFF),
                ],
              ),
            ),
            child: Icon(
              icon,
              size: 30,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class SongCard extends StatelessWidget {
  final String number;
  final String title;
  final String artist;
  final String tag;

  const SongCard({
    super.key,
    required this.number,
    required this.title,
    required this.artist,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF171044),
            Color(0xFF092650),
          ],
        ),
        border: Border.all(
          color: const Color(0x334C6CFF),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 82,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF4DC4),
                  Color(0xFF443EFF),
                ],
              ),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  artist,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFFD72DAB),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(fontSize: 9),
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFF32C0),
                  Color(0xFF633CFF),
                ],
              ),
            ),
            child: const Icon(
              Icons.play_arrow,
              size: 30,
            ),
          ),

          const SizedBox(width: 5),

          const Icon(
            Icons.favorite_border,
            color: Colors.white70,
          ),

          const Icon(
            Icons.more_vert,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool active;

  const NavItem(
    this.icon,
    this.text,
    this.active, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: active
              ? const Color(0xFFFF4FC8)
              : const Color(0xFFBFC5E8),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: active
                ? const Color(0xFFFF4FC8)
                : const Color(0xFFBFC5E8),
          ),
        ),
      ],
    );
  }
}
