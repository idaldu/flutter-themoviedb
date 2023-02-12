// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/data_providers/session_data_provider.dart';
import 'package:flutter_application_1/library/widgets/inherited/notifier_provider.dart';
import 'package:flutter_application_1/ui/widgets/movie_list/movie_list_widget.dart';
import 'package:flutter_application_1/ui/widgets/movie_list/movie_list_widget_model.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedIndex = 0;
  final movieListModel = MovieListWidgetModel();

  void onSelectedTab(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  // тут мы загружаем локаль и после нее загружаем фильмы:
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieListModel.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text('TMDB'),
        actions: [
          IconButton(
            // тут важный момент, в me_app_model у нас создан экземпляр провайдера, а тут мы глобально удаляем SessionId и тем самым выходим из сессии, так как экземпляр ссылается на класс:
            onPressed: () => SessionDataProvider().setSessionId(null),
            icon: const Icon(Icons.logout_outlined),
          )
        ],
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          TextWidget(
            text: 'Новости',
          ),
          NotifierProvider(
            model: movieListModel,
            isManagingModel: false,
            child: const MovieListWidget(),
          ),
          TextWidget(
            text: 'Сериалы',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Новости',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Фильмы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Сериалы',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (value) => onSelectedTab(value),
      ),
    );
  }
}

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  String text;

  TextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
