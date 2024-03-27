import 'package:flutter/material.dart';

class SearchMapPage extends StatefulWidget {
  const SearchMapPage({super.key});

  @override
  State<SearchMapPage> createState() => _SearchMapPageState();
}

class _SearchMapPageState extends State<SearchMapPage> {
  late final TextEditingController _searchController;
  late final FocusNode _searchNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _searchController,
                  focusNode: _searchNode,
                  decoration: InputDecoration(
                    hintText: 'Search your city',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getSuggestions(String input) async {
    // https://www.youtube.com/watch?v=oPPU0abBd7M&list=PLfMA-5tPrKDFVIaJzeH8sI1gYV2DDa9jk&index=4
    // Google API Key
    // Endpoint Url of Googleapis
    // Session Token

    // String googleApiKey = GOOGLE_MAP_KEY;
    // String baseUrl = '${GOOGLE_BASE_URL}?input=';

    // https://maps.googleapis.com/maps/api/place/autocomplete/json
    // ?input=amoeba
    // &location=37.76999%2C-122.44696
    // &radius=500
    // &types=establishment
    // &key=YOUR_API_KEY
  }
}
