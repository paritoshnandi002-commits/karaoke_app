import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const KaraokeApp());

class Song {
  final String title, artist, audioUrl;
  final IconData icon;

  const Song(this.title, this.artist, this.icon, this.audioUrl);
}

const songs = <Song>[
  Song('Deewana Deewana', 'Karaoke Hits', Icons.music_note_rounded,
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'),
  Song('Perfect', 'Acoustic', Icons.favorite_rounded,
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'),
  Song('Tum Hi Ho', 'Romantic', Icons.nightlight_round,
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3'),
  Song('Kesariya', 'Bollywood', Icons.auto_awesome_rounded,
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3'),
];

class KaraokeApp extends StatelessWidget {
  const KaraokeApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Karaoke',
    theme: ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: const Color(0xFF08051F),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF3BC8), brightness: Brightness.dark),
    ),
    home: const Shell(),
  );
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override State<Shell> createState() => _ShellState();
}
class _ShellState extends State<Shell> {
  int tab = 0;
  Song selected = songs[0];
  void song(Song s) => setState(() { selected = s; tab = 2; });
  @override Widget build(BuildContext context) {
    final pages = <Widget>[
      HomePage(onSong: song, onRoom: () => setState(() => tab = 3)),
      ExplorePage(onSong: song), PlayerPage(song: selected), const RoomsPage(),
      ProfilePage(onSettings: () => _settings(context)),
    ];
    return Scaffold(
      extendBody: true,
      body: GlossyBackground(child: pages[tab]),
      bottomNavigationBar: NavBar(index: tab, onTap: (v) => setState(() => tab = v)),
    );
  }
  void _settings(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
}

class GlossyBackground extends StatelessWidget {
  final Widget child;
  const GlossyBackground({super.key, required this.child});
  @override Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(gradient: LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight,
      colors: [Color(0xFF08051F), Color(0xFF17104A), Color(0xFF090625)],
    )),
    child: Stack(children: [
      const Positioned(top: -100, right: -80, child: Glow(size: 260, color: Color(0xFFB72CFF))),
      const Positioned(top: 260, left: -130, child: Glow(size: 260, color: Color(0xFFFF2BBE))),
      const Positioned(bottom: 60, right: -120, child: Glow(size: 280, color: Color(0xFF355CFF))),
      SafeArea(child: child),
    ]),
  );
}
class Glow extends StatelessWidget {
  final double size; final Color color;
  const Glow({super.key, required this.size, required this.color});
  @override Widget build(BuildContext context) => IgnorePointer(child: Container(width: size, height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [color.withOpacity(.35), color.withOpacity(0)]))));
}
class Glass extends StatelessWidget {
  final Widget child; final VoidCallback? onTap; final EdgeInsets padding;
  const Glass({super.key, required this.child, this.onTap, this.padding = const EdgeInsets.all(18)});
  @override Widget build(BuildContext context) {
    final c = Container(padding: padding, decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(26),
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(.14), Colors.white.withOpacity(.045)]),
      border: Border.all(color: Colors.white.withOpacity(.14)),
      boxShadow: [BoxShadow(color: const Color(0xFFB82DFF).withOpacity(.15), blurRadius: 28)],
    ), child: child);
    return onTap == null ? c : InkWell(onTap: onTap, borderRadius: BorderRadius.circular(26), child: c);
  }
}

class HomePage extends StatelessWidget {
  final ValueChanged<Song> onSong; final VoidCallback onRoom;
  const HomePage({super.key, required this.onSong, required this.onRoom});
  @override Widget build(BuildContext context) => CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
    SliverPadding(padding: const EdgeInsets.fromLTRB(20, 14, 20, 0), sliver: SliverToBoxAdapter(child: Row(children: [
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Good evening ✨', style: TextStyle(color: Colors.white70)), SizedBox(height: 4),
        Text('Sing your heart out', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
      ])), CircleAvatar(backgroundColor: Color(0x22FFFFFF), child: Icon(Icons.notifications_none_rounded)),
    ]))),
    SliverPadding(padding: const EdgeInsets.all(20), sliver: SliverToBoxAdapter(child: Glass(padding: EdgeInsets.zero, onTap: () => onSong(songs[0]), child: Container(
      height: 210, padding: const EdgeInsets.all(22), decoration: BoxDecoration(borderRadius: BorderRadius.circular(26),
      gradient: const LinearGradient(colors: [Color(0xFF7628FF), Color(0xFFE52EC7), Color(0xFF3A52FF)])),
      child: Stack(children: [const Positioned(right: -25, top: -35, child: Icon(Icons.graphic_eq_rounded, size: 180, color: Colors.white24)),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('KARAOKE NIGHT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const Spacer(), const Text('Your voice.\nYour moment.', style: TextStyle(fontSize: 29, height: 1.02, fontWeight: FontWeight.w900)),
          const SizedBox(height: 14), Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
            decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(18)), child: const Text('🎤  Start singing')),
        ]),
      ]),
    )))),
    SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 20), sliver: SliverToBoxAdapter(child: Row(children: [
      const Text('Categories', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)), const Spacer(),
      TextButton(onPressed: onRoom, child: const Text('Rooms')),
    ]))),
    SliverPadding(padding: const EdgeInsets.fromLTRB(20, 8, 20, 4), sliver: SliverToBoxAdapter(child: Wrap(spacing: 9, runSpacing: 9, children: const [
      Cat(icon: Icons.favorite_rounded, text: 'Romantic'), Cat(icon: Icons.local_fire_department_rounded, text: 'Trending'),
      Cat(icon: Icons.sentiment_satisfied_alt_rounded, text: 'Happy'), Cat(icon: Icons.nightlife_rounded, text: 'Chill'),
    ]))),
    SliverPadding(padding: const EdgeInsets.fromLTRB(20, 22, 20, 8), sliver: SliverToBoxAdapter(child: Row(children: [
      const Text('Popular songs', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)), const Spacer(),
      const Text('See all', style: TextStyle(color: Color(0xFFFF6BDD))),
    ]))),
    SliverPadding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 110), sliver: SliverList.builder(
      itemCount: songs.length, itemBuilder: (_, i) => Padding(padding: const EdgeInsets.only(bottom: 10), child: SongTile(song: songs[i], onTap: () => onSong(songs[i]))))),
  ]);
}
class Cat extends StatelessWidget {
  final IconData icon; final String text; const Cat({super.key, required this.icon, required this.text});
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(color: Colors.white.withOpacity(.075), borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white12)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 17, color: const Color(0xFFFF65D9)), const SizedBox(width: 7), Text(text)]));
}
class SongTile extends StatelessWidget {
  final Song song; final VoidCallback onTap; const SongTile({super.key, required this.song, required this.onTap});
  @override Widget build(BuildContext context) => Glass(padding: const EdgeInsets.all(11), onTap: onTap, child: Row(children: [
    Container(width: 55, height: 55, decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(17)), gradient: LinearGradient(colors: [Color(0xFFFF39C7), Color(0xFF7042FF)])), child: Icon(song.icon, size: 28)),
    const SizedBox(width: 13), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(song.title, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text(song.artist, style: const TextStyle(color: Colors.white54, fontSize: 12))])),
    const Icon(Icons.play_circle_fill_rounded, color: Color(0xFFFF59D5), size: 34),
  ]));
}

class ExplorePage extends StatefulWidget { final ValueChanged<Song> onSong; const ExplorePage({super.key, required this.onSong}); @override State<ExplorePage> createState()=>_ExploreState(); }
class _ExploreState extends State<ExplorePage> { String q=''; @override Widget build(BuildContext context) { final list=songs.where((s)=>('${s.title} ${s.artist}').toLowerCase().contains(q.toLowerCase())).toList(); return ListView(padding: const EdgeInsets.fromLTRB(20,18,20,110), children:[const Text('Explore',style:TextStyle(fontSize:28,fontWeight:FontWeight.w900)),const SizedBox(height:18),TextField(onChanged:(v)=>setState(()=>q=v),decoration:InputDecoration(hintText:'Search songs, artists...',prefixIcon:const Icon(Icons.search_rounded),filled:true,fillColor:Colors.white10,border:OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(20)),borderSide:BorderSide.none))),const SizedBox(height:22),...list.map((s)=>Padding(padding:const EdgeInsets.only(bottom:10),child:SongTile(song:s,onTap:()=>widget.onSong(s))))]); } }

class PlayerPage extends StatefulWidget {
  final Song song;
  const PlayerPage({super.key, required this.song});

  @override
  State<PlayerPage> createState() => _PlayerState();
}

class _PlayerState extends State<PlayerPage> {
  final AudioPlayer _audio = AudioPlayer();
  bool play = false, like = false;
  double value = .35;

  Future<void> _togglePlay() async {
    try {
      if (play) {
        await _audio.pause();
      } else {
        await _audio.play(UrlSource(widget.song.audioUrl));
      }
      if (mounted) {
        setState(() => play = !play);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Audio play failed: $e')),
      );
    }
  }

  @override
  void dispose() {
    _audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
    children: [
      const Text('Now singing', style: TextStyle(color: Colors.white60)),
      const SizedBox(height: 7),
      Text(widget.song.title,
          style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
      Text(widget.song.artist,
          style: const TextStyle(color: Colors.white54)),
      const SizedBox(height: 25),
      Container(
        height: 245,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            colors: [Color(0xFF9A2CFF), Color(0xFFE82BC4), Color(0xFF264CFF)],
          ),
          boxShadow: const [
            BoxShadow(color: Color(0x55FF35C8), blurRadius: 35)
          ],
        ),
        child: const Center(
          child: Icon(Icons.mic_rounded, size: 105, color: Colors.white24),
        ),
      ),
      const SizedBox(height: 24),
      Glass(
        child: Column(
          children: [
            const Text('♪  Sing along with the lyrics  ♪',
                style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 18),
            const Text('Feel the music',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Let your voice shine tonight',
                style: TextStyle(color: Color(0xFFFF75DD))),
            const SizedBox(height: 12),
            Slider(
              value: value,
              onChanged: (v) => setState(() => value = v),
              activeColor: const Color(0xFFFF45CF),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_previous_rounded),
                ),
                Container(
                  width: 62,
                  height: 62,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF39C7), Color(0xFF7146FF)],
                    ),
                  ),
                  child: IconButton(
                    onPressed: _togglePlay,
                    icon: Icon(
                      play ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      size: 32,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_next_rounded),
                ),
                IconButton(
                  onPressed: () => setState(() => like = !like),
                  icon: Icon(
                    like
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: like ? const Color(0xFFFF4ED2) : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

class RoomsPage extends StatelessWidget { const RoomsPage({super.key}); @override Widget build(BuildContext context){ final data=[('Late Night Vibes','24 singers',Icons.nightlife_rounded),('Bollywood Hits','18 singers',Icons.local_fire_department_rounded),('Chill & Sing','12 singers',Icons.favorite_rounded)]; return ListView(padding:const EdgeInsets.fromLTRB(20,18,20,110),children:[Row(children:[const Expanded(child:Text('Live Rooms',style:TextStyle(fontSize:28,fontWeight:FontWeight.w900))),FilledButton.icon(onPressed:()=>_create(context),icon:const Icon(Icons.add_rounded),label:const Text('Create'))]),const SizedBox(height:18),...data.map((r)=>Padding(padding:const EdgeInsets.only(bottom:12),child:Glass(onTap:()=>_join(context,r.$1),child:Row(children:[Container(width:58,height:58,decoration:const BoxDecoration(shape:BoxShape.circle,gradient:LinearGradient(colors:[Color(0xFFFF3DC9),Color(0xFF6A45FF)])),child:Icon(r.$3)),const SizedBox(width:14),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(r.$1,style:const TextStyle(fontWeight:FontWeight.w800)),const SizedBox(height:4),Text(r.$2,style:const TextStyle(color:Colors.white54))])),const Icon(Icons.chevron_right_rounded)]))))]); }
void _join(BuildContext c,String name)=>showDialog(context:c,builder:(_)=>AlertDialog(title:Text(name),content:const Text('Join this live karaoke room?'),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancel')),FilledButton(onPressed:()=>Navigator.pop(c),child:const Text('Join'))]));
void _create(BuildContext c){final x=TextEditingController();showDialog(context:c,builder:(_)=>AlertDialog(title:const Text('Create a room'),content:TextField(controller:x,decoration:const InputDecoration(hintText:'Room name')),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancel')),FilledButton(onPressed:(){Navigator.pop(c);ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text(x.text.trim().isEmpty?'Room created!':'${x.text.trim()} created!')));},child:const Text('Create'))]));}
}

class ProfilePage extends StatelessWidget { final VoidCallback onSettings; const ProfilePage({super.key,required this.onSettings}); @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.fromLTRB(20,18,20,110),children:[Row(children:[const Expanded(child:Text('Profile',style:TextStyle(fontSize:28,fontWeight:FontWeight.w900))),IconButton(onPressed:onSettings,icon:const Icon(Icons.settings_outlined))]),const SizedBox(height:18),Glass(child:Row(children:[Container(width:72,height:72,decoration:const BoxDecoration(shape:BoxShape.circle,gradient:LinearGradient(colors:[Color(0xFFFF3BC8),Color(0xFF6647FF)])),child:const Icon(Icons.person_rounded,size:38)),const SizedBox(width:16),const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Karaoke Star',style:TextStyle(fontSize:20,fontWeight:FontWeight.w800)),SizedBox(height:5),Text('@singwithme',style:TextStyle(color:Colors.white54))])])),const SizedBox(height:14),Row(children:[_stat('128','Songs'),_stat('42','Followers'),_stat('19','Following')]),const SizedBox(height:14),Glass(onTap:onSettings,child:const Row(children:[Icon(Icons.settings_rounded,color:Color(0xFFFF63D7)),SizedBox(width:14),Expanded(child:Text('Settings',style:TextStyle(fontWeight:FontWeight.w700))),Icon(Icons.chevron_right_rounded)]))]); }
Widget _stat(String a,String b)=>Expanded(child:Glass(padding:const EdgeInsets.symmetric(vertical:17),child:Column(children:[Text(a,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w900)),const SizedBox(height:4),Text(b,style:const TextStyle(color:Colors.white54,fontSize:12))])));
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  bool notification = true, dark = true;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF08051F),
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      title: const Text('Settings'),
    ),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Glass(
          child: Column(
            children: [
              _row(context, Icons.security_rounded, 'Account & Security',
                  'Account protected'),
              const Divider(color: Colors.white10),
              _switch('Notifications', notification,
                  (v) => setState(() => notification = v)),
              const Divider(color: Colors.white10),
              _switch('Dark Mode', dark,
                  (v) => setState(() => dark = v)),
              const Divider(color: Colors.white10),
              _row(context, Icons.language_rounded, 'Language', 'English'),
              const Divider(color: Colors.white10),
              _row(context, Icons.privacy_tip_outlined, 'Privacy Policy',
                  'Your privacy matters'),
              const Divider(color: Colors.white10),
              _row(context, Icons.help_outline_rounded, 'Help & Support',
                  'Support is ready'),
              const Divider(color: Colors.white10),
              _row(context, Icons.info_outline_rounded, 'About App',
                  'Karaoke • Version 1.0.0'),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _row(BuildContext context, IconData i, String t, String message) =>
      ListTile(
        onTap: () => _msg(context, message),
        contentPadding: EdgeInsets.zero,
        leading: Icon(i, color: const Color(0xFFFF63D7)),
        title: Text(t),
        trailing: const Icon(Icons.chevron_right_rounded,
            color: Colors.white54),
      );

  Widget _switch(String t, bool v, ValueChanged<bool> f) =>
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(t),
        value: v,
        onChanged: f,
        activeColor: const Color(0xFFFF4ACF),
      );

  void _msg(BuildContext context, String s) => showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Karaoke'),
      content: Text(s),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

class NavBar extends StatelessWidget { final int index; final ValueChanged<int> onTap; const NavBar({super.key,required this.index,required this.onTap}); @override Widget build(BuildContext context)=>Container(margin:const EdgeInsets.fromLTRB(12,0,12,12),decoration:BoxDecoration(color:const Color(0xEE100C31),borderRadius:BorderRadius.circular(26),border:Border.all(color:Colors.white12),boxShadow:[BoxShadow(color:const Color(0x33FF28C4),blurRadius:25)]),child:NavigationBar(backgroundColor:Colors.transparent,elevation:0,selectedIndex:index,indicatorColor:const Color(0x55FF3DC9),onDestinationSelected:onTap,destinations:const[NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home_rounded),label:'Home'),NavigationDestination(icon:Icon(Icons.explore_outlined),selectedIcon:Icon(Icons.explore_rounded),label:'Explore'),NavigationDestination(icon:Icon(Icons.mic_none_rounded),selectedIcon:Icon(Icons.mic_rounded),label:'Sing'),NavigationDestination(icon:Icon(Icons.meeting_room_outlined),selectedIcon:Icon(Icons.meeting_room_rounded),label:'Room'),NavigationDestination(icon:Icon(Icons.person_outline_rounded),selectedIcon:Icon(Icons.person_rounded),label:'Profile')])); }
