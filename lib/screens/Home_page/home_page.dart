import 'package:flutter/material.dart';
import 'package:nasa/data/data.dart';
import 'package:nasa/helpers/extensions.dart';
import 'package:nasa/screens/Home_page/app_drawer.dart';
import 'package:nasa/screens/meaning/meaning.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static List<String> _abbreviationKeys = [];
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _abbreviationKeys = abbreviations.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NASA Abbreviations"),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextField(
              controller: _controller,
              onChanged: (t) {
                _abbreviationKeys = abbreviations.keys
                    .where((element) => element.startsWith(t))
                    .toList();
                setState(() {});
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'Type Something',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                suffixIcon: IconButton(
                  onPressed: () {
                    _abbreviationKeys = abbreviations.keys.toList();
                    FocusScope.of(context).unfocus();
                    setState(() {});
                    _controller.clear();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
          ),
          Flexible(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: _abbreviationKeys.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20)
                        .copyWith(top: 10),
                    color: context.colorScheme.secondaryContainer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: CircleAvatar(
                          backgroundColor: context.colorScheme.primary,
                          child: Text(
                            _abbreviationKeys[i][0],
                            style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onPrimary),
                          ),
                        ),
                      ),
                      title: Text(
                        _abbreviationKeys[i],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      subtitle: Text(
                        abbreviations[_abbreviationKeys[i]] ?? '',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      contentPadding: const EdgeInsets.all(5.0),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MeaningPage(
                            text: _abbreviationKeys[i],
                            list: _abbreviationKeys,
                            map: abbreviations,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
