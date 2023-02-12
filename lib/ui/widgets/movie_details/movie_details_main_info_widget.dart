import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/api_client/api_client.dart';
import 'package:flutter_application_1/library/widgets/inherited/notifier_provider.dart';
import 'package:flutter_application_1/ui/theme/colors.dart';
import 'package:flutter_application_1/ui/widgets/elements/radial_percent_widget.dart';
import 'package:flutter_application_1/ui/widgets/movie_details/movie_details_widget_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _HeaderWidget(),
        SizedBox(height: 20),
        _HeaderTitleWidget(),
        SizedBox(height: 20),
        _ScoreMovieWidget(),
        SizedBox(height: 10),
        _MainInfoMovieWidget(),
        SizedBox(height: 20),
        _OverviewMovieWidget(),
        SizedBox(height: 30),
        _PeopleMovieWidget()
      ],
    );
  }
}

class _PeopleMovieWidget extends StatelessWidget {
  const _PeopleMovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Tommy Swerdlow',
                      style: TextStyle(
                          color: AppColors.mainWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Screenplay, Story',
                      style:
                          TextStyle(color: AppColors.mainWhite, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Joel Crawford',
                      style: TextStyle(
                        color: AppColors.mainWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Director',
                      style:
                          TextStyle(color: AppColors.mainWhite, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Tom Wheeler',
                      style: TextStyle(
                          color: AppColors.mainWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Story',
                      style:
                          TextStyle(color: AppColors.mainWhite, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Paul Fisher',
                      style: TextStyle(
                        color: AppColors.mainWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Screenplay',
                      style:
                          TextStyle(color: AppColors.mainWhite, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverviewMovieWidget extends StatelessWidget {
  const _OverviewMovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsWidgetModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model?.movieDetails?.tagline ?? '',
            style: const TextStyle(
              color: AppColors.mainGrey,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          const Text(
            'Overview',
            style: TextStyle(
                color: AppColors.mainWhite,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20),
          Text(
            model?.movieDetails?.overview ?? '',
            style: const TextStyle(
              color: AppColors.mainWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreMovieWidget extends StatelessWidget {
  const _ScoreMovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsWidgetModel>(context);
    var voteAverage = model?.movieDetails?.voteAverage ?? 0;
    voteAverage = voteAverage * 10;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: RadialPercentWidget(
                  percent: voteAverage / 100,
                  fillColor: const Color.fromARGB(255, 10, 23, 25),
                  lineColor: const Color.fromARGB(255, 37, 203, 103),
                  freeColor: const Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 3,
                  child: Text(
                    voteAverage.toStringAsFixed(0),
                    style: const TextStyle(
                        color: AppColors.mainWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'User Score',
                style: TextStyle(
                  color: AppColors.mainWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 1,
          height: 25,
          color: AppColors.mainWhite,
        ),
        Row(
          children: const [
            Icon(
              Icons.play_arrow,
              color: AppColors.mainWhite,
            ),
            SizedBox(width: 5),
            Text('Play Trailer',
                style: TextStyle(
                  color: AppColors.mainWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ))
          ],
        )
      ],
    );
  }
}

class _MainInfoMovieWidget extends StatelessWidget {
  const _MainInfoMovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsWidgetModel>(context);
    if (model == null) return const SizedBox.shrink();
    var mainSummeryText = <String>[];
    var genresNames = <String>[];
    var releaseDate = model.movieDetails?.releaseDate;
    if (releaseDate != null) {
      final stringReleaseDate = model.stringFromDate(releaseDate);
      mainSummeryText.add(stringReleaseDate);
    }
    final productionCountries = model.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      final iso = productionCountries.first.iso;
      mainSummeryText.add('($iso)');
    }
    final runtime = model.movieDetails?.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    mainSummeryText.add(' • ${hours}h ${minutes}m');

    final genres = model.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      for (var genre in genres) {
        final name = '${genre.name[0].toUpperCase()}${genre.name.substring(1)}';
        genresNames.add(name);
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(135, 13, 13, 20)),
        color: const Color.fromARGB(154, 20, 20, 31),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mainWhite),
                    borderRadius: BorderRadius.circular(2)),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: const Text(
                  'PG',
                  style: TextStyle(
                    color: AppColors.mainWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                mainSummeryText.join(' '),
                style: const TextStyle(
                  color: AppColors.mainWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(
            genresNames.join(', '),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.mainWhite,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}

class _HeaderTitleWidget extends StatelessWidget {
  const _HeaderTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsWidgetModel>(context);
    final title = model?.movieDetails?.title ?? '';
    final year = model?.movieDetails?.releaseDate?.year.toString() ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title ',
              style: const TextStyle(
                  color: AppColors.mainWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: '($year)',
              style: const TextStyle(
                  color: AppColors.mainWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsWidgetModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : const CircularProgressIndicator(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: posterPath != null
                  ? Image.network(ApiClient.imageUrl(posterPath))
                  : const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
