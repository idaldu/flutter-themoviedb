import 'package:flutter/material.dart';
import 'package:flutter_application_1/library/widgets/inherited/notifier_provider.dart';
import 'package:flutter_application_1/ui/widgets/movie_details/movie_details_cast_info_widget.dart';
import 'package:flutter_application_1/ui/widgets/movie_details/movie_details_main_info_widget.dart';
import 'package:flutter_application_1/ui/widgets/movie_details/movie_details_widget_model.dart';

// ignore: must_be_immutable
class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // тут мы производим установку локализации и загрузку содержимого:
    NotifierProvider.read<MovieDetailsWidgetModel>(context)
        ?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 30, 46, 1),
      appBar: AppBar(
        title: const _TitleWidget(),
      ),
      body: const _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsWidgetModel>(context);
    final movieDetails = model?.movieDetails;
    if (movieDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: const [
        MovieDetailsMainInfoWidget(),
        SizedBox(height: 30),
        MovieDetailsCastInfoWidget()
      ],
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsWidgetModel>(context);
    return Text(model?.movieDetails?.title ?? 'Загрузка...');
  }
}
