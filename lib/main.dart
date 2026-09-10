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
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050018),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class Song {
  final String number;
  final String title;
  final String artist;
  final IconData icon;

  const Song({
    required this.number,
    required this.title,
    required this.artist,
    required this.icon,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCategory = 0;
  int selectedNav = 0;

  final List<String> categories = [
    '🔥  Popular',
    '♡  Love',
    '☆  Bengali',
    '♫  Hindi',
    '☹  Sad',
    '▦  More',
  ];

  final List<Song> songs = const [
    Song(
      number: '01',
      title: 'Tum Hi Ho',
      artist: 'Arijit Singh',
      icon: Icons.favorite_rounded,
    ),
    Song(
      number: '02',
      title: 'Kesariya',
      artist: 'Arijit Singh',
      icon: Icons.nightlight_round,
    ),
    Song(
      number: '03',
      title: 'Apna Bana Le',
      artist: 'Arijit Singh',
      icon: Icons.music_note_rounded,
    ),
    Song(
      number: '04',
      title: 'Let’s Sing Together',
      artist: 'Music connects hearts',
      icon: Icons.graphic_eq_rounded,
    ),
  ];

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor: const Color(0xFF21134D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF050018),
      body: Stack(
        children: [
          // BACKGROUND GLOW
          Positioned(
            left: -130,
            top: -120,
            child: glowCircle(
              330,
              const Color(0xFFFF19C8),
            ),
          ),

          Positioned(
            right: -140,
            top: 270,
            child: glowCircle(
              360,
              const Color(0xFF5838FF),
            ),
          ),

          Positioned(
            left: -150,
            bottom: 180,
            child: glowCircle(
              300,
              const Color(0xFF00D9FF),
            ),
          ),

          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // HEADER
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      18,
                      20,
                      12,
                    ),
                    child: Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              colors: [
                                Color(0xFFFF43D1),
                                Color(0xFF8D65FF),
                                Color(0xFF3BE9FF),
                              ],
                            ).createShader(bounds);
                          },
                          child: const Icon(
                            Icons.music_note_rounded,
                            size: 51,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 5),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Karaoke',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: -1.5,
                                ),
                              ),
                              Text(
                                'Sing  •  Feel  •  Be You  ♥',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        roundGlassButton(
                          Icons.notifications_none_rounded,
                        ),

                        const SizedBox(width: 10),

                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF2ACB),
                                Color(0xFF714BFF),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white70,
                              width: 1.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFFF20D0),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            size: 27,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // HERO CARD
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    child: Container(
                      height: 305,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF38215E),
                            Color(0xFF17133E),
                            Color(0xFF0C0A29),
                          ],
                        ),
                        border: Border.all(
                          color: const Color(0xFFFF45D7),
                          width: 1.2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF7B20FF),
                            blurRadius: 30,
                            spreadRadius: -5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -60,
                              top: -70,
                              child: glowCircle(
                                260,
                                const Color(0xFFFF20D4),
                              ),
                            ),

                            Positioned(
                              right: 28,
                              bottom: 32,
                              child: Container(
                                width: 105,
                                height: 145,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(60),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF29234F),
                                      Color(0xFF08071B),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(
                                    color: const Color(0xFFFF51DC),
                                    width: 2,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xFFFF20D1),
                                      blurRadius: 30,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.mic_rounded,
                                  size: 68,
                                  color: Color(0xFFFF75E3),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        '♛',
                                        style: TextStyle(
                                          color: Color(0xFFFFD84A),
                                          fontSize: 25,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Your Voice',
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight:
                                              FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),

                                  ShaderMask(
                                    shaderCallback: (bounds) {
                                      return const LinearGradient(
                                        colors: [
                                          Color(0xFFFF72D9),
                                          Color(0xFFBD91FF),
                                        ],
                                      ).createShader(bounds);
                                    },
                                    child: const Text(
                                      'Your Stage ♥',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 36,
                                        fontWeight:
                                            FontWeight.w900,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 9),

                                  const Text(
                                    'Sing your favorite songs\n'
                                    'and let your voice shine ✨',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      height: 1.4,
                                    ),
                                  ),

                                  const Spacer(),

                                  GestureDetector(
                                    onTap: () {
                                      message(
                                        '🎤 Let’s start singing!',
                                      );
                                    },
                                    child: Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 13,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30),
                                        gradient:
                                            const LinearGradient(
                                          colors: [
                                            Color(0xFFFF20C8),
                                            Color(0xFF714BFF),
                                          ],
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xFFFF19D2),
                                            blurRadius: 25,
                                          ),
                                        ],
                                      ),
                                      child: const Row(
                                        mainAxisSize:
                                            MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.mic_rounded,
                                            size: 22,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Sing Now',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 9),
                                          Icon(
                                            Icons
                                                .arrow_forward_rounded,
                                            size: 21,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // CATEGORY TITLE
                SliverToBoxAdapter(
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(
                      21,
                      13,
                      21,
                      3,
                    ),
                    child: Text(
                      'Explore your mood',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // CATEGORIES
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 105,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(
                        18,
                        10,
                        18,
                        8,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final bool selected =
                            selectedCategory == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = index;
                            });

                            message(
                              '${categories[index]} selected',
                            );
                          },
                          child: AnimatedContainer(
                            duration:
                                const Duration(milliseconds: 220),
                            margin: const EdgeInsets.only(right: 10),
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 17,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(24),
                              gradient: selected
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFFFF22C9),
                                        Color(0xFF704DFF),
                                      ],
                                    )
                                  : const LinearGradient(
                                      colors: [
                                        Color(0xFF211642),
                                        Color(0xFF11102F),
                                      ],
                                    ),
                              border: Border.all(
                                color: selected
                                    ? const Color(0xFFFF6CE1)
                                    : Colors.white24,
                              ),
                              boxShadow: selected
                                  ? const [
                                      BoxShadow(
                                        color: Color(0xFFFF20D0),
                                        blurRadius: 18,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                categories[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: selected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // POPULAR HEADER
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      21,
                      8,
                      20,
                      12,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          '♛',
                          style: TextStyle(
                            color: Color(0xFFFFD84A),
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Popular Songs',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Trending songs for you ♥',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            message('🎵 Showing all songs');
                          },
                          child: const Text(
                            'See All  ›',
                            style: TextStyle(
                              color: Color(0xFFFF68DC),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // SONG LIST
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Song song = songs[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 5,
                        ),
                        child: SongCard(
                          song: song,
                          onPlay: () {
                            message(
                              '▶ Playing ${song.title}',
                            );
                          },
                          onLike: () {
                            message(
                              '♥ Added ${song.title} to favorites',
                            );
                          },
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

          // GLASS BOTTOM NAV
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 18,
                  sigmaY: 18,
                ),
                child: Container(
                  height: 78,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D0928)
                        .withOpacity(0.92),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: const Color(0xFFB653FF)
                          .withOpacity(.6),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF6420FF),
                        blurRadius: 28,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                    children: [
                      NavButton(
                        icon: Icons.home_rounded,
                        label: 'Home',
                        selected: selectedNav == 0,
                        onTap: () {
                          setState(() {
                            selectedNav = 0;
                          });
                        },
                      ),
                      NavButton(
                        icon: Icons.explore_rounded,
                        label: 'Explore',
                        selected: selectedNav == 1,
                        onTap: () {
                          setState(() {
                            selectedNav = 1;
                          });
                          message('🔎 Explore opened');
                        },
                      ),

                      // CENTER MIC
                      GestureDetector(
                        onTap: () {
                          message(
                            '🎤 Microphone opened!',
                          );
                        },
                        child: Container(
                          width: 66,
                          height: 66,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFF21C9),
                                Color(0xFF714DFF),
                              ],
                            ),
                            border: Border.fromBorderSide(
                              BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFF20D0),
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

                      NavButton(
                        icon: Icons.groups_rounded,
                        label: 'Room',
                        selected: selectedNav == 2,
                        onTap: () {
                          setState(() {
                            selectedNav = 2;
                          });
                          message('👥 Room opened');
                        },
                      ),
                      NavButton(
                        icon: Icons.person_outline_rounded,
                        label: 'Profile',
                        selected: selectedNav == 3,
                        onTap: () {
                          setState(() {
                            selectedNav = 3;
                          });
                          message('👤 Profile opened');
                        },
                      ),
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
}

class SongCard extends StatelessWidget {
  final Song song;
  final VoidCallback onPlay;
  final VoidCallback onLike;

  const SongCard({
    super.key,
    required this.song,
    required this.onPlay,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1B1747),
            Color(0xFF111A43),
          ],
        ),
        border: Border.all(
          color: Color(0xFF6655D9),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF241A70),
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
              borderRadius: BorderRadius.circular(19),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF35C9),
                  Color(0xFF4C42FF),
                ],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF8B2DFF),
                  blurRadius: 14,
                ),
              ],
            ),
            child: Icon(
              song.icon,
              size: 32,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  song.artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: onPlay,
            child: Container(
              width: 47,
              height: 47,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFF20C9),
                    Color(0xFF684DFF),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFF20D0),
                    blurRadius: 17,
                  ),
                ],
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                size: 29,
              ),
            ),
          ),

          const SizedBox(width: 10),

          GestureDetector(
            onTap: onLike,
            child: const Icon(
              Icons.favorite_border_rounded,
              color: Colors.white70,
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          const Icon(
            Icons.more_vert_rounded,
            color: Colors.white54,
            size: 23,
          ),

          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const NavButton({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 27,
            color: selected
                ? const Color(0xFFFF54DA)
                : Colors.white70,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: selected
                  ? const Color(0xFFFF54DA)
                  : Colors.white60,
              fontWeight: selected
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

Widget glowCircle(double size, Color color) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [
          color.withOpacity(.42),
          color.withOpacity(.10),
          Colors.transparent,
        ],
      ),
    ),
  );
}

Widget roundGlassButton(IconData icon) {
  return Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(.07),
      border: Border.all(
        color: Colors.white24,
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0xFF722BFF),
          blurRadius: 14,
        ),
      ],
    ),
    child: Icon(
      icon,
      size: 26,
    ),
  );
}
