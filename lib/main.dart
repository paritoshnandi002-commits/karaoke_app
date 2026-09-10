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
        fontFamily: 'sans',
        scaffoldBackgroundColor: const Color(0xFF05021D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF20C8),
          brightness: Brightness.dark,
        ),
      ),
      home: const MainShell(),
    );
  }
}

class Song {
  final String title;
  final String artist;
  final String category;
  final String emoji;

  const Song({
    required this.title,
    required this.artist,
    required this.category,
    required this.emoji,
  });
}

const List<Song> songs = [
  Song(
    title: 'Tum Hi Ho',
    artist: 'Arijit Singh',
    category: 'Popular',
    emoji: '🌅',
  ),
  Song(
    title: 'Kesariya',
    artist: 'Arijit Singh',
    category: 'Trending',
    emoji: '🌙',
  ),
  Song(
    title: 'Apna Bana Le',
    artist: 'Arijit Singh',
    category: 'For You',
    emoji: '🌄',
  ),
  Song(
    title: "Let's Sing Together",
    artist: 'Karaoke Original',
    category: 'For You',
    emoji: '🎵',
  ),
  Song(
    title: 'Raataan Lambiyan',
    artist: 'Jubin Nautiyal',
    category: 'Trending',
    emoji: '🌌',
  ),
  Song(
    title: 'Chaleya',
    artist: 'Arijit Singh',
    category: 'Popular',
    emoji: '💜',
  ),
  Song(
    title: 'Heeriye',
    artist: 'Jasleen Royal',
    category: 'Popular',
    emoji: '💕',
  ),
  Song(
    title: 'Agar Tum Saath Ho',
    artist: 'Alka Yagnik',
    category: 'Sad',
    emoji: '🌧️',
  ),
];

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int currentIndex = 0;
  Song? playingSong;
  final Set<String> favorites = {};

  void selectTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void toggleFavorite(Song song) {
    setState(() {
      if (favorites.contains(song.title)) {
        favorites.remove(song.title);
      } else {
        favorites.add(song.title);
      }
    });
  }

  void playSong(Song song) {
    setState(() {
      playingSong = song;
    });
  }

  void openSong(Song song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SongDetailPage(
          song: song,
          isFavorite: favorites.contains(song.title),
          isPlaying: playingSong?.title == song.title,
          onPlay: () => playSong(song),
          onFavorite: () => toggleFavorite(song),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        playingSong: playingSong,
        favorites: favorites,
        onPlay: playSong,
        onFavorite: toggleFavorite,
        onOpenSong: openSong,
        onExplore: () => selectTab(1),
      ),
      ExplorePage(
        playingSong: playingSong,
        favorites: favorites,
        onPlay: playSong,
        onFavorite: toggleFavorite,
        onOpenSong: openSong,
      ),
      const SizedBox(),
      const RoomPage(),
      ProfilePage(
        favorites: favorites,
        onSettings: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SettingsPage(),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          const NeonBackground(),
          SafeArea(
            child: IndexedStack(
              index: currentIndex,
              children: pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: NeonBottomBar(
        currentIndex: currentIndex,
        onTap: selectTab,
        onMic: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: const Color(0xFF10082F),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            builder: (_) => const SingSheet(),
          );
        },
      ),
    );
  }
}

// ------------------------------------------------------------
// BACKGROUND
// ------------------------------------------------------------

class NeonBackground extends StatelessWidget {
  const NeonBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 1.3,
          colors: [
            Color(0xFF32106B),
            Color(0xFF100832),
            Color(0xFF05021D),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80,
            left: -70,
            child: _glow(170, const Color(0xFFFF20C8)),
          ),
          Positioned(
            top: 250,
            right: -100,
            child: _glow(210, const Color(0xFF6A20FF)),
          ),
          Positioned(
            bottom: 100,
            left: -100,
            child: _glow(190, const Color(0xFF00A8FF)),
          ),
        ],
      ),
    );
  }

  Widget _glow(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.18),
            blurRadius: 100,
            spreadRadius: 30,
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// HOME
// ------------------------------------------------------------

class HomePage extends StatelessWidget {
  final Song? playingSong;
  final Set<String> favorites;
  final void Function(Song) onPlay;
  final void Function(Song) onFavorite;
  final void Function(Song) onOpenSong;
  final VoidCallback onExplore;

  const HomePage({
    super.key,
    required this.playingSong,
    required this.favorites,
    required this.onPlay,
    required this.onFavorite,
    required this.onOpenSong,
    required this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(),
          const SizedBox(height: 18),
          const HeroBanner(),
          const SizedBox(height: 18),
          CategoryBar(
            onSelected: (category) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$category selected ✨'),
                  duration: const Duration(milliseconds: 800),
                ),
              );
            },
          ),
          const SizedBox(height: 22),
          SectionHeader(
            title: 'Popular Songs',
            subtitle: 'Top trending songs for you 💗',
            onSeeAll: onExplore,
          ),
          const SizedBox(height: 12),
          ...songs.take(4).map(
                (song) => SongTile(
                  song: song,
                  isPlaying: playingSong?.title == song.title,
                  isFavorite: favorites.contains(song.title),
                  onPlay: () => onPlay(song),
                  onFavorite: () => onFavorite(song),
                  onTap: () => onOpenSong(song),
                ),
              ),
          if (playingSong != null) ...[
            const SizedBox(height: 10),
            MiniPlayer(
              song: playingSong!,
              onPlay: () => onPlay(playingSong!),
            ),
          ],
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              colors: [
                Color(0xFFFF7BD9),
                Color(0xFFB66CFF),
              ],
            ).createShader(bounds);
          },
          child: const Icon(
            Icons.music_note,
            size: 48,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xFFFF8DE3),
                    Colors.white,
                    Color(0xFF9C7BFF),
                  ],
                ).createShader(bounds);
              },
              child: const Text(
                'Karaoke',
                style: TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
            const Text(
              'Sing  •  Feel  •  Be You 💗',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFFE6DDF9),
              ),
            ),
          ],
        ),
        const Spacer(),
        GlassIconButton(
          icon: Icons.notifications_none_rounded,
          badge: true,
          onTap: () {},
        ),
        const SizedBox(width: 9),
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF4FCB),
                Color(0xFF713BFF),
              ],
            ),
            border: Border.all(
              color: const Color(0xFFFFA9EE),
              width: 2,
            ),
          ),
          child: const Center(
            child: Text(
              '👧🏻',
              style: TextStyle(fontSize: 26),
            ),
          ),
        ),
      ],
    );
  }
}

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF32126B),
            Color(0xFF111348),
            Color(0xFF50105F),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFCE42FF),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF1CCF).withOpacity(0.22),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -10,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFF31D1).withOpacity(0.35),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            right: 10,
            top: 28,
            child: Text(
              '🎧',
              style: TextStyle(fontSize: 80),
            ),
          ),
          const Positioned(
            right: 32,
            bottom: 32,
            child: Text(
              '🎤',
              style: TextStyle(fontSize: 75),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '♕ Your Voice',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 2),
              ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [
                      Color(0xFFFF8FE6),
                      Color(0xFFFF42B8),
                    ],
                  ).createShader(bounds);
                },
                child: const Text(
                  'Your Stage ♥',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 190,
                child: Text(
                  'Sing your favorite songs\nand connect with people\nwho love music! 💗',
                  style: TextStyle(
                    color: Color(0xFFEAE6F7),
                    height: 1.35,
                    fontSize: 13,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF31C8),
                      Color(0xFF824CFF),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF31C8).withOpacity(0.4),
                      blurRadius: 18,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: const Color(0xFF10082F),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(28),
                          ),
                        ),
                        builder: (_) => const SingSheet(),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.mic_rounded),
                          SizedBox(width: 8),
                          Text(
                            'Sing Now',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// CATEGORIES
// ------------------------------------------------------------

class CategoryBar extends StatelessWidget {
  final void Function(String) onSelected;

  const CategoryBar({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      ['🔥', 'Popular'],
      ['♡', 'Love'],
      ['☆', 'Bengali'],
      ['🎵', 'Hindi'],
      ['☺', 'Sad'],
      ['▦', 'More'],
    ];

    return Container(
      height: 126,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF17104B),
            Color(0xFF0B1944),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF5127A6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: categories.map((item) {
          return GestureDetector(
            onTap: () => onSelected(item[1]),
            child: Column(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFF38C8),
                        Color(0xFF693DFF),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF24CA)
                            .withOpacity(0.28),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      item[0],
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  item[1],
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ------------------------------------------------------------
// SONG TILE
// ------------------------------------------------------------

class SongTile extends StatelessWidget {
  final Song song;
  final bool isPlaying;
  final bool isFavorite;
  final VoidCallback onPlay;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.isFavorite,
    required this.onPlay,
    required this.onFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              const Color(0xFF171950),
              isPlaying
                  ? const Color(0xFF42166B)
                  : const Color(0xFF0D2146),
            ],
          ),
          border: Border.all(
            color: isPlaying
                ? const Color(0xFFFF32D1)
                : const Color(0xFF253E7B),
          ),
          boxShadow: isPlaying
              ? [
                  BoxShadow(
                    color: const Color(0xFFFF20CA)
                        .withOpacity(0.25),
                    blurRadius: 15,
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF4BBD),
                    Color(0xFF3926A7),
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  song.emoji,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    song.artist,
                    style: const TextStyle(
                      color: Color(0xFFBEB9D9),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFE82BAF),
                          Color(0xFF743DFF),
                        ],
                      ),
                    ),
                    child: Text(
                      song.category,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onPlay,
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: isPlaying
                        ? [
                            const Color(0xFFFF25C9),
                            const Color(0xFF7A40FF),
                          ]
                        : [
                            const Color(0xFF238DFF),
                            const Color(0xFF5935FF),
                          ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8D34FF)
                          .withOpacity(0.35),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Icon(
                  isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  size: 29,
                ),
              ),
            ),
            const SizedBox(width: 7),
            GestureDetector(
              onTap: onFavorite,
              child: Icon(
                isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: isFavorite
                    ? const Color(0xFFFF42C9)
                    : const Color(0xFFD9D5EE),
                size: 25,
              ),
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.more_vert_rounded,
              color: Color(0xFFB9B4D5),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// SECTION HEADER
// ------------------------------------------------------------

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    '♕',
                    style: TextStyle(
                      color: Color(0xFFFFD72D),
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFFBEB8D5),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF182557),
              border: Border.all(
                color: const Color(0xFF3156A5),
              ),
            ),
            child: const Row(
              children: [
                Text(
                  'See All',
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------
// MINI PLAYER
// ------------------------------------------------------------

class MiniPlayer extends StatelessWidget {
  final Song song;
  final VoidCallback onPlay;

  const MiniPlayer({
    super.key,
    required this.song,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF21124F),
            Color(0xFF10234C),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF8B3EFF),
        ),
      ),
      child: Row(
        children: [
          Text(
            song.emoji,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  song.artist,
                  style: const TextStyle(
                    color: Color(0xFFAAA5C3),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            '〰〰〰',
            style: TextStyle(
              color: Color(0xFFFF34C7),
              fontSize: 18,
            ),
          ),
          IconButton(
            onPressed: onPlay,
            icon: const Icon(
              Icons.pause_circle_filled_rounded,
              color: Color(0xFFFF35CA),
              size: 39,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// EXPLORE
// ------------------------------------------------------------

class ExplorePage extends StatefulWidget {
  final Song? playingSong;
  final Set<String> favorites;
  final void Function(Song) onPlay;
  final void Function(Song) onFavorite;
  final void Function(Song) onOpenSong;

  const ExplorePage({
    super.key,
    required this.playingSong,
    required this.favorites,
    required this.onPlay,
    required this.onFavorite,
    required this.onOpenSong,
  });

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String search = '';
  String filter = 'All';

  @override
  Widget build(BuildContext context) {
    final filtered = songs.where((song) {
      final matchesSearch =
          song.title.toLowerCase().contains(search.toLowerCase()) ||
              song.artist.toLowerCase().contains(search.toLowerCase());

      final matchesFilter =
          filter == 'All' || song.category == filter;

      return matchesSearch && matchesFilter;
    }).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore',
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search songs, artists, genres...',
              hintStyle: const TextStyle(
                color: Color(0xFF8E89AA),
                fontSize: 13,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
              ),
              suffixIcon: const Icon(
                Icons.tune_rounded,
                size: 20,
              ),
              filled: true,
              fillColor: const Color(0xFF111A49),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: const BorderSide(
                  color: Color(0xFF4431A0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: const BorderSide(
                  color: Color(0xFF4431A0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 120,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF7614A4),
                  Color(0xFF211C7D),
                ],
              ),
              border: Border.all(
                color: const Color(0xFFE040FF),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Find your\nFavorite Song',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Millions of songs\njust for you 💗',
                        style: TextStyle(
                          color: Color(0xFFE2DDF0),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '🎧',
                  style: TextStyle(fontSize: 58),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                'All',
                'Trending',
                'New',
                'Popular',
              ].map((item) {
                final selected = filter == item;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      filter = item;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: selected
                          ? const LinearGradient(
                              colors: [
                                Color(0xFFFF25C8),
                                Color(0xFF923EFF),
                              ],
                            )
                          : const LinearGradient(
                              colors: [
                                Color(0xFF111D4A),
                                Color(0xFF172A55),
                              ],
                            ),
                      ),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFFFF58D7)
                            : const Color(0xFF304A85),
                      ),
                    ),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '🔥 Trending Now',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (filtered.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Text('No songs found 🎵'),
              ),
            ),
          ...filtered.map(
            (song) => SongTile(
              song: song,
              isPlaying:
                  widget.playingSong?.title == song.title,
              isFavorite:
                  widget.favorites.contains(song.title),
              onPlay: () => widget.onPlay(song),
              onFavorite: () => widget.onFavorite(song),
              onTap: () => widget.onOpenSong(song),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            '🎸 Genres',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              GenreCard(
                icon: '🎧',
                title: 'Pop',
              ),
              GenreCard(
                icon: '🎸',
                title: 'Rock',
              ),
              GenreCard(
                icon: '🎹',
                title: 'Classical',
              ),
              GenreCard(
                icon: '〰',
                title: 'EDM',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GenreCard extends StatelessWidget {
  final String icon;
  final String title;

  const GenreCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 92,
        margin: const EdgeInsets.only(right: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF4A16A4),
              Color(0xFF142E70),
            ],
          ),
          border: Border.all(
            color: const Color(0xFF6C38D0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// ROOM
// ------------------------------------------------------------

class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = [
      ['🎤', 'Music Lovers Unite', '12.4K joined'],
      ['🌸', 'Bengali Song Room', '8.7K joined'],
      ['🎶', 'Chill & Sing', '5.2K joined'],
      ['⭐', 'Arijit Singh Special', '4.9K joined'],
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Room',
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _roomTab(
                  'Live Rooms',
                  true,
                  () {},
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _roomTab(
                  'Create Room',
                  false,
                  () {
                    _showMessage(context, 'Create Room ✨');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF6D18A5),
                  Color(0xFF251D77),
                ],
              ),
              border: Border.all(
                color: const Color(0xFFD12EFF),
              ),
            ),
            child: const Row(
              children: [
                Text(
                  '👥',
                  style: TextStyle(fontSize: 45),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Join Live Rooms',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Sing with amazing people\nfrom around the world! 🎤',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFDCD6ED),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            '♕ Popular Rooms',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...rooms.map(
            (room) => Container(
              margin: const EdgeInsets.only(bottom: 9),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: const Color(0xFF0D1740),
                border: Border.all(
                  color: const Color(0xFF273D79),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    room[0],
                    style: const TextStyle(fontSize: 29),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          room[1],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          room[2] + ' • Singing',
                          style: const TextStyle(
                            color: Color(0xFFAAA5C1),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showMessage(
                        context,
                        'Joining ${room[1]} 🎤',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF8B29D8),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Join',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roomTab(
    String text,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: selected
              ? const LinearGradient(
                  colors: [
                    Color(0xFFFF28C8),
                    Color(0xFF8A35FF),
                  ],
                )
              : const LinearGradient(
                  colors: [
                    Color(0xFF17215A),
                    Color(0xFF17215A),
                  ],
                ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// PROFILE
// ------------------------------------------------------------

class ProfilePage extends StatelessWidget {
  final Set<String> favorites;
  final VoidCallback onSettings;

  const ProfilePage({
    super.key,
    required this.favorites,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: onSettings,
                icon: const Icon(
                  Icons.settings_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF1D1550),
                  Color(0xFF101B46),
                ],
              ),
              border: Border.all(
                color: const Color(0xFF5635A4),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 78,
                      height: 78,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF3BC9),
                            Color(0xFF6E3EFF),
                          ],
                        ),
                        border: Border.all(
                          color: const Color(0xFFFFA6EA),
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '👧🏻',
                          style: TextStyle(fontSize: 43),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Paritosh Nandi',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '@paritosh_nandi',
                          style: TextStyle(
                            color: Color(0xFFAAA5C1),
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          '🎵 Music Lover ♡',
                          style: TextStyle(
                            color: Color(0xFFFF63D3),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    profileStat('12', 'Songs'),
                    profileStat('3.4K', 'Followers'),
                    profileStat('56', 'Following'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'My Playlists',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              playlistCard('💗', 'My Favorites',
                  '${favorites.length + 24} songs'),
              playlistCard('🎵', 'Bengali Hits', '18 songs'),
              playlistCard('🌙', 'Chill Vibes', '16 songs'),
              playlistCard('☹️', 'Sad Songs', '12 songs'),
            ],
          ),
          const SizedBox(height: 22),
          profileOption(
            Icons.edit_outlined,
            'Edit Profile',
            () => _showMessage(context, 'Edit Profile'),
          ),
          profileOption(
            Icons.mic_none_rounded,
            'My Room',
            () => _showMessage(context, 'My Room'),
          ),
          profileOption(
            Icons.settings_outlined,
            'Settings',
            onSettings,
          ),
        ],
      ),
    );
  }

  Widget playlistCard(
    String icon,
    String title,
    String songsText,
  ) {
    return Expanded(
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF251C68),
              Color(0xFF102457),
            ],
          ),
          border: Border.all(
            color: const Color(0xFF4D3D99),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9),
            ),
            Text(
              songsText,
              style: const TextStyle(
                color: Color(0xFF9994B4),
                fontSize: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileOption(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFF0C173A),
          border: Border.all(
            color: const Color(0xFF263A70),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFD5D0E9),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 13),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF8883A5),
            ),
          ],
        ),
      ),
    );
  }
}

Widget profileStat(String number, String label) {
  return Expanded(
    child: Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFA7A1C0),
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}

// ------------------------------------------------------------
// SONG DETAIL
// ------------------------------------------------------------

class SongDetailPage extends StatelessWidget {
  final Song song;
  final bool isFavorite;
  final bool isPlaying;
  final VoidCallback onPlay;
  final VoidCallback onFavorite;

  const SongDetailPage({
    super.key,
    required this.song,
    required this.isFavorite,
    required this.isPlaying,
    required this.onPlay,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05021D),
      body: Stack(
        children: [
          const NeonBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: onFavorite,
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: const Color(0xFFFF48CE),
                        ),
                      ),
                      const Icon(Icons.more_vert_rounded),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 330,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFF5CBF),
                          Color(0xFF45209A),
                          Color(0xFF071D50),
                        ],
                      ),
                      border: Border.all(
                        color: const Color(0xFF9C3CFF),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF22CA)
                              .withOpacity(0.3),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        song.emoji,
                        style: const TextStyle(
                          fontSize: 105,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    song.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    song.artist,
                    style: const TextStyle(
                      color: Color(0xFFBEB8D7),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        '1:42',
                        style: TextStyle(fontSize: 10),
                      ),
                      const Expanded(
                        child: Slider(
                          value: 0.35,
                          onChanged: null,
                          activeColor: Color(0xFFFF30C9),
                          inactiveColor: Color(0xFF33305B),
                        ),
                      ),
                      const Text(
                        '4:21',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.shuffle_rounded),
                      const Icon(
                        Icons.skip_previous_rounded,
                        size: 32,
                      ),
                      GestureDetector(
                        onTap: onPlay,
                        child: Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF25C9),
                                Color(0xFF6F35FF),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF24CA)
                                    .withOpacity(0.4),
                                blurRadius: 22,
                              ),
                            ],
                          ),
                          child: Icon(
                            isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            size: 38,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.skip_next_rounded,
                        size: 32,
                      ),
                      const Icon(Icons.repeat_rounded),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF111C48),
                          Color(0xFF16104A),
                        ],
                      ),
                      border: Border.all(
                        color: const Color(0xFF42348A),
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lyrics',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Tum hi ho...\n'
                          'Ab tum hi ho...\n'
                          'Zindagi ab tum hi ho... 💗',
                          style: TextStyle(
                            color: Color(0xFFD3CEE7),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showMessage(
                          context,
                          'Karaoke mode ready 🎤',
                        );
                      },
                      icon: const Icon(Icons.mic_rounded),
                      label: const Text('Karaoke'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        backgroundColor:
                            const Color(0xFF8A2BE2),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// SETTINGS
// ------------------------------------------------------------

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = true;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05021D),
      body: Stack(
        children: [
          const NeonBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                18,
                12,
                18,
                30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                        ),
                      ),
                      const Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF211653),
                          Color(0xFF101C45),
                        ],
                      ),
                      border: Border.all(
                        color: const Color(0xFF4C3298),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          '👧🏻',
                          style: TextStyle(fontSize: 45),
                        ),
                        SizedBox(width: 13),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Paritosh Nandi',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '@paritosh_nandi',
                              style: TextStyle(
                                color: Color(0xFFAAA4C0),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  settingItem(
                    Icons.lock_outline_rounded,
                    'Account & Security',
                    '',
                    () {},
                  ),
                  settingItem(
                    Icons.notifications_none_rounded,
                    'Notifications',
                    '',
                    () {
                      setState(() {
                        notifications = !notifications;
                      });
                    },
                    trailing: Switch(
                      value: notifications,
                      onChanged: (value) {
                        setState(() {
                          notifications = value;
                        });
                      },
                    ),
                  ),
                  settingItem(
                    Icons.palette_outlined,
                    'Appearance',
                    'Dark Mode',
                    () {},
                    trailing: Switch(
                      value: darkMode,
                      onChanged: (value) {
                        setState(() {
                          darkMode = value;
                        });
                      },
                    ),
                  ),
                  settingItem(
                    Icons.language_rounded,
                    'Language',
                    'English',
                    () {},
                  ),
                  settingItem(
                    Icons.privacy_tip_outlined,
                    'Privacy Policy',
                    '',
                    () {},
                  ),
                  settingItem(
                    Icons.help_outline_rounded,
                    'Help & Support',
                    '',
                    () {},
                  ),
                  settingItem(
                    Icons.info_outline_rounded,
                    'About App',
                    'Version 1.0.0',
                    () {},
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showMessage(
                          context,
                          'Logged out',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFFF24B8),
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text('Log Out'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget settingItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    Widget? trailing,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 7),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xFF0B1639),
          border: Border.all(
            color: const Color(0xFF202F61),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFD7D2E9),
              size: 21,
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF89849F),
                        fontSize: 9,
                      ),
                    ),
                ],
              ),
            ),
            trailing ??
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF7C7897),
                ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// BOTTOM NAVIGATION
// ------------------------------------------------------------

class NeonBottomBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  final VoidCallback onMic;

  const NeonBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onMic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: const Color(0xFF080528).withOpacity(0.97),
        border: const Border(
          top: BorderSide(
            color: Color(0xFF302270),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFAA25FF).withOpacity(0.18),
            blurRadius: 25,
          ),
        ],
      ),
      child: Row(
        children: [
          navItem(
            Icons.home_rounded,
            'Home',
            0,
          ),
          navItem(
            Icons.explore_outlined,
            'Explore',
            1,
          ),
          Expanded(
            child: GestureDetector(
              onTap: onMic,
              child: Center(
                child: Container(
                  width: 67,
                  height: 67,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFF32CB),
                        Color(0xFF7040FF),
                      ],
                    ),
                    border: Border.all(
                      color: const Color(0xFFDCACFF),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF21CC)
                            .withOpacity(0.45),
                        blurRadius: 22,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.mic_rounded,
                    size: 34,
                  ),
                ),
              ),
            ),
          ),
          navItem(
            Icons.groups_outlined,
            'Room',
            3,
          ),
          navItem(
            Icons.person_outline_rounded,
            'Profile',
            4,
          ),
        ],
      ),
    );
  }

  Widget navItem(
    IconData icon,
    String title,
    int index,
  ) {
    final selected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: selected
                  ? const Color(0xFFFF4DD1)
                  : const Color(0xFFC0BBD8),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: selected
                    ? const Color(0xFFFF4DD1)
                    : const Color(0xFFC0BBD8),
                fontWeight: selected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            if (selected)
              Container(
                margin: const EdgeInsets.only(top: 3),
                width: 25,
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFFF42CE),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// SMALL WIDGETS
// ------------------------------------------------------------

class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final bool badge;
  final VoidCallback onTap;

  const GlassIconButton({
    super.key,
    required this.icon,
    required this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF29174F),
              border: Border.all(
                color: const Color(0xFF7135A2),
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          if (badge)
            Positioned(
              right: 3,
              top: 3,
              child: Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFF3ABF),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SingSheet extends StatelessWidget {
  const SingSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          22,
          15,
          22,
          25,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 45,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF6D6590),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '🎤  Ready to Sing?',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose a song and let your voice shine ✨',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFB6B0CC),
              ),
            ),
            const SizedBox(height: 22),
            _sheetButton(
              context,
              Icons.search_rounded,
              'Choose a Song',
            ),
            _sheetButton(
              context,
              Icons.mic_rounded,
              'Start Karaoke',
            ),
            _sheetButton(
              context,
              Icons.groups_rounded,
              'Join a Room',
            ),
          ],
        ),
      ),
    );
  }

  Widget _sheetButton(
    BuildContext context,
    IconData icon,
    String text,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context);
          _showMessage(context, '$text 🎵');
        },
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF211650),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

void _showMessage(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xFF641A88),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
