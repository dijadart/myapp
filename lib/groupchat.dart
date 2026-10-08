import 'package:flutter/material.dart';

void main() {
  runApp(const GroupChatApp());
}

class GroupChatApp extends StatelessWidget {
  const GroupChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
      ),
      home: const GroupChatScreen(),
    );
  }
}

class GroupChatScreen extends StatelessWidget {
  const GroupChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        leadingWidth: 40,
        title: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?img=12',
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.primary, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Design Team',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Sarah, Mike, Jessica, You',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.videocam_outlined, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.call_outlined, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Date divider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Today',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ),
          ),

          // Messages list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                // Received message
                ReceivedMessageBubble(
                  name: 'Sarah Chen',
                  avatar: 'https://i.pravatar.cc/150?img=5',
                  message: 'Hey team! Has anyone reviewed the latest wireframes?',
                  time: '10:23 AM',
                ),
                SizedBox(height: 16),

                // Received message with image
                ReceivedMessageBubble(
                  name: 'Mike Ross',
                  avatar: 'https://i.pravatar.cc/150?img=3',
                  message: 'Yes! I left some comments on Figma.',
                  time: '10:25 AM',
                  hasAttachment: true,
                ),
                SizedBox(height: 16),

                // Sent message
                SentMessageBubble(
                  message: 'I\'ll check them right after the standup meeting.',
                  time: '10:30 AM',
                  isRead: true,
                ),
                SizedBox(height: 16),

                // Received message
                ReceivedMessageBubble(
                  name: 'Jessica Lee',
                  avatar: 'https://i.pravatar.cc/150?img=9',
                  message: 'Don\'t forget we have the client call at 2 PM today.',
                  time: '10:32 AM',
                ),
                SizedBox(height: 16),

                // Sent message
                SentMessageBubble(
                  message: 'Got it. I\'ll prep the presentation slides.',
                  time: '10:33 AM',
                  isRead: false,
                ),
                SizedBox(height: 16),

                // Received message (long)
                ReceivedMessageBubble(
                  name: 'Sarah Chen',
                  avatar: 'https://i.pravatar.cc/150?img=5',
                  message:
                      'Also, can we finalize the color palette before EOD? The dev team is waiting on us.',
                  time: '10:35 AM',
                ),
                SizedBox(height: 16),

                // Sent message
                SentMessageBubble(
                  message: 'On it! 🎨',
                  time: '10:36 AM',
                  isRead: true,
                ),
              ],
            ),
          ),

          // Typing indicator
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 4),
            child: Row(
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.grey),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Sarah is typing...',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          // Input area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: Colors.grey),
                    onPressed: null,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7FA),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Message Design Team...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: colors.primary,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
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

// ─── WIDGETS ───────────────────────────────────────────────

class ReceivedMessageBubble extends StatelessWidget {
  final String name;
  final String avatar;
  final String message;
  final String time;
  final bool hasAttachment;

  const ReceivedMessageBubble({
    super.key,
    required this.name,
    required this.avatar,
    required this.message,
    required this.time,
    this.hasAttachment = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(avatar),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 2),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                    if (hasAttachment) ...[
                      const SizedBox(height: 8),
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F5),
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1611162617474-5b21e879e113?w=400',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SentMessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isRead;

  const SentMessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      isRead ? Icons.done_all : Icons.done,
                      size: 14,
                      color: isRead ? Colors.lightBlueAccent : Colors.white70,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}