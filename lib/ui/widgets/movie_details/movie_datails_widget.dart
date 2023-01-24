import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/resources.dart';
import 'package:flutter_application_1/ui/theme/colors.dart';
import 'package:flutter_application_1/ui/widgets/movie_details/movie_details_cast_info_widget.dart';
import 'package:flutter_application_1/ui/widgets/movie_details/movie_details_main_info_widget.dart';

class MovieDatailsWidget extends StatelessWidget {
  int id;

  MovieDatailsWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 30, 46, 1),
      appBar: AppBar(
        title: const Text('Puss in Boots: The Last Wish'),
      ),
      body: ListView(
        children: const [
          MovieDetailsMainInfoWidget(),
          SizedBox(height: 30),
          MovieDetailsCastInfoWidget()
        ],
      ),
    );
  }
}
