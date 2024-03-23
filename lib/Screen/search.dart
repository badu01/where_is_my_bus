import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LocationSearch extends StatefulWidget {
  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

    void _onSuggestionTapped(String suggestion) {
    // Fill the text field with the suggestion
    setState(() {
      _searchController.text = suggestion;
      _suggestions.clear(); // Clear the suggestion list
    });
  }

  void _onSearchChanged() async {
    if (_searchController.text.length >= 3) {
      setState(() {
        _loading = true;
      });

      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('buses')
          .get();

      List<String> stops = [];
      snapshot.docs.forEach((doc) {
        stops.addAll(Set<String>.from(doc['stops']));
      });

      final filteredStops = stops.where((stop) =>
          stop.toLowerCase().contains(_searchController.text.toLowerCase()));

      setState(() {
        _suggestions = filteredStops.toSet().toList();
        _loading = false;
      });
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop Search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for stops...',
                suffixIcon: _loading ? CircularProgressIndicator() : null,
              ),
            ),
          ),
          _buildSuggestions(),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return Expanded(
      child: ListView.builder(
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_suggestions[index]),
            onTap: () {
              // Fill the text field with the suggestion
              setState(() {
                // _searchController.text = _suggestions[index];
                // _suggestions.clear();
                _onSuggestionTapped(_suggestions.elementAt(index));
              });
            },
          );
        },
      ),
    );
  }
}