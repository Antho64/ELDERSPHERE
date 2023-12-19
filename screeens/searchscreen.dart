import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final List<String> friends;

  SearchScreen({required this.friends});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search Friends'),
          backgroundColor: Colors.indigo,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Filters'),
              Tab(text: 'Search Results'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Filters Tab
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.grey[900],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filters',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(height: 8),
                  _buildSearchBar(),
                  SizedBox(height: 16),
                  _buildFilterDropdown('College Studied', ['College A', 'College B', 'College C']),
                  SizedBox(height: 16),
                  _buildFilterDropdown('Places Lived', ['City X', 'City Y', 'City Z']),
                  SizedBox(height: 16),
                  Divider(height: 1, color: Colors.grey[700]),
                ],
              ),
            ),

            // Search Results Tab
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.grey[900],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search Results',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  // Add your search results widgets here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey[700],
      child: TextField(
        // Your search bar implementation
        style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          hintText: 'Search for friends...',
          hintStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[700],
          contentPadding: EdgeInsets.all(12.0),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(String label, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        SizedBox(height: 8),
        DropdownButton<String>(
          isExpanded: true,
          value: null, // Set the selected value if needed
          hint: Text('Select $label', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
          onChanged: (String? value) {
            // Handle the selection
          },
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option, style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            );
          }).toList(),
        ),
      ],
    );
  }
}
