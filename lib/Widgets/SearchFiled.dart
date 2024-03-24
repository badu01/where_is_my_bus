// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:where_is_my_bus/firebase/function.dart';

import '../Constants/Constants.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  var hint;
  SearchField({super.key, required this.controller, required this.hint});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool showSuggetion = false;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onSearchChanged);
  }

  void _onSuggestionTapped(String suggestion) {
    // Fill the text field with the suggestion
    setState(() {
      widget.controller.text = suggestion;
      suggestions.clear();
      showSuggetion = false; // Clear the suggestion list
    });
  }

  void _onSearchChanged() async {
    if (widget.controller.text.length >= 3) {
      setState(() {
        loading = true;
      });

      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('buses').get();

      List<String> stops = [];
      snapshot.docs.forEach((doc) {
        stops.addAll(Set<String>.from(doc['stops']));
      });

      final filteredStops = stops.where((stop) =>
          stop.toLowerCase().contains(widget.controller.text.toLowerCase()));

      setState(() {
        suggestions = filteredStops.toSet().toList();
        loading = false;
        showSuggetion = true;
      });
    } else {
      setState(() {
        suggestions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hint,
            border: OutlineInputBorder(),
            suffixIcon: loading
                ? Transform.scale(scale: .5, child: CircularProgressIndicator())
                : IconButton(
                    onPressed: () {
                      setState(() {
                        widget.controller.text = '';
                      });
                    },
                    icon: Icon(Icons.close)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        showSuggetion ? buildSuggestions() : SizedBox(),
      ],
    );
  }

  Widget buildSuggestions() {
    return Expanded(
      flex: 0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(suggestions[index]),
              onTap: () {
                // Fill the text field with the suggestion
                setState(() {
                  // _searchController.text = _suggestions[index];
                  // _suggestions.clear();
                  _onSuggestionTapped(suggestions.elementAt(index));
                });
              },
            );
          },
          separatorBuilder: (context, index) => Divider(),
        ),
      ),
    );
  }
}

class BusSerachField extends StatefulWidget {
  var controller;
  var hint;
  BusSerachField({super.key, required this.controller, required this.hint});

  @override
  State<BusSerachField> createState() => _BusSerachFieldState();
}

class _BusSerachFieldState extends State<BusSerachField> {
  bool showSuggetion = false;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onSearchChanged);
  }

  void _onSuggestionTapped(String suggestion) {
    // Fill the text field with the suggestion
    setState(() {
      widget.controller.text = suggestion;
      Bussuggestions.clear();
      showSuggetion = false; // Clear the suggestion list
    });
  }

  void _onSearchChanged() async {
    if (widget.controller.text.length >= 3 ) {
      setState(() {
        loading = true;
      });

      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('buses').get();

      List<String> buses = [];
      snapshot.docs.forEach((doc) {
        buses.add(doc['name']);
      });

      final filteredStops = buses.where((stop) =>
          stop.toLowerCase().contains(widget.controller.text.toLowerCase()));

      setState(() {
        Bussuggestions = filteredStops.toSet().toList();
        loading = false;
        showSuggetion = true;
      });
    } else {
      setState(() {
        Bussuggestions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
              hintText: 'Bus Name',
              border: OutlineInputBorder(),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        widget.controller.text = '';
                        setState(() {
                          widget.controller;
                        });
                      },
                      icon: Icon(Icons.close)),
                  IconButton(onPressed: () {
                    busNameSearch(context);
                  }, icon: Icon(Icons.search)),
                ],
              )),
        ),
        SizedBox(
          height: 10,
        ),
        showSuggetion ? buildSuggestions() : SizedBox(),
      ],
    );
  }

  Widget buildSuggestions() {
    return Expanded(
      flex: 0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: Bussuggestions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(Bussuggestions[index]),
              onTap: () {
                // Fill the text field with the suggestion
                setState(() {
                  // _searchController.text = _suggestions[index];
                  // _suggestions.clear();
                  _onSuggestionTapped(Bussuggestions.elementAt(index));
                });
              },
            );
          },
          separatorBuilder: (context, index) => Divider(),
        ),
      ),
    );
  }
}
