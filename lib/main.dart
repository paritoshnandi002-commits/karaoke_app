
import 'dart:async';
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
      home: const KaraokeShell(),
    );
  }
}

enum KaraokeScreen {
  splash,
  home,
  explore,
  player,
  profile,
  room,
  settings,
  ending,
}

class KaraokeShell extends StatefulWidget {
  const KaraokeShell({super.key});

  @override
  State<KaraokeShell> createState() => _KaraokeShellState();
}

class _KaraokeShellState extends State<KaraokeShell> {
  KaraokeScreen screen = KaraokeScreen.splash;
  KaraokeScreen previous = KaraokeScreen.home;
  bool notifications = true;
  bool darkMode = true;
  bool playing = false;
  bool favorite = false;
  bool loggedOut = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1700), () {
      if (mounted) {
        setState(() => screen = KaraokeScreen.home);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void go(KaraokeScreen next) {
    if (next == screen) return;
    if (screen != KaraokeScreen.splash) previous = screen;
    setState(() => screen = next);
  }

  void back() {
    setState(() => screen = previous == KaraokeScreen.player
        ? KaraokeScreen.home
        : previous);
  }

  void handleTap(TapUpDetails details, Size size) {
    final x = details.localPosition.dx / size.width;
    final y = details.localPosition.dy / size.height;

    if (screen == KaraokeScreen.splash) return;

    // Bottom navigation: Home, Explore, Mic, Room, Profile.
    if (y > .875) {
      if (x < .20) {
        go(KaraokeScreen.home);
        return;
      }
      if (x < .40) {
        go(KaraokeScreen.explore);
        return;
      }
      if (x < .60) {
        previous = screen;
        go(KaraokeScreen.player);
        return;
      }
      if (x < .80) {
        go(KaraokeScreen.room);
        return;
      }
      go(KaraokeScreen.profile);
      return;
    }

    switch (screen) {
      case KaraokeScreen.home:
        if (y < .38 && y > .12) {
          previous = KaraokeScreen.home;
          go(KaraokeScreen.player);
        } else if (y > .49 && y < .86) {
          previous = KaraokeScreen.home;
          go(KaraokeScreen.player);
        }
        break;

      case KaraokeScreen.explore:
        if (y > .38 && y < .88) {
          previous = KaraokeScreen.explore;
          go(KaraokeScreen.player);
        }
        break;

      case KaraokeScreen.player:
        if (x < .16 && y < .12) {
          back();
        } else if (y > .38 && y < .57) {
          setState(() => playing = !playing);
        } else if (x > .82 && y < .16) {
          setState(() => favorite = !favorite);
        } else if (y > .82 && x > .70) {
          _showKaraokeDialog();
        }
        break;

      case KaraokeScreen.profile:
        if (x > .82 && y < .13) {
          go(KaraokeScreen.settings);
        } else if (y > .78 && y < .88) {
          go(KaraokeScreen.settings);
        } else if (y > .43 && y < .60) {
          go(KaraokeScreen.room);
        }
        break;

      case KaraokeScreen.room:
        if (y > .08 && y < .19 && x > .52) {
          _showCreateRoomDialog();
        } else if (y > .22 && y < .42) {
          _showJoinDialog();
        } else if (y > .42 && y < .88) {
          _showJoinDialog();
        }
        break;

      case KaraokeScreen.settings:
        if (y > .17 && y < .25) {
          _showSimpleDialog('Account & Security', 'Your account is protected.');
        } else if (y > .25 && y < .33) {
          setState(() => notifications = !notifications);
        } else if (y > .33 && y < .42) {
          setState(() => darkMode = !darkMode);
        } else if (y > .42 && y < .50) {
          _showSimpleDialog('Language', 'English');
        } else if (y > .50 && y < .58) {
          _showSimpleDialog('Privacy Policy', 'Your privacy matters.');
        } else if (y > .58 && y < .66) {
          _showSimpleDialog('Help & Support', 'Karaoke support is ready.');
        } else if (y > .66 && y < .74) {
          _showSimpleDialog('About App', 'Karaoke • Version 1.0.0');
        } else if (y > .80 && y < .91) {
          setState(() => loggedOut = true);
          go(KaraokeScreen.home);
        } else if (x < .18 && y < .13) {
          back();
        }
        break;

      case KaraokeScreen.ending:
        go(KaraokeScreen.home);
        break;

      case KaraokeScreen.splash:
        break;
    }
  }

  void _showKaraokeDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF10133B),
        title: const Text('Karaoke'),
        content: const Text('Microphone mode is ready. You can start singing here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  void _showJoinDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF10133B),
        title: const Text('Join Room'),
        content: const Text('You joined the selected live room.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCreateRoomDialog() {
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF10133B),
        title: const Text('Create Room'),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Room name',
            hintStyle: TextStyle(color: Colors.white54),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(this.context).showSnackBar(
                SnackBar(
                  content: Text(
                    controller.text.trim().isEmpty
                        ? 'Room created'
                        : 'Room "${controller.text.trim()}" created',
                  ),
                ),
              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showSimpleDialog(String title, String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF10133B),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String assetFor(KaraokeScreen value) {
    switch (value) {
      case KaraokeScreen.splash:
        return 'assets/screens/splash.png';
      case KaraokeScreen.home:
        return 'assets/screens/home.png';
      case KaraokeScreen.explore:
        return 'assets/screens/explore.png';
      case KaraokeScreen.player:
        return 'assets/screens/player.png';
      case KaraokeScreen.profile:
        return 'assets/screens/profile.png';
      case KaraokeScreen.room:
        return 'assets/screens/room.png';
      case KaraokeScreen.settings:
        return 'assets/screens/settings.png';
      case KaraokeScreen.ending:
        return 'assets/screens/ending.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenSize = Size(
              constraints.maxWidth,
              constraints.maxHeight,
            );

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (details) => handleTap(details, screenSize),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    assetFor(screen),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),

                  // Invisible interaction helpers: the reference artwork stays
                  // visually unchanged while the important options remain live.
                  if (screen != KaraokeScreen.splash &&
                      screen != KaraokeScreen.ending)
                    IgnorePointer(
                      child: Container(color: Colors.transparent),
                    ),

                  // Live visual state for play/favourite/settings.
                  if (screen == KaraokeScreen.player && playing)
                    const Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SizedBox(height: 1),
                    ),

                  if (screen == KaraokeScreen.settings)
                    Positioned(
                      right: 18,
                      top: constraints.maxHeight * .34,
                      child: IgnorePointer(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 36,
                          height: 20,
                          decoration: BoxDecoration(
                            color: darkMode
                                ? const Color(0xFF3D8DFF)
                                : const Color(0xFF555555),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Align(
                            alignment: darkMode
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              width: 14,
                              height: 14,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  if (screen == KaraokeScreen.settings && !notifications)
                    const Positioned(
                      right: 20,
                      top: 10,
                      child: SizedBox.shrink(),
                    ),

                  if (screen == KaraokeScreen.player && favorite)
                    const Positioned(
                      right: 26,
                      top: 48,
                      child: IgnorePointer(
                        child: Icon(
                          Icons.favorite,
                          color: Color(0xFFFF4FD8),
                          size: 18,
                        ),
                      ),
                    ),

                  if (loggedOut)
                    const Positioned(
                      left: 0,
                      right: 0,
                      bottom: 8,
                      child: IgnorePointer(
                        child: Text(
                          'Welcome back',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
