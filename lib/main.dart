/*
import 'dart:async';

import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';
import 'package:flutter/material.dart';

const kGoogleApiKey = "API_KEY";

// to get places detail (lat/lng)
GoogleMapsPlaces _places = new GoogleMapsPlaces();
*/
/*
main() {
  runApp(new MaterialApp(
    title: "My App",
    theme: new ThemeData(
      accentColor: Colors.redAccent,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.00))),
          contentPadding:
          EdgeInsets.symmetric(vertical: 12.50, horizontal: 10.00)),
    ),
    routes: {
      "/": (_) => new MyApp(),
      "/search": (_) => new CustomSearchScaffold()
    },
  ));
}*/
/*

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

final homeScaffoldKey = new GlobalKey<ScaffoldState>();
final searchScaffoldKey = new GlobalKey<ScaffoldState>();
*/
/*

class _MyAppState extends State<MyApp> {
  Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: homeScaffoldKey,
      appBar: new AppBar(
        title: new Text("My App"),
      ),
      body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new DropdownButton(
                  value: _mode,
                  items: <DropdownMenuItem<Mode>>[
                    new DropdownMenuItem<Mode>(
                        child: new Text("Overlay"), value: Mode.overlay),
                    new DropdownMenuItem<Mode>(
                        child: new Text("Fullscreen"), value: Mode.fullscreen),
                  ],
                  onChanged: (m) {
                    setState(() {
                      _mode = m;
                    });
                  }),
              new RaisedButton(
                  onPressed: () async {
                    // show input autocomplete with selected mode
                    // then get the Prediction selected
                    Prediction p = await showGooglePlacesAutocomplete(
                        context: context,
                        apiKey: kGoogleApiKey,
                        onError: (res) {
                          homeScaffoldKey.currentState.showSnackBar(
                              new SnackBar(content: new Text(res.errorMessage)));
                        },
                        mode: _mode,
                        language: "fr",
                        components: [new Component(Component.country, "fr")]);

                    displayPrediction(p, homeScaffoldKey.currentState);
                  },
                  child: new Text("Search places")),
              new RaisedButton(
                child: new Text("Custom"),
                onPressed: () {
                  Navigator.of(context).pushNamed("/search");
                },
              ),
            ],
          )),
    );
  }
}

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    // get detail (lat/lng)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    scaffold.showSnackBar(
        new SnackBar(content: new Text("${p.description} - $lat/$lng")));
  }
}
*/
/*

// custom scaffold that handle search
// basically your widget need to extends [GooglePlacesAutocompleteWidget]
// and your state [GooglePlacesAutocompleteState]
class CustomSearchScaffold extends GooglePlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
      apiKey: kGoogleApiKey,
      language: "en",
      components: [new Component(Component.country, "uk")]);

  @override
  _CustomSearchScaffoldState createState() => new _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends GooglePlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = new AppBar(title: new AppBarPlacesAutoCompleteTextField());
    final body = new GooglePlacesAutocompleteResult(onTap: (p) {
      displayPrediction(p, searchScaffoldKey.currentState);
    });
    return new Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(response.errorMessage)));
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      searchScaffoldKey.currentState
          .showSnackBar(new SnackBar(content: new Text("Got answer")));
    }
  }
}*/
/*

import 'package:flutter/material.dart';
//import 'package:advertise_me/login_screen.dart';
import 'dart:async';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';


void main() => runApp(MyApp());

const kGoogleApiKey = "AIzaSyDv5ja_2sJzG6dMkkRW95d1U99QanltSfc";


GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: demo(),
      ),
    );
  }
}

class demo extends StatefulWidget {
  @override
  demoState createState() => new demoState();
}

class demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () async {
                Prediction p = await PlacesAutocomplete.show(
                    context: context, apiKey: kGoogleApiKey);
                displayPrediction(p);
              },
              child: Text('Find address'),

            )
        )
    );
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }
}*/
/*

import 'dart:async';

import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'dart:math';

const kGoogleApiKey = "AIzaSyC60FAUrau6vWu6GJ0NLFhHIGLskW1nkOQ";

// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

main() {
  runApp(RoutesWidget());
}

final customTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  accentColor: Colors.redAccent,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.00)),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 12.50,
      horizontal: 10.00,
    ),
  ),
);

class RoutesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: "My App",
    theme: customTheme,
    routes: {
      "/": (_) => MyApp(),
      "/search": (_) => CustomSearchScaffold(),
    },
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _MyAppState extends State<MyApp> {
  Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text("My App"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildDropdownMenu(),
              RaisedButton(
                onPressed: _handlePressButton,
                child: Text("Search places"),
              ),
              RaisedButton(
                child: Text("Custom"),
                onPressed: () {
                  Navigator.of(context).pushNamed("/search");
                },
              ),
            ],
          )),
    );
  }

  Widget _buildDropdownMenu() => DropdownButton(
    value: _mode,
    items: <DropdownMenuItem<Mode>>[
      DropdownMenuItem<Mode>(
        child: Text("Overlay"),
        value: Mode.overlay,
      ),
      DropdownMenuItem<Mode>(
        child: Text("Fullscreen"),
        value: Mode.fullscreen,
      ),
    ],
    onChanged: (m) {
      setState(() {
        _mode = m;
      });
    },
  );

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: "fr",
      components: [Component(Component.country, "fr")],
    );

    displayPrediction(p, homeScaffoldKey.currentState);
  }
}

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    // get detail (lat/lng)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
  }
}

// custom scaffold that handle search
// basically your widget need to extends [GooglePlacesAutocompleteWidget]
// and your state [GooglePlacesAutocompleteState]
class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
    apiKey: kGoogleApiKey,
    sessionToken: Uuid().generateV4(),
    language: "en",
    components: [Component(Component.country, "in")],
  );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState);
      },
      logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      searchScaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Got answer")),
      );
    }
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}*/
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:places_auto/Players.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AutoComplete(),
      ),
    );
  }
}

class AutoComplete extends StatefulWidget {
  @override
  _AutoCompleteState createState() => new _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  GlobalKey<AutoCompleteTextFieldState<Players>> key = new GlobalKey();

  AutoCompleteTextField searchTextField;

  TextEditingController controller = new TextEditingController();

  _AutoCompleteState();

  void _loadData() async {
    await PlayersViewModel.loadPlayers();
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Auto Complete List Demo'),
        ),
        body: new Center(
            child: new Column(children: <Widget>[
          new Column(children: <Widget>[
            searchTextField = AutoCompleteTextField<Players>(
                style: new TextStyle(color: Colors.black, fontSize: 20.0),
                decoration: new InputDecoration(
                    suffixIcon: Container(
                      width: 85.0,
                      height: 60.0,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                    filled: true,
                    hintText: 'Search Player Name',
                    hintStyle: TextStyle(color: Colors.black)),
                itemSubmitted: (item) {
                  setState(() => searchTextField.textField.controller.text =
                      item.autocompleteterm);
                },
                clearOnSubmit: false,
                key: key,
                suggestions: PlayersViewModel.players,
                itemBuilder: (context, item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          item.autocompleteterm,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          item.country,
                        ),
                      )
                    ],
                  );
                },
                itemSorter: (a, b) {
                  return a.autocompleteterm.compareTo(b.autocompleteterm);
                },
                itemFilter: (item, query) {
                  return item.autocompleteterm
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                }),
          ]),
        ])));
  }
}
