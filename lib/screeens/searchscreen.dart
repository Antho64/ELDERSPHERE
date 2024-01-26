// Import required packages and libraries
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Define a Friend class with name and photoUrl properties
class Friend {
  final String name;
  final String photoUrl;

  // Constructor for the Friend class
  Friend({required this.name, required this.photoUrl});
}

// Define a SearchScreen class as a StatefulWidget
class SearchScreen extends StatefulWidget {
  // Accept a List of Friend objects as a parameter
  final List<Friend> friends;

  // Constructor for the SearchScreen class
  const SearchScreen({required this.friends});

  // Create an instance of _SearchScreenState
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

// Define the state for the SearchScreen
class _SearchScreenState extends State<SearchScreen> {
  // Create a TextEditingController for the search input
  final TextEditingController _searchController = TextEditingController();
  // Initialize the searchResults list
  List<Friend> searchResults = [];
  // Initialize selectedCollege and selectedPlace
  String? selectedCollege;
  String? selectedPlace;

  // Override the initState method to set up initial state
  @override
  void initState() {
    super.initState();
    // Set searchResults to the initial list of friends
    searchResults = widget.friends;
  }

  // Build the UI for the SearchScreen
  @override
  Widget build(BuildContext context) {
    // Scaffold widget with an AppBar and body
    return Scaffold(
      // AppBar with title, background color, elevation, and leading icon
      appBar: AppBar(
        title: Text('Search Friends', style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 22, color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 208, 208, 208),
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Container for the body with padding, decoration, and a column of widgets
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.cyan, Color.fromARGB(255, 0, 255, 255)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Call _buildSearchBar method
            _buildSearchBar(),
            const SizedBox(height: 8),
            // Call _buildFilterDropdown method with parameters
            _buildFilterDropdown('College Studied', Icons.school, ['College A', 'College B', 'College C']),
            const SizedBox(height: 16),
            // Call _buildFilterDropdown method with parameters
            _buildFilterDropdown('Places Lived', Icons.location_on, ['City X', 'City Y', 'City Z']),
            // Divider widget with height and color
            const Divider(height: 1, color: Color.fromARGB(255, 54, 54, 54)),
            const SizedBox(height: 16),
            // Text widget for 'Search Results' with style
            Text(
              'Search Results',
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 8),
            // Expanded widget with a container for search results
            Expanded(
              child: Container(
                // Decoration for the container
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 242, 231, 231),
                  borderRadius: BorderRadius.circular(16),
                ),
                // Padding for the container
                padding: const EdgeInsets.all(16),
                // Call _buildSearchResults method
                child: _buildSearchResults(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build the search bar
  Widget _buildSearchBar() {
    // Container widget for the search bar with padding, decoration, and child TextField
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        // TextField with controller, onChanged callback, style, and decoration
        controller: _searchController,
        onChanged: _onSearchTextChanged,
        style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search For Your Old Friends...',
          hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[300]),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          contentPadding: const EdgeInsets.all(12.0),
          prefixIcon: Icon(Icons.search, color: Colors.white),
        ),
      ),
    );
  }

  // Method to build the filter dropdown
  Widget _buildFilterDropdown(String label, IconData icon, List<String> options) {
    // Column widget with children including a Row, SizedBox, and DropdownButton
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row widget with children including an Icon and Text
        Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 30,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // DropdownButton widget with parameters
        DropdownButton<String>(
          dropdownColor: Colors.grey[300],
          isExpanded: true,
          value: label == 'College Studied' ? selectedCollege : selectedPlace,
          hint: Text(
            'Select $label',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
          ),
          onChanged: (String? value) {
            // onChanged callback to update selectedCollege or selectedPlace
            setState(() {
              if (label == 'College Studied') {
                selectedCollege = value;
              } else if (label == 'Places Lived') {
                selectedPlace = value;
              }
            });
            // Call _applyFilters method
            _applyFilters();
          },
          // Items for the DropdownButton
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              // Padding and Text for each dropdown item
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(option, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Method to build the search results
  Widget _buildSearchResults() {
    // Check if search text is empty
    if (_searchController.text.isEmpty) {
      // Centered Text widget for 'Start typing to search...'
      return Center(
        child: Text(
          'Start typing to search...',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey),
        ),
      );
    }
    // Check if searchResults is empty
    else if (searchResults.isEmpty) {
      // Centered Text widget for 'No results found'
      return Center(
        child: Text(
          'No results found',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey),
        ),
      );
    }
    // If searchResults is not empty
    else {
      // ListView.builder for displaying search results
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          // ListTile for each search result with title and leading CircleAvatar
          return ListTile(
            title: Text(searchResults[index].name, style: GoogleFonts.montserrat(fontSize: 16, color: Colors.black)),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(searchResults[index].photoUrl),
            ),
          );
        },
      );
    }
  }

  // Callback method for search text changes
  void _onSearchTextChanged(String text) {
    // ... (rest of _onSearchTextChanged method)
  }

  // Method to apply filters based on selectedCollege and selectedPlace
  void _applyFilters() {
    // ... (rest of _applyFilters method)
  }
}

// Main function to run the app
void main() {
  // Run the app with MaterialApp and SearchScreen
  runApp(MaterialApp(
    home: SearchScreen(
      friends: [
        
        Friend(name: 'Alice Johnson',photoUrl: 'lib/screeens/assets/old3.png'),
        Friend(name: 'Bob Smith', photoUrl: 'lib/screeens/assets/old4.png'),
        Friend(name: 'Charlie Brown', photoUrl: 'lib/screeens/assets/old2.png'),
        Friend(name: 'David Miller', photoUrl: 'lib/screeens/assets/old1.png'),
        Friend(name: 'Eva Davis', photoUrl: 'lib/screeens/assets/old5.png'),
        Friend(name: 'Frank Wilson', photoUrl: 'lib/screeens/assets/old6.png'),
      ],
    ),
  ));
}
