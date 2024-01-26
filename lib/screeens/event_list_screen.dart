import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:eldersphere/screeens/event_detail_screen.dart';
import 'package:eldersphere/screeens/chatscreen.dart';
import 'package:eldersphere/screeens/searchscreen.dart';
import 'package:eldersphere/screeens/profile_screen.dart';

class EventListScreen extends StatelessWidget {
  final List<Event> events = [
    Event('Virtual Concert', 'Join us for a musical evening!', DateTime.now()),
    Event('Online Workshop', 'Learn something new!', DateTime.now().add(const Duration(days: 2))),
    Event('Tech Conference', 'Explore the latest trends in technology.', DateTime.now().add(const Duration(days: 7))),
    Event('Art Exhibition', 'Discover inspiring artworks from local artists.', DateTime.now().add(const Duration(days: 10))),
    // Add more events as needed
  ];

  EventListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Events'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.cyan, Color.fromARGB(255, 0, 255, 255)],
          ),
        ),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: const Color.fromARGB(255, 223, 237, 236),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailScreen(event: events[index], contactName: 'SomeContactName'), // Replace 'SomeContactName' with the actual contact name
                    ),
                  );
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Hero(
                    tag: 'event-${events[index].title}',
                    child: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 255, 144, 144),
                      child: Icon(Icons.event, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  title: Text(
                    events[index].title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        events[index].description,
                        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Color.fromARGB(255, 0, 0, 0), size: 18),
                          const SizedBox(width: 4),
                          Text(
                            'Date: ${_formatEventDate(events[index].dateTime)}',
                            style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.access_time, color: Color.fromARGB(255, 0, 0, 0), size: 18),
                          Chip(
                            label: Text('Free', style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1))),
                            backgroundColor: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Navigate to the ChatScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  ChatScreen(),
                ),
              );
            },
            heroTag: 'chat',
            backgroundColor: const Color.fromARGB(255, 0, 76, 255),
            child: const Tooltip(
              message: 'Chat',
              child: Icon(Icons.chat),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              // Navigate to the SearchScreen
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  SearchScreen(
                  friends:  [
                    Friend(name: 'Alice Johnson', photoUrl: 'lib/screeens/assets/old3.png'),  // Provide the actual photoUrl
                    Friend(name: 'Bob Smith', photoUrl: 'lib/screeens/assets/old4.png'),
                    Friend(name: 'Charlie Brown', photoUrl: 'lib/screeens/assets/old2.png'),
                    Friend(name: 'David Miller', photoUrl: 'lib/screeens/assets/old1.png'),
                    // Add more friends as needed
                  ],
                ),
              ),
            );

            },
            heroTag: 'search',
            backgroundColor: const Color.fromARGB(255, 0, 76, 255),
            child: const Tooltip(
              message: 'Search',
              child: Icon(Icons.search),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              // Navigate to the ProfileScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            heroTag: 'profile',
            backgroundColor: const Color.fromARGB(255, 0, 76, 255),
            child: const Tooltip(
              message: 'Profile',
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
    );
  }

  String _formatEventDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${_formatEventTime(dateTime)}';
  }

  String _formatEventTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute}';
  }
}
