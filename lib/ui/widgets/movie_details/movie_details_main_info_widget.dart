import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/resources.dart';
import 'package:flutter_application_1/ui/theme/colors.dart';
import 'package:flutter_application_1/ui/widgets/elements/radial_percent_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        HeaderWidget(),
        SizedBox(height: 20),
        HeaderTitleWidget(),
        SizedBox(height: 20),
        ScoreMovieWidget(),
        SizedBox(height: 10),
        MainInfoMovieWidget(),
        SizedBox(height: 20),
        OverviewMovieWidget(),
        SizedBox(height: 30),
        PeopleMovieWidget()
      ],
    );
  }
}

class PeopleMovieWidget extends StatelessWidget {
  const PeopleMovieWidget({
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
          SizedBox(height: 20),
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

class OverviewMovieWidget extends StatelessWidget {
  const OverviewMovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Say hola to his little friends.',
            style: TextStyle(
              color: AppColors.mainGrey,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Overview',
            style: TextStyle(
                color: AppColors.mainWhite,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20),
          Text(
            'Puss in Boots discovers that his passion for adventure has taken its toll: He has burned through eight of his nine lives, leaving him with only one life left. Puss sets out on an epic journey to find the mythical Last Wish and restore his nine lives.',
            style: TextStyle(
              color: AppColors.mainWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreMovieWidget extends StatelessWidget {
  const ScoreMovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  percent: 0.86,
                  fillColor: const Color.fromARGB(255, 10, 23, 25),
                  lineColor: const Color.fromARGB(255, 37, 203, 103),
                  freeColor: const Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 3,
                  child: const Text(
                    '72',
                    style: TextStyle(
                      color: AppColors.mainWhite,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
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

class MainInfoMovieWidget extends StatelessWidget {
  const MainInfoMovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const Text(
                '12/21/2022 (US) • 1h 43m',
                style: TextStyle(
                  color: AppColors.mainWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            'Animation, Action, Adventure, Comedy, Family, Fantasy',
            style: TextStyle(
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

class HeaderTitleWidget extends StatelessWidget {
  const HeaderTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Puss in Boots: The Last Wish ',
              style: TextStyle(
                  color: AppColors.mainWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: '(2022)',
              style: TextStyle(
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

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Image(image: AssetImage(AppImages.topHeader)),
        Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Image(
                    image: AssetImage(AppImages.topHeaderSubImage)))),
      ],
    );
  }
}
