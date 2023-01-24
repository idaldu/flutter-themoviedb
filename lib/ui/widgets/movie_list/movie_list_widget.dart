import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/resources.dart';
import 'package:flutter_application_1/ui/theme/app_text_field_style.dart';
import 'package:flutter_application_1/ui/theme/app_text_style.dart';
import 'package:flutter_application_1/ui/theme/colors.dart';
import 'package:flutter_application_1/ui/widgets/movie_list/movie_list_widget_model.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _model = MovieListWidgetModel();
  @override
  Widget build(BuildContext context) {
    return MovieListWidgetModelProvider(
        model: _model, child: const ListWidget());
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = MovieListWidgetModelProvider.watch(context)?.model;
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 60),
          itemCount: model?.filteredMovies.length,
          itemExtent: 200,
          itemBuilder: (BuildContext context, int index) {
            final movie = model?.filteredMovies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.mainBlack.withOpacity(0.2)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mainBlack.withOpacity(0.1),
                          blurRadius: 8,
                        )
                      ],
                      color: AppColors.mainWhite,
                    ),
                    child: Row(
                      children: [
                        Image(
                            image: AssetImage(
                                movie?.imageName ?? AppImages.moviePlacholder)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie?.title ?? '',
                                  style: AppTextStyle.boldText,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  movie?.time ?? '',
                                  style: AppTextStyle.greyText,
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  movie?.description ?? '',
                                  style: const TextStyle(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => model?.onMovieTap(context, index),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: TextField(
            decoration: AppTextFieldStyle.searchTextField,
            onChanged: (value) => model?.searchMovies(value),
          ),
        ),
      ],
    );
  }
}
