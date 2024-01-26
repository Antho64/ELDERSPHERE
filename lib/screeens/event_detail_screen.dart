// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../models/event.dart';

class EventDetailScreen extends StatefulWidget {
  final Event event;

  const EventDetailScreen({required this.event, required String contactName});

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool isRSVPed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event Details',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.cyan, // Darker background color for the body
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          color: const Color.fromARGB(255, 82, 82, 82),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'event_title_${widget.event.title}',
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.event.title,
                      style:const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FadeIn(
                  child: Text(
                    widget.event.description,
                    style:const TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Color.fromARGB(255, 255, 99, 99), size: 22),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Date & Time:',
                          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        Text(
                          '${_formatEventDate(widget.event.dateTime)} at ${_formatEventTime(widget.event.dateTime)}',
                          style:const TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Additional details or actions
                _buildAdditionalDetails(),
                const SizedBox(height: 20),
                // RSVP Button
                _buildRSVPButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatEventDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _formatEventTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute}';
  }

  Widget _buildAdditionalDetails() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Row(
          children:  [
            Icon(Icons.location_on, color: Color.fromARGB(255, 255, 99, 99), size: 22),
            SizedBox(width: 8),
            Text(
              'Location:',
              style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            SizedBox(width: 8),
            Text(
              'Event Center XYZ',
              style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.people, color: Color.fromARGB(255, 255, 99, 99), size: 22),
            SizedBox(width: 8),
            Text(
              'Organizer:',
              style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            SizedBox(width: 8),
            Text(
              'Event Organizer ABC',
              style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRSVPButton() {
    return FadeIn(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            isRSVPed = !isRSVPed;
          });
          _showConfirmationMessage();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isRSVPed ? Colors.green : const Color.fromARGB(255, 172, 112, 255),
          padding:const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Adjust button padding
        ),
        child: Text(
          isRSVPed ? 'RSVPed' : 'RSVP',
          style:const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  void _showConfirmationMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('RSVP Confirmation'),
          content: Text(
            isRSVPed
                ? 'You have successfully RSVPed for ${widget.event.title}. Enjoy the event!'
                : 'You have canceled your RSVP for ${widget.event.title}.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class FadeIn extends StatefulWidget {
  final Widget child;

  const FadeIn({required this.child});

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
