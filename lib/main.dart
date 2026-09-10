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
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF08051C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE83BFF),
          brightness: Brightness.dark,
        ),
        fontFamily: 'sans',
      ),
      home: const MainShell(),
    );
  }
}

// ---------------- SONG MODEL ----------------

class Song {
  final String title;
  final String artist;
  final String number;
  final IconData icon;

  const Song({
    required this.title,
    required this.artist,
    required this.number,
    required this.icon,
  });
}

const List<Song> songs = [
  Song(
    title: 'Perfect',
    artist: 'Ed Sheeran',
    number: '01',
    icon: Icons.music_note_rounded,
  ),
  Song(
    title: 'Kesariya',
    artist: 'Arijit Singh',
    number: '02',
    icon: Icons.favorite_rounded,
  ),
  Song(
    title: 'Tum Hi Ho',
    artist: 'Arijit Singh',
    number: '03',
    icon: Icons.mic_rounded,
  ),
  Song(
    title: 'Apna Bana Le',
    artist: 'Arijit Singh',
    number: '04',
    icon: Icons.headphones_rounded,
  ),
  Song(
    title: 'Heeriye',
    artist: 'Jasleen Royal',
    number: '05',
    icon: Icons.graphic_eq_rounded,
  ),
  Song(
    title: 'Chaleya',
    artist: 'Arijit Singh',
    number: '06',
    icon: Icons.music_note_rounded,
  ),
];

// ---------------- MAIN SHELL ----------------

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    ExplorePage(),
    RoomsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            bottom: false,
            child: pages[selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: const Color(0xFF100B2C),
        selectedItemColor: const Color(0xFFFF4FD8),
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_rounded),
            label: 'Rooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ---------------- BACKGROUND ----------------

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF09051E),
            Color(0xFF16082D),
            Color(0xFF09051B),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -80,
            child: GlowCircle(
              size: 260,
              color: const Color(0xFFE92DFF),
            ),
          ),
          Positioned(
            top: 300,
            left: -120,
            child: GlowCircle(
              size: 240,
              color: const Color(0xFF583CFF),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -50,
            child: GlowCircle(
              size: 220,
              color: const Color(0xFFB02CFF),
            ),
          ),
        ],
      ),
    );
  }
}

class GlowCircle extends StatelessWidget {
  final double size;
  final Color color;

  const GlowCircle({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.08),
      ),
    );
  }
}

// ---------------- HOME ----------------

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(),
          const SizedBox(height: 22),
          const HeroCard(),
          const SizedBox(height: 28),
          const SectionTitle(
            title: 'Choose your vibe',
            subtitle: 'Find your perfect karaoke mood',
          ),
          const SizedBox(height: 14),
          const CategoryRow(),
          const SizedBox(height: 28),
          SectionTitle(
            title: 'Popular songs',
            subtitle: 'Sing what everyone loves',
            action: 'See all',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllSongsPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          ...songs.take(4).map(
                (song) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SongCard(song: song),
                ),
              ),
        ],
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF4FCF),
                Color(0xFF754CFF),
              ],
            ),
          ),
          child: const Icon(
            Icons.mic_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back 👋',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Ready to sing?',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No new notifications'),
              ),
            );
          },
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }
}

// ---------------- HERO ----------------

class HeroCard extends StatelessWidget {
  const HeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFB92BFF),
            Color(0xFF632DFF),
            Color(0xFF3020A5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x665D24FF),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '🔥 TRENDING NOW',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Your voice.\nYour stage.',
            style: TextStyle(
              fontSize: 30,
              height: 1.05,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Sing your favourite songs and\nmake every moment memorable.',
            style: TextStyle(
              color: Colors.white70,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const KaraokeStudioPage(
                    song: songs[0],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.mic_rounded),
            label: const Text('Start singing'),
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFF47115F),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 13,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- SECTION TITLE ----------------

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? action;
  final VoidCallback? onTap;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.action,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onTap,
            child: Text(
              action!,
              style: const TextStyle(
                color: Color(0xFFFF55D8),
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------- CATEGORY ----------------

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      ['🔥', 'Trending'],
      ['💖', 'Love'],
      ['🎧', 'Chill'],
      ['⚡', 'Party'],
    ];

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return CategoryChip(
            emoji: categories[index][0],
            title: categories[index][1],
          );
        },
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String emoji;
  final String title;

  const CategoryChip({
    super.key,
    required this.emoji,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- SONG CARD ----------------

class SongCard extends StatelessWidget {
  final Song song;

  const SongCard({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => KaraokeStudioPage(song: song),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.055),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.07),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF4FD8),
                    Color(0xFF654CFF),
                  ],
                ),
              ),
              child: Icon(
                song.icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    song.artist,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.play_circle_fill_rounded,
              color: Color(0xFFFF55D8),
              size: 34,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- EXPLORE ----------------

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = songs.where((song) {
      final text =
          '${song.title} ${song.artist}'.toLowerCase();
      return text.contains(query.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Explore',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Discover your next favourite song',
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search songs or artists...',
                  prefixIcon:
                      const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.07),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SongCard(song: filtered[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ---------------- ROOMS ----------------

class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Karaoke Rooms',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Sing together with your friends',
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF7D38FF),
                  Color(0xFFE62DFF),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.groups_rounded,
                  size: 45,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Create your room',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Invite friends and start singing together.',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Create Room'),
                        content: const Text(
                          'Your karaoke room is ready to create!',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Create room'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Live rooms',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          const RoomTile(
            name: 'Music Lovers',
            people: '12 singers',
            icon: Icons.music_note_rounded,
          ),
          const RoomTile(
            name: 'Late Night Vibes',
            people: '8 singers',
            icon: Icons.nightlight_round,
          ),
          const RoomTile(
            name: 'Bollywood Hits',
            people: '15 singers',
            icon: Icons.movie_rounded,
          ),
        ],
      ),
    );
  }
}

class RoomTile extends StatelessWidget {
  final String name;
  final String people;
  final IconData icon;

  const RoomTile({
    super.key,
    required this.name,
    required this.people,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF43D0),
                  Color(0xFF694CFF),
                ],
              ),
            ),
            child: Icon(icon),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  people,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.white54,
          ),
        ],
      ),
    );
  }
}

// ---------------- PROFILE ----------------

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundColor: Color(0xFF8B3DFF),
            child: Icon(
              Icons.person_rounded,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Karaoke Singer',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '@singer',
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: ProfileStat(
                  value: '24',
                  label: 'Songs',
                ),
              ),
              Expanded(
                child: ProfileStat(
                  value: '8',
                  label: 'Rooms',
                ),
              ),
              Expanded(
                child: ProfileStat(
                  value: '1.2K',
                  label: 'Likes',
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          ProfileOption(
            icon: Icons.favorite_rounded,
            title: 'My favourites',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllSongsPage(),
                ),
              );
            },
          ),
          ProfileOption(
            icon: Icons.history_rounded,
            title: 'Singing history',
            onTap: () {},
          ),
          ProfileOption(
            icon: Icons.settings_rounded,
            title: 'Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsPage(),
                ),
              );
            },
          ),
          ProfileOption(
            icon: Icons.info_outline_rounded,
            title: 'About Karaoke',
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Karaoke',
                applicationVersion: '1.0.0',
                children: const [
                  Text(
                    'Sing your favourite songs and enjoy karaoke.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const ProfileStat({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          color: const Color(0xFFFF55D8),
        ),
      ),
      title: Text(title),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Colors.white54,
      ),
    );
  }
}

// ---------------- ALL SONGS ----------------

class AllSongsPage extends StatelessWidget {
  const AllSongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08051C),
      appBar: AppBar(
        title: const Text('All Songs'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SongCard(song: songs[index]),
          );
        },
      ),
    );
  }
}

// ---------------- KARAOKE STUDIO ----------------

class KaraokeStudioPage extends StatefulWidget {
  final Song song;

  const KaraokeStudioPage({
    super.key,
    required this.song,
  });

  @override
  State<KaraokeStudioPage> createState() =>
      _KaraokeStudioPageState();
}

class _KaraokeStudioPageState
    extends State<KaraokeStudioPage> {
  bool playing = false;
  bool liked = false;
  double progress = 0.25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070417),
      appBar: AppBar(
        title: const Text('Karaoke Studio'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                liked = !liked;
              });
            },
            icon: Icon(
              liked
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: liked
                  ? const Color(0xFFFF4FCF)
                  : Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF42CF),
                    Color(0xFF654CFF),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x665F2DFF),
                    blurRadius: 45,
                    spreadRadius: 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.mic_rounded,
                size: 95,
              ),
            ),
            const SizedBox(height: 35),
            Text(
              widget.song.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              widget.song.artist,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 35),
            Slider(
              value: progress,
              onChanged: (value) {
                setState(() {
                  progress = value;
                });
              },
              activeColor: const Color(0xFFFF4FCF),
            ),
            const Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '01:12',
                  style: TextStyle(color: Colors.white54),
                ),
                Text(
                  '04:10',
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.replay_10_rounded,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 18),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      playing = !playing;
                    });
                  },
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF4FCF),
                          Color(0xFF684CFF),
                        ],
                      ),
                    ),
                    child: Icon(
                      playing
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 42,
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.forward_10_rounded,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Microphone mode is ready!',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.mic_rounded),
                label: const Text('Start Singing'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  backgroundColor:
                      const Color(0xFFFF4FCF),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// ---------------- SETTINGS ----------------

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() =>
      _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
  bool darkMode = true;
  bool autoPlay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08051C),
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Preferences',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            value: notifications,
            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
            title: const Text('Notifications'),
            subtitle: const Text(
              'Get updates about songs and rooms',
            ),
          ),
          SwitchListTile(
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
            title: const Text('Dark mode'),
            subtitle: const Text(
              'Use the dark karaoke theme',
            ),
          ),
          SwitchListTile(
            value: autoPlay,
            onChanged: (value) {
              setState(() {
                autoPlay = value;
              });
            },
            title: const Text('Auto play'),
            subtitle: const Text(
              'Automatically start the next song',
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.lock_outline_rounded),
            title: const Text('Privacy'),
            trailing: const Icon(
              Icons.chevron_right_rounded,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help_outline_rounded),
            title: const Text('Help & Support'),
            trailing: const Icon(
              Icons.chevron_right_rounded,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
