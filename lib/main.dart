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
        child: new Column(
          children: <Widget>[
            new Column(
              children: <Widget>[
                searchTextField = AutoCompleteTextField<Players>(
                    style: new TextStyle(color: Colors.black, fontSize: 20.0),
                    decoration: new InputDecoration(
                        suffixIcon: Container(
                          width: 85.0,
                          height: 60.0,
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                        filled: true,
                        hintText: 'Search City Name',
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
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                item.autocompleteterm,
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                          ),
                          /**
                       * Consider setting mainAxisSize to MainAxisSize.min and using FlexFit.loose fits for the flexible children (using Flexible rather than Expanded). This will allow the flexible children to size themselves to less than the infinite remaining space they would otherwise be forced to take, and then will cause the RenderFlex to shrink-wrap the children rather than expanding to fit the maximum constraints provided by the parent.
                       * 
                       */
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                item.country,
                              ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
