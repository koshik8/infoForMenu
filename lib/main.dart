import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: SettingsMenu(),
      body: Center(child: Text('Main Content Area')),
    );
  }
}

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header 
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.only(left: 16, top: 40, bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Profile Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/user_image.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deva',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '+91 90472 37925',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'devajrt@gmail.com',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          // Options as ListTiles
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuOption(
                  context,
                  icon: Icons.info,
                  label: 'Info 1.3.6',
                  infoText: 'Version details: 1.3.6',
                ),
                _buildMenuOption(
                  context,
                  icon: Icons.desktop_mac,
                  label: 'Demo',
                  infoText:
                      'Application Demo screens.',
                ),
                _buildMenuOption(
                  context,
                  icon: Icons.lock,
                  label: 'User Permissions',
                  infoText: 'Manage user roles and permissions.',
                ),
                _buildMenuOption(
                  context,
                  icon: Icons.location_on,
                  label: 'Locations',
                  infoText: 'Preselect locations and save them to use in Events and Task settings.',
                ),
                _buildMenuOption(
                  context,
                  icon: Icons.image,
                  label: 'Custom Icons',
                  infoText: 'Choose custom icons for your app.',
                ),
                _buildMenuOption(
                  context,
                  icon: Icons.phone,
                  label: 'Tell a Friend',
                  infoText: 'Invite your friends to use the app.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption(BuildContext context,
      {required IconData icon,
      required String label,
      required String infoText}) {
    return 
    Column(
      children: [
        Divider(),
        ListTile(
          leading: Icon(icon, color: Colors.blue),
          title: Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTapDown: (details) {
                  final position = details.globalPosition;
                  _showTooltip(context, infoText, position);
                },
                child: Icon(Icons.info_outline, color: Colors.grey),
              ),
              const SizedBox(width: 16), 
              IconButton(icon: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),onPressed: ()=>{},),
            ],
          ),
          
        ),
      ],
    );
  }

 void _showTooltip(BuildContext context, String message, Offset position) {
  final overlay = Overlay.of(context);

  // Tooltip Overlay Entry
  final entry = OverlayEntry(
    builder: (context) {
      const maxWidth = 200.0;
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: message,
          style: const TextStyle(color: Colors.white),
        ),
        textDirection: TextDirection.ltr,
        maxLines: null,
      )..layout(maxWidth: maxWidth);

      final tooltipWidth = textPainter.size.width + 16;

      return Positioned(
        left: position.dx - (tooltipWidth / 2),
        top: position.dy + 10,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: tooltipWidth > maxWidth ? maxWidth : tooltipWidth,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      );
    },
  );

  // Insert Tooltip
  overlay.insert(entry);

  
  late OverlayEntry dismissEntry;

  // Dismiss Gesture Detector
  dismissEntry = OverlayEntry(
    builder: (_) => GestureDetector(
      onTap: () {
        entry.remove();  // Remove tooltip
        dismissEntry.remove();  // Remove dismiss detector immediately
      },
      behavior: HitTestBehavior.translucent,
      child: Container(color: Colors.transparent),
    ),
  );

  // Insert Dismiss Gesture Detector
  overlay.insert(dismissEntry);
}
}
