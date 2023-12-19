import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:eldersphere/screeens/event_detail_screen.dart';
import 'package:eldersphere/screeens/chatscreen.dart';
import 'package:eldersphere/screeens/searchscreen.dart';
import 'package:eldersphere/screeens/profile_screen.dart';

class EventListScreen extends StatelessWidget {
  final List<Event> events = [
    Event('Virtual Concert', 'Join us for a musical evening!', DateTime.now()),
    Event('Online Workshop', 'Learn something new!', DateTime.now().add(Duration(days: 2))),
    Event('Tech Conference', 'Explore the latest trends in technology.', DateTime.now().add(Duration(days: 7))),
    Event('Art Exhibition', 'Discover inspiring artworks from local artists.', DateTime.now().add(Duration(days: 10))),
    // Add more events as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Events'),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        color: Colors.grey[900], // Darker background color
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey[800], // Darker card background color
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailScreen(event: events[index]),
                    ),
                  );
                },
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Hero(
                    tag: 'event-${events[index].title}', // Unique tag for Hero animation
                    child: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Icon(Icons.event, color: Colors.white),
                    ),
                  ),
                  title: Text(
                    events[index].title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        events[index].description,
                        style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.white, size: 18),
                          SizedBox(width: 4),
                          Text(
                            'Date: ${events[index].dateTime.toString()}',
                            style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.access_time, color: Colors.white, size: 18),
                          Chip(
                            label: Text('Free', style: TextStyle(color: Colors.white)),
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
                  builder: (context) => ChatScreen(),
                ),
              );
            },
            heroTag: 'chat', // Unique tag for FloatingActionButton
            backgroundColor: Colors.indigo,
            child: Icon(Icons.chat),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              // Navigate to the SearchScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    friends: [
                      'Alice Johnson',
                      'Bob Smith',
                      'Charlie Brown',
                      'David Miller',
                      // Add more friends as needed
                    ],
                  ),
                ),
              );
            },
            heroTag: 'search', // Unique tag for FloatingActionButton
            backgroundColor: Colors.indigo,
            child: Icon(Icons.search),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              // Navigate to the ProfileScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            heroTag: 'profile', // Unique tag for FloatingActionButton
            backgroundColor: Colors.indigo,
            child: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
