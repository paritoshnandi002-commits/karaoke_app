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
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF07051D),
        fontFamily: 'sans',
      ),
      home: const MainShell(),
    );
  }
}
class Song {
  final String title;
  final String artist;
  final String emoji;
  const Song(this.title, this.artist, this.emoji);
}
const songs = <Song>[
  Song('Kesariya', 'Arijit Singh', '🎵'),
  Song('Tum Hi Ho', 'Arijit Singh', '❤️'),
  Song('Apna Bana Le', 'Arijit Singh', '✨'),
  Song('Heeriye', 'Jasleen Royal', '🌸'),
  Song('Chaleya', 'Arijit Singh', '💜'),
  Song('Tujhe Kitna Chahne Lage', 'Arijit Singh', '🎤'),
];
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}
class _MainShellState extends State<MainShell> {
  int index = 0;
  final pages = const [
    HomePage(),
    ExplorePage(),
    RoomPage(),
    ProfilePage(),
  ];
  void openStudio() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const KaraokeStudioPage(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
          child: GlassCard(
            radius: 28,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                navItem(Icons.home_rounded, 'Home', 0),
                navItem(Icons.explore_rounded, 'Explore', 1),
                GestureDetector(
                  onTap: openStudio,
                  child: Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFF4FA3),
                          Color(0xFF8D5CFF),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF4FA3)
                              .withOpacity(.35),
                          blurRadius: 22,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.mic_rounded,
                      size: 30,
                    ),
                  ),
                ),
                navItem(Icons.people_alt_rounded, 'Rooms', 2),
                navItem(Icons.person_rounded, 'Profile', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget navItem(IconData icon, String text, int itemIndex) {
    final selected = index == itemIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          index = itemIndex;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 23,
              color: selected
                  ? const Color(0xFFFF62B0)
                  : Colors.white54,
            ),
            const SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(
                fontSize: 11,
                color: selected
                    ? Colors.white
                    : Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ================= HOME =================
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 23,
                    backgroundColor: Color(0xFF29214F),
                    child: Icon(
                      Icons.person_rounded,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back 👋',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Karaoke',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  circleButton(Icons.notifications_none_rounded),
                  const SizedBox(width: 8),
                  circleButton(Icons.settings_rounded),
                ],
              ),
              const SizedBox(height: 25),
              // HERO
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const KaraokeStudioPage(),
                    ),
                  );
                },
                child: Container(
                  height: 205,
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF8E42FF),
                        Color(0xFFEF3E9F),
                        Color(0xFF25145F),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD83EFF)
                            .withOpacity(.25),
                        blurRadius: 35,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        bottom: -35,
                        child: Icon(
                          Icons.mic_rounded,
                          size: 170,
                          color: Colors.white.withOpacity(.10),
                        ),
                      ),
                      const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'YOUR VOICE',
                            style: TextStyle(
                              letterSpacing: 3,
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Your Stage 🎤',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Sing your favourite songs',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Text(
                                'Sing Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              sectionTitle('Categories', 'See all'),
              const SizedBox(height: 14),
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CategoryChip('🔥', 'Popular'),
                    CategoryChip('❤️', 'Love'),
                    CategoryChip('🌸', 'Bengali'),
                    CategoryChip('💜', 'Hindi'),
                    CategoryChip('🌙', 'Sad'),
                    CategoryChip('✨', 'Trending'),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              sectionTitle('Popular Songs', 'View all'),
              const SizedBox(height: 14),
              ...songs.take(4).map(
                    (song) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: 12),
                      child: SongCard(song: song),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
// ================= EXPLORE =================
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
    return AppBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 110),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Explore',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
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
                  fillColor: Colors.white.withOpacity(.07),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: 12),
                      child: SongCard(
                        song: filtered[i],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ================= ROOM =================
class RoomPage extends StatelessWidget {
  const RoomPage({super.key});
  void message(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 120),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Karaoke Rooms',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sing together with your friends',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 24),
              GlassCard(
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient:
                            const LinearGradient(
                          colors: [
                            Color(0xFFFF4FA3),
                            Color(0xFF7957FF),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create a Room',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Invite friends and start singing',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          message(context, 'Room created!'),
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Live Rooms',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              roomCard(
                context,
                'Midnight Singers',
                '🎤',
                '12 singers',
              ),
              roomCard(
                context,
                'Music Lovers',
                '🎶',
                '8 singers',
              ),
              roomCard(
                context,
                'Bengali Vibes',
                '🌸',
                '15 singers',
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget roomCard(
    BuildContext context,
    String title,
    String emoji,
    String members,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        child: Row(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 34),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    members,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: () =>
                  message(context, 'Joining $title...'),
              child: const Text('Join'),
            ),
          ],
        ),
      ),
    );
  }
}
// ================= PROFILE =================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 25, 18, 120),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundColor: Color(0xFF30225E),
                child: Icon(
                  Icons.person_rounded,
                  size: 52,
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
              const SizedBox(height: 5),
              const Text(
                '@singer',
                style: TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 25),
              GlassCard(
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                  children: [
                    profileStat('12', 'Songs'),
                    profileStat('3.4K', 'Followers'),
                    profileStat('56', 'Following'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              optionTile(
                context,
                Icons.favorite_rounded,
                'My Favorites',
                () => showMessage(
                  context,
                  'Favorites opened',
                ),
              ),
              optionTile(
                context,
                Icons.history_rounded,
                'History',
                () => showMessage(
                  context,
                  'History opened',
                ),
              ),
              optionTile(
                context,
                Icons.settings_rounded,
                'Settings',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const SettingsPage(),
                    ),
                  );
                },
              ),
              optionTile(
                context,
                Icons.help_outline_rounded,
                'Help & Support',
                () => showMessage(
                  context,
                  'Help & Support',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget profileStat(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
  Widget optionTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFFFF62B0),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: Colors.white38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ================= STUDIO =================
class KaraokeStudioPage extends StatefulWidget {
  const KaraokeStudioPage({super.key});
  @override
  State<KaraokeStudioPage> createState() =>
      _KaraokeStudioPageState();
}
class _KaraokeStudioPageState
    extends State<KaraokeStudioPage> {
  bool playing = false;
  bool favorite = false;
  double progress = .35;
  Song selectedSong = songs[0];
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(18, 12, 18, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () =>
                        Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Karaoke Studio',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        favorite = !favorite;
                      });
                    },
                    icon: Icon(
                      favorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: favorite
                          ? const Color(0xFFFF4FA3)
                          : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: 245,
              height: 245,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF9B43FF),
                    Color(0xFFFF4FA3),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF4FA3)
                        .withOpacity(.35),
                    blurRadius: 55,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 215,
                  height: 215,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0D0928),
                    border: Border.all(
                      color: Colors.white12,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '🎤',
                      style: TextStyle(fontSize: 75),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35),
            Text(
              selectedSong.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              selectedSong.artist,
              style: const TextStyle(
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25),
              child: Slider(
                value: progress,
                onChanged: (value) {
                  setState(() {
                    progress = value;
                  });
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '1:24',
                    style: TextStyle(color: Colors.white54),
                  ),
                  Text(
                    '3:45',
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 20),
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
                          Color(0xFFFF4FA3),
                          Color(0xFF8657FF),
                        ],
                      ),
                    ),
                    child: Icon(
                      playing
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 38,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    size: 32,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(18, 8, 18, 25),
              child: GlassCard(
                child: Row(
                  children: [
                    const Icon(
                      Icons.mic_rounded,
                      color: Color(0xFFFF62B0),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Ready to sing?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        showMessage(
                          context,
                          'Microphone mode started 🎤',
                        );
                      },
                      child: const Text('Start'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ================= SETTINGS =================
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() =>
      _SettingsPageState();
}
class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
  bool darkMode = true;
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            18,
            15,
            18,
            30,
          ),
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
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GlassCard(
              child: Column(
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Notifications'),
                    subtitle: const Text(
                      'Get singing updates',
                    ),
                    value: notifications,
                    onChanged: (value) {
                      setState(() {
                        notifications = value;
                      });
                    },
                  ),
                  const Divider(color: Colors.white10),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Dark Mode'),
                    value: darkMode,
                    onChanged: (value) {
                      setState(() {
                        darkMode = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            GlassCard(
              child: Column(
                children: [
                  settingsButton(
                    Icons.language_rounded,
                    'Language',
                  ),
                  settingsButton(
                    Icons.security_rounded,
                    'Privacy',
                  ),
                  settingsButton(
                    Icons.info_outline_rounded,
                    'About Karaoke',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget settingsButton(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: const Color(0xFFFF62B0),
      ),
      title: Text(title),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 15,
      ),
      onTap: () {
        showMessage(context, title);
      },
    );
  }
}
// ================= REUSABLE WIDGETS =================
class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF090526),
            Color(0xFF12072D),
            Color(0xFF050319),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -80,
            child: glowCircle(
              const Color(0xFF8B3DFF),
              230,
            ),
          ),
          Positioned(
            bottom: 100,
            left: -120,
            child: glowCircle(
              const Color(0xFFFF3D9A),
              250,
            ),
          ),
          child,
        ],
      ),
    );
  }
  Widget glowCircle(Color color, double size) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: 60,
        sigmaY: 60,
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(.13),
        ),
      ),
    );
  }
}
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 22,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        Filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.055),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: Colors.white.withOpacity(.09),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
class CategoryChip extends StatelessWidget {
  final String emoji;
  final String title;
  const CategoryChip(
    this.emoji,
    this.title, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(.08),
        ),
      ),
      child: Row(
        children: [
          Text(emoji),
          const SizedBox(width: 7),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
class SongCard extends StatelessWidget {
  final Song song;
  const SongCard({
    super.key,
    required this.song,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => KaraokeStudioPage(
              key: ValueKey(song.title),
            ),
          ),
        );
      },
      child: GlassCard(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(17),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF8B3DFF),
                    Color(0xFFFF4FA3),
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  song.emoji,
                  style:
                      const TextStyle(fontSize: 25),
                ),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
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
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.07),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget sectionTitle(String title, String action) {
  return Row(
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Spacer(),
      Text(
        action,
        style: const TextStyle(
          color: Color(0xFFFF62B0),
          fontSize: 13,
        ),
      ),
    ],
  );
}
Widget circleButton(IconData icon) {
  return Container(
    width: 42,
    height: 42,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(.06),
      border: Border.all(
        color: Colors.white.withOpacity(.08),
      ),
    ),
    child: Icon(
      icon,
      size: 21,
      color: Colors.white70,
    ),
  );
}
void showMessage(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
