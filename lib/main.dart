import 'dart:async';
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
      theme: ThemeData.dark(useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}

// =====================================================
// SPLASH
// =====================================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainNavigation(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030014),
      body: Stack(
        children: [
          glow(
            420,
            const Color(0xFF7B24FF),
            left: -120,
            top: 120,
          ),
          glow(
            330,
            const Color(0xFFFF18C8),
            right: -100,
            bottom: 100,
          ),
          glow(
            240,
            const Color(0xFF00CFFF),
            left: -70,
            bottom: -50,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFF21CF),
                        Color(0xFF744CFF),
                        Color(0xFF20DFFF),
                      ],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFFF19D0),
                        blurRadius: 50,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.mic_rounded,
                    size: 78,
                  ),
                ),

                const SizedBox(height: 35),

                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        Color(0xFFFF55D8),
                        Color(0xFF9A65FF),
                        Color(0xFF48E8FF),
                      ],
                    ).createShader(bounds);
                  },
                  child: const Text(
                    'Karaoke',
                    style: TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Sing  •  Feel  •  Be You ♥',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 70),

                const SizedBox(
                  width: 120,
                  child: LinearProgressIndicator(
                    minHeight: 4,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// MAIN NAVIGATION
// =====================================================

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    ExplorePage(),
    RoomPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030014),
      extendBody: true,
      body: pages[currentIndex],

      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            height: 82,
            decoration: BoxDecoration(
              color: const Color(0xFF090624).withOpacity(.94),
              border: Border(
                top: BorderSide(
                  color: const Color(0xFF9B45FF).withOpacity(.55),
                ),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF5B1DFF),
                  blurRadius: 25,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [
                bottomItem(
                  Icons.home_rounded,
                  'Home',
                  0,
                ),
                bottomItem(
                  Icons.explore_rounded,
                  'Explore',
                  1,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PlayerPage(
                          song: 'Tum Hi Ho',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 68,
                    height: 68,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF20CA),
                          Color(0xFF694DFF),
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
                          color: Color(0xFFFF18D0),
                          blurRadius: 28,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.mic_rounded,
                      size: 35,
                    ),
                  ),
                ),

                bottomItem(
                  Icons.groups_rounded,
                  'Room',
                  2,
                ),
                bottomItem(
                  Icons.person_outline_rounded,
                  'Profile',
                  3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomItem(
    IconData icon,
    String title,
    int index,
  ) {
    final bool selected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 27,
            color: selected
                ? const Color(0xFFFF50DA)
                : Colors.white60,
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: selected
                  ? const Color(0xFFFF50DA)
                  : Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// HOME
// =====================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void message(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF21134D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final songs = [
      ['Tum Hi Ho', 'Arijit Singh', Icons.favorite_rounded],
      ['Kesariya', 'Arijit Singh', Icons.nightlight_round],
      ['Apna Bana Le', 'Arijit Singh', Icons.music_note_rounded],
      ['Let’s Sing Together', 'Music connects hearts', Icons.graphic_eq],
    ];

    return Stack(
      children: [
        background(),

        SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    20,
                    10,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.music_note_rounded,
                        size: 48,
                        color: Color(0xFFFF5BDD),
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
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              'Sing  •  Feel  •  Be You ♥',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      circleButton(
                        Icons.notifications_none_rounded,
                        () {
                          message(
                            context,
                            '🔔 No new notifications',
                          );
                        },
                      ),

                      const SizedBox(width: 9),

                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0xFFFF39D1),
                        child: Icon(
                          Icons.person_rounded,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // HERO
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: glossyBox(
                    height: 300,
                    child: Stack(
                      children: [
                        Positioned(
                          right: -60,
                          top: -70,
                          child: glowCircle(
                            260,
                            const Color(0xFFFF21D2),
                          ),
                        ),

                        Positioned(
                          right: 25,
                          bottom: 35,
                          child: Container(
                            width: 110,
                            height: 145,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(60),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF302052),
                                  Color(0xFF090719),
                                ],
                              ),
                              border: Border.all(
                                color: const Color(0xFFFF4DDA),
                                width: 2,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFFFF18D0),
                                  blurRadius: 28,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.mic_rounded,
                              size: 70,
                              color: Color(0xFFFF70E1),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '♛  Your Voice',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),

                              ShaderMask(
                                shaderCallback: (bounds) {
                                  return const LinearGradient(
                                    colors: [
                                      Color(0xFFFF6EDB),
                                      Color(0xFFB38AFF),
                                    ],
                                  ).createShader(bounds);
                                },
                                child: const Text(
                                  'Your Stage ♥',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 37,
                                    fontWeight: FontWeight.w900,
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
                                  color: Colors.white70,
                                  fontSize: 15,
                                  height: 1.4,
                                ),
                              ),

                              const Spacer(),

                              gradientButton(
                                'Sing Now',
                                Icons.mic_rounded,
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const PlayerPage(
                                        song: 'Tum Hi Ho',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
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
                  height: 95,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    children: [
                      category(
                        context,
                        '🔥',
                        'Popular',
                      ),
                      category(
                        context,
                        '♡',
                        'Love',
                      ),
                      category(
                        context,
                        '☆',
                        'Bengali',
                      ),
                      category(
                        context,
                        '♫',
                        'Hindi',
                      ),
                      category(
                        context,
                        '☺',
                        'Sad',
                      ),
                      category(
                        context,
                        '▦',
                        'More',
                      ),
                    ],
                  ),
                ),
              ),

              // TITLE
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    22,
                    15,
                    20,
                    10,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        '♛',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFFFFD83D),
                        ),
                      ),
                      const SizedBox(width: 9),
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
                              'Top trending songs for you ♥',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const ExplorePage(),
                            ),
                          );
                        },
                        child: const Text(
                          'See All ›',
                        ),
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

                    return songCard(
                      context,
                      number: '${index + 1}',
                      title: song[0] as String,
                      artist: song[1] as String,
                      icon: song[2] as IconData,
                    );
                  },
                  childCount: songs.length,
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 120),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================
// EXPLORE
// =====================================================

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController search = TextEditingController();

  final songs = [
    'Raataan Lambiyan',
    'Chaleya',
    'Kesariya',
    'Heeriye',
    'Tum Hi Ho',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background(),

        SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              120,
            ),
            children: [
              const Text(
                'Explore',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              // SEARCH
              Container(
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFF17133C),
                  border: Border.all(
                    color: const Color(0xFF714BFF),
                  ),
                ),
                child: TextField(
                  controller: search,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                    ),
                    hintText:
                        'Search songs, artists, genres...',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              glossyBox(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Find your\nFavorite Song',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Millions of songs just for you ♥',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFF21CF),
                              Color(0xFF544BFF),
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.headphones_rounded,
                          size: 43,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'Trending Now',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              ...songs
                  .where(
                    (s) => s.toLowerCase().contains(
                          search.text.toLowerCase(),
                        ),
                  )
                  .map(
                    (song) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: 9),
                      child: smallSongCard(
                        context,
                        song,
                      ),
                    ),
                  ),

              const SizedBox(height: 18),

              const Text(
                'Genres',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  genre('🎧', 'Pop'),
                  genre('🎸', 'Rock'),
                  genre('🎹', 'Classic'),
                  genre('〰', 'EDM'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================
// PLAYER
// =====================================================

class PlayerPage extends StatefulWidget {
  final String song;

  const PlayerPage({
    super.key,
    required this.song,
  });

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030014),
      body: Stack(
        children: [
          background(),

          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    backButton(context),
                    const Spacer(),
                    const Icon(
                      Icons.more_vert_rounded,
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // ART
                Container(
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFF5BBE),
                        Color(0xFF5635D9),
                        Color(0xFF07143E),
                      ],
                    ),
                    border: Border.all(
                      color: const Color(0xFFB94FFF),
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF9D22FF),
                        blurRadius: 35,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 25,
                        right: 25,
                        child: Icon(
                          Icons.favorite_border_rounded,
                          size: 30,
                        ),
                      ),

                      Center(
                        child: Container(
                          width: 150,
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(80),
                            color: const Color(0xFF100A35)
                                .withOpacity(.7),
                            border: Border.all(
                              color: Colors.white54,
                            ),
                          ),
                          child: const Icon(
                            Icons.music_note_rounded,
                            size: 90,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      Positioned(
                        left: 25,
                        bottom: 25,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.song,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Arijit Singh',
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Slider(
                  value: playing ? .55 : .22,
                  onChanged: (_) {},
                ),

                const Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1:42'),
                    Text('4:21'),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.shuffle_rounded),
                    const Icon(
                      Icons.skip_previous_rounded,
                      size: 35,
                    ),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          playing = !playing;
                        });
                      },
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFF20CE),
                              Color(0xFF684BFF),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFFF20D0),
                              blurRadius: 25,
                            ),
                          ],
                        ),
                        child: Icon(
                          playing
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 43,
                        ),
                      ),
                    ),

                    const Icon(
                      Icons.skip_next_rounded,
                      size: 35,
                    ),
                    const Icon(
                      Icons.repeat_rounded,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                glossyBox(
                  height: 120,
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lyrics',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Sing along with your favorite song ♥',
                          style: TextStyle(
                            color: Colors.white70,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                gradientButton(
                  'Start Karaoke',
                  Icons.mic_rounded,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          '🎤 Karaoke mode is ready!',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// ROOM
// =====================================================

class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background(),

        SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              120,
            ),
            children: [
              const Text(
                'Room',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                    child: gradientButton(
                      'Live Rooms',
                      Icons.groups_rounded,
                      () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: glassButtonLarge(
                      'Create Room',
                      Icons.add_rounded,
                      () {},
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              glossyBox(
                height: 140,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.groups_rounded,
                        size: 48,
                        color: Color(0xFFFF4CD8),
                      ),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                              'Join Live Rooms',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Sing with amazing people\n'
                              'from around the world! ♥',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                '♛  Popular Rooms',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              roomCard(
                context,
                'Music Lovers Unite ♥',
                '12.4K joined',
              ),
              roomCard(
                context,
                'Bengali Song Room',
                '8.7K joined',
              ),
              roomCard(
                context,
                'Chill & Sing 🎵',
                '5.2K joined',
              ),
              roomCard(
                context,
                'Arijit Singh Special',
                '4.9K joined',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================
// PROFILE
// =====================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background(),

        SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              120,
            ),
            children: [
              Row(
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const SettingsPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.settings_outlined,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              glossyBox(
                height: 210,
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFF2BCD),
                                  Color(0xFF674DFF),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              size: 45,
                            ),
                          ),

                          const SizedBox(width: 15),

                          const Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Paritosh Nandi',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '@paritosh_nandi',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '🎵 Music Lover ♥',
                                style: TextStyle(
                                  color: Color(0xFFFF55D8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const Spacer(),

                      const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                        children: [
                          profileStat('12', 'Songs'),
                          profileStat('3.4K', 'Followers'),
                          profileStat('56', 'Following'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'My Playlists',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  playlist('♥', 'Favorites'),
                  playlist('♫', 'Bengali Hits'),
                  playlist('☾', 'Chill Vibes'),
                  playlist('☹', 'Sad Songs'),
                ],
              ),

              const SizedBox(height: 25),

              profileMenu(
                context,
                Icons.edit_rounded,
                'Edit Profile',
              ),
              profileMenu(
                context,
                Icons.mic_none_rounded,
                'My Room',
              ),
              profileMenu(
                context,
                Icons.settings_outlined,
                'Settings',
                openSettings: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================
// SETTINGS
// =====================================================

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030014),
      body: Stack(
        children: [
          background(),

          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    backButton(context),
                    const SizedBox(width: 15),
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFFF2BD0),
                    child: Icon(Icons.person),
                  ),
                  title: Text(
                    'Paritosh Nandi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('@paritosh_nandi'),
                ),

                const SizedBox(height: 15),

                settingItem(
                  Icons.lock_outline_rounded,
                  'Account & Security',
                ),
                settingItem(
                  Icons.notifications_none_rounded,
                  'Notifications',
                ),
                settingItem(
                  Icons.palette_outlined,
                  'Appearance',
                  trailing: const Text(
                    'Dark Mode',
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                ),
                settingItem(
                  Icons.language_rounded,
                  'Language',
                  trailing: const Text(
                    'English',
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                ),
                settingItem(
                  Icons.privacy_tip_outlined,
                  'Privacy Policy',
                ),
                settingItem(
                  Icons.help_outline_rounded,
                  'Help & Support',
                ),
                settingItem(
                  Icons.info_outline_rounded,
                  'About App',
                  trailing: const Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                gradientButton(
                  'Log Out',
                  Icons.logout_rounded,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'You are still logged in ♥',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// REUSABLE WIDGETS
// =====================================================

Widget background() {
  return Stack(
    children: [
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF08032B),
              Color(0xFF030014),
              Color(0xFF090127),
            ],
          ),
        ),
      ),

      glow(
        300,
        const Color(0xFFFF1EC8),
        left: -160,
        top: 100,
      ),

      glow(
        320,
        const Color(0xFF5030FF),
        right: -150,
        top: 350,
      ),

      glow(
        240,
        const Color(0xFF00D9FF),
        left: -100,
        bottom: 100,
      ),
    ],
  );
}

Widget glow(
  double size,
  Color color, {
  double? left,
  double? right,
  double? top,
  double? bottom,
}) {
  return Positioned(
    left: left,
    right: right,
    top: top,
    bottom: bottom,
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(.42),
            color.withOpacity(.08),
            Colors.transparent,
          ],
        ),
      ),
    ),
  );
}

Widget glowCircle(
  double size,
  Color color,
) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [
          color.withOpacity(.4),
          Colors.transparent,
        ],
      ),
    ),
  );
}

Widget glossyBox({
  required double height,
  required Widget child,
}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF30205A),
          Color(0xFF15133A),
          Color(0xFF0D0A29),
        ],
      ),
      border: Border.all(
        color: const Color(0xFF9A43FF),
        width: 1.2,
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0xFF6520FF),
          blurRadius: 25,
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: child,
    ),
  );
}

Widget circleButton(
  IconData icon,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(.07),
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Icon(icon),
    ),
  );
}

Widget gradientButton(
  String text,
  IconData icon,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 52,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFF20CA),
            Color(0xFF714BFF),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFFF1DD0),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget category(
  BuildContext context,
  String icon,
  String name,
) {
  return GestureDetector(
    onTap: () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$name songs'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    },
    child: Container(
      width: 76,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF28164C),
            Color(0xFF10102F),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF7048D9),
        ),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Text(
            icon,
            style: const TextStyle(
              fontSize: 27,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(
              fontSize: 11,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget songCard(
  BuildContext context, {
  required String number,
  required String title,
  required String artist,
  required IconData icon,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 5,
    ),
    child: Container(
      height: 92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF191643),
            Color(0xFF101A43),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF6252D9),
        ),
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
                  Color(0xFFFF2DCB),
                  Color(0xFF5147FF),
                ],
              ),
            ),
            child: Icon(
              icon,
              size: 33,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  artist,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlayerPage(
                    song: title,
                  ),
                ),
              );
            },
            child: Container(
              width: 47,
              height: 47,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFF20CC),
                    Color(0xFF694CFF),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFF20D0),
                    blurRadius: 16,
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

          const Icon(
            Icons.favorite_border_rounded,
            color: Colors.white70,
          ),

          const SizedBox(width: 10),

          const Icon(
            Icons.more_vert_rounded,
            color: Colors.white54,
          ),

          const SizedBox(width: 9),
        ],
      ),
    ),
  );
}

Widget smallSongCard(
  BuildContext context,
  String song,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PlayerPage(
            song: song,
          ),
        ),
      );
    },
    child: Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF17143C),
            Color(0xFF111B45),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF513FD0),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),

          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF25CD),
                  Color(0xFF574CFF),
                ],
              ),
            ),
            child: const Icon(
              Icons.music_note_rounded,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              song,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Icon(
            Icons.favorite_border_rounded,
          ),

          const SizedBox(width: 12),

          const Icon(
            Icons.play_circle_fill_rounded,
            color: Color(0xFFFF39D1),
            size: 35,
          ),

          const SizedBox(width: 10),
        ],
      ),
    ),
  );
}

Widget genre(String icon, String name) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.only(right: 8),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF5A24A7),
            Color(0xFF202B83),
          ],
        ),
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Text(
            icon,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(
              fontSize: 11,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget roomCard(
  BuildContext context,
  String title,
  String joined,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    height: 75,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      gradient: const LinearGradient(
        colors: [
          Color(0xFF191440),
          Color(0xFF111B42),
        ],
      ),
      border: Border.all(
        color: const Color(0xFF5E4BD5),
      ),
    ),
    child: Row(
      children: [
        const SizedBox(width: 12),

        const CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xFFFF27CA),
          child: Icon(Icons.music_note),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$joined • Singing',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF20CA),
                Color(0xFF714BFF),
              ],
            ),
          ),
          child: const Text(
            'Join',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 10),
      ],
    ),
  );
}

Widget glassButtonLarge(
  String text,
  IconData icon,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: const Color(0xFF17133F),
        border: Border.all(
          color: const Color(0xFF604BD1),
        ),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(icon, size: 19),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget profileStat(
  String number,
  String title,
) {
  return Column(
    children: [
      Text(
        number,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        title,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 11,
        ),
      ),
    ],
  );
}

Widget playlist(
  String icon,
  String title,
) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.only(right: 7),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF28165D),
            Color(0xFF17163D),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF5E4BD0),
        ),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Text(
            icon,
            style: const TextStyle(
              fontSize: 25,
              color: Color(0xFFFF55D9),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 9,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget profileMenu(
  BuildContext context,
  IconData icon,
  String title, {
  bool openSettings = false,
}) {
  return GestureDetector(
    onTap: () {
      if (openSettings) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SettingsPage(),
          ),
        );
      }
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
      ),
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xFF0F1031),
        border: Border.all(
          color: Colors.white12,
        ),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 14),
          Expanded(
            child: Text(title),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
        ],
      ),
    ),
  );
}

Widget settingItem(
  IconData icon,
  String title, {
  Widget? trailing,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 7),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: const Color(0xFF0D0E30),
      border: Border.all(
        color: Colors.white12,
      ),
    ),
    child: ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      trailing: trailing ??
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
    ),
  );
}

Widget backButton(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(.07),
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: const Icon(
        Icons.arrow_back_rounded,
      ),
    ),
  );
}
