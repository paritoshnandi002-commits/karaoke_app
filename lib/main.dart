import 'dart:ui';
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
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedNav = 0;
  int selectedCategory = 0;

  final categories = [
    ['🔥', 'Popular'],
    ['♡', 'Love'],
    ['☆', 'Bengali'],
    ['♫', 'Hindi'],
    ['☺', 'Sad'],
    ['▦', 'More'],
  ];

  final songs = [
    ['1', 'Tum Hi Ho', 'Arijit Singh', Icons.favorite],
    ['2', 'Kesariya', 'Arijit Singh', Icons.nightlight_round],
    ['3', 'Apna Bana Le', 'Arijit Singh', Icons.music_note],
    ['4', "Let's Sing Together", 'Music connects hearts', Icons.graphic_eq],
  ];

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF171034),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050018),
      extendBody: true,

      body: Stack(
        children: [
          // 🌌 GLOWING BACKGROUND
          Positioned(
            top: -100,
            left: -80,
            child: glow(260, const Color(0xFFFF20C8)),
          ),
          Positioned(
            top: 350,
            right: -100,
            child: glow(300, const Color(0xFF493CFF)),
          ),
          Positioned(
            bottom: 150,
            left: -120,
            child: glow(280, const Color(0xFF00D9FF)),
          ),

          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // HEADER
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(22, 18, 22, 12),
                    child: Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (r) => const LinearGradient(
                            colors: [
                              Color(0xFFFF55D8),
                              Color(0xFF8B6CFF),
                              Color(0xFF35E9FF),
                            ],
                          ).createShader(r),
                          child: const Icon(
                            Icons.music_note,
                            size: 54,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 5),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Karaoke',
                                style: TextStyle(
                                  fontSize: 39,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: -1,
                                ),
                              ),
                              Text(
                                'Sing  •  Feel  •  Be You  ♥',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        glassButton(
                          Icons.notifications_none_rounded,
                          onTap: () {},
                        ),

                        const SizedBox(width: 10),

                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF32D1),
                                Color(0xFF704CFF),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white70,
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFFF19D4),
                                blurRadius: 18,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.person, size: 29),
                        ),
                      ],
                    ),
                  ),
                ),

                // HERO
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    child: glossyCard(
                      height: 300,
                      child: Stack(
                        children: [
                          Positioned(
                            right: -45,
                            top: -30,
                            child: glow(230, const Color(0xFFFF20D5)),
                          ),
                          Positioned(
                            right: 20,
                            bottom: -50,
                            child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    const Color(0xFFFF27CF)
                                        .withOpacity(.65),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      '♛',
                                      style: TextStyle(
                                        color: Color(0xFFFFD43B),
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Your Voice',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                ShaderMask(
                                  shaderCallback: (r) =>
                                      const LinearGradient(
                                    colors: [
                                      Color(0xFFFF70D9),
                                      Color(0xFFB78CFF),
                                    ],
                                  ).createShader(r),
                                  child: const Text(
                                    'Your Stage ♥',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 37,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                const Text(
                                  'Sing your favorite songs\n'
                                  'and connect with people\n'
                                  'who love music! ♥',
                                  style: TextStyle(
                                    color: Colors.white,
                                    height: 1.35,
                                    fontSize: 15,
                                  ),
                                ),

                                const Spacer(),

                                GestureDetector(
                                  onTap: () => showMessage(
                                    '🎤 Let’s start singing!',
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 23,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFFF27C8),
                                          Color(0xFF735CFF),
                                        ],
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0xFFFF19CE),
                                          blurRadius: 25,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.mic_rounded),
                                        SizedBox(width: 10),
                                        Text(
                                          'Sing Now',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Icon(Icons.arrow_forward_rounded),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // MICROPHONE ART
                          Positioned(
                            right: 25,
                            bottom: 40,
                            child: Container(
                              width: 105,
                              height: 145,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(55),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF22204A),
                                    Color(0xFF080719),
                                  ],
                                ),
                                border: Border.all(
                                  color: Color(0xFFFF4ED8),
                                  width: 2,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFFFF19D4),
                                    blurRadius: 30,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.mic_rounded,
                                size: 70,
                                color: Color(0xFFFF6DE2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // CATEGORIES
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 125,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final selected = selectedCategory == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedCategory = index);
                            showMessage(
                              '${categories[index][1]} songs selected',
                            );
                          },
                          child: Container(
                            width: 82,
                            margin: const EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: selected
                                          ? [
                                              const Color(0xFFFF2BCB),
                                              const Color(0xFF724BFF),
                                            ]
                                          : [
                                              const Color(0xFF211548),
                                              const Color(0xFF10102D),
                                            ],
                                    ),
                                    border: Border.all(
                                      color: selected
                                          ? const Color(0xFFFF65E0)
                                          : Colors.white24,
                                      width: 1.5,
                                    ),
                                    boxShadow: selected
                                        ? const [
                                            BoxShadow(
                                              color: Color(0xFFFF21D2),
                                              blurRadius: 22,
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: Center(
                                    child: Text(
                                      categories[index][0],
                                      style: const TextStyle(fontSize: 29),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  categories[index][1],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: selected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: selected
                                        ? Colors.white
                                        : Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // POPULAR TITLE
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(22, 10, 20, 10),
                    child: Row(
                      children: [
                        const Text(
                          '♛',
                          style: TextStyle(
                            fontSize: 34,
                            color: Color(0xFFFFD43B),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Popular Songs',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Top trending songs for you ♥',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () => showMessage('Showing all songs'),
                          child: const Text('See All  ›'),
                        ),
                      ],
                    ),
                  ),
                ),

                // SONGS
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final song = songs[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 5,
                        ),
                        child: songCard(
                          number: song[0],
                          title: song[1],
                          artist: song[2],
                          icon: song[3] as IconData,
                          onPlay: () => showMessage(
                            '▶ Playing ${song[1]}',
                          ),
                        ),
                      );
                    },
                    childCount: songs.length,
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 130),
                ),
              ],
            ),
          ),

          // BOTTOM NAV
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 76,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B0829).withOpacity(.88),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: const Color(0xFFB64CFF).withOpacity(.55),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF641EFF),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      navItem(Icons.home_rounded, 'Home', 0),
                      navItem(Icons.explore_rounded, 'Explore', 1),

                      // BIG MIC
                      GestureDetector(
                        onTap: () => showMessage(
                          '🎤 Microphone opened!',
                        ),
                        child: Container(
                          width: 67,
                          height: 67,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF26C9),
                                Color(0xFF704CFF),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFFF21D3),
                                blurRadius: 25,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.mic_rounded,
                            size: 34,
                          ),
                        ),
                      ),

                      navItem(Icons.groups_rounded, 'Room', 2),
                      navItem(Icons.person_outline_rounded, 'Profile', 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navItem(IconData icon, String title, int index) {
    final selected = selectedNav == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedNav = index);
        showMessage('$title opened');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 27,
            color: selected
                ? const Color(0xFFFF4EDB)
                : Colors.white70,
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: selected
                  ? const Color(0xFFFF4EDB)
                  : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

// GLOSSY CARD
Widget glossyCard({
  required double height,
  required Widget child,
}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF30205D).withOpacity(.9),
          const Color(0xFF11113C).withOpacity(.92),
          const Color(0xFF160A35).withOpacity(.95),
        ],
      ),
      border: Border.all(
        color: const Color(0xFFFF42D5).withOpacity(.7),
        width: 1.5,
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0xFF8D21FF),
          blurRadius: 25,
          spreadRadius: -5,
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: child,
    ),
  );
}

// SONG CARD
Widget songCard({
  required String number,
  required String title,
  required String artist,
  required IconData icon,
  required VoidCallback onPlay,
}) {
  return Container(
    height: 92,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      gradient: const LinearGradient(
        colors: [
          Color(0xFF171642),
          Color(0xFF101D4C),
        ],
      ),
      border: Border.all(
        color: const Color(0xFF6755D9).withOpacity(.65),
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0xFF241C70),
          blurRadius: 15,
        ),
      ],
    ),
    child: Row(
      children: [
        const SizedBox(width: 8),

        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF39C8),
                Color(0xFF4C3CFF),
              ],
            ),
          ),
          child: Icon(
            icon,
            size: 34,
            color: Colors.white,
          ),
        ),

        const SizedBox(width: 13),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                artist,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),

        GestureDetector(
          onTap: onPlay,
          child: Container(
            width: 49,
            height: 49,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFF1FCB),
                  Color(0xFF694CFF),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFF20D0),
                  blurRadius: 18,
                ),
              ],
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 31,
            ),
          ),
        ),

        const SizedBox(width: 12),

        const Icon(
          Icons.favorite_border_rounded,
          color: Colors.white70,
        ),

        const SizedBox(width: 12),

        const Icon(
          Icons.more_vert_rounded,
          color: Colors.white70,
        ),

        const SizedBox(width: 10),
      ],
    ),
  );
}

Widget glow(double size, Color color) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [
          color.withOpacity(.45),
          color.withOpacity(.08),
          Colors.transparent,
        ],
      ),
    ),
  );
}

Widget glassButton(
  IconData icon, {
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(.08),
        border: Border.all(color: Colors.white24),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF8D29FF),
            blurRadius: 15,
          ),
        ],
      ),
      child: Icon(icon, size: 27),
    ),
  );
}
