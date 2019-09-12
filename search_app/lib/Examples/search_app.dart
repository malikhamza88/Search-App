import 'package:flutter/material.dart';

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final cities = [
    'Multan',
    'Karachi',
    'Lahore',
    'Peshawar',
    'Islamabad',
    'Faisalbad',
    'Mian Chanu',
    'BhawalPur',
    'Sher Shah'
  ];

  final recentCities = [
    'Karachi',
    'Lahore',
    'Peshawar'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions For App Bar
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading Icon

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        child: Card(
          color: Colors.indigo,
          elevation: 20.0,
          child: Center(
            child: Text(
              query,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show Someone Searches for Something

    final suggestionsList = query.isEmpty ? recentCities :
    cities.where((p) => p.startsWith(query)).toList();

    return ListView.builder(itemBuilder: (context, index) =>
        ListTile(
          onTap: (){
            showResults(context);
          },
          leading: Icon(Icons.location_city),
          title: RichText(
              text: TextSpan(
                  text: suggestionsList[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children:[
                    TextSpan(
                      text: suggestionsList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal)
                    )
                  ]
              )
          ),

        ),
      itemCount: suggestionsList.length,
    );
  }
}
