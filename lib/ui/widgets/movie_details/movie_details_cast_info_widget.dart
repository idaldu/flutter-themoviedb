import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/resources.dart';
import 'package:flutter_application_1/ui/theme/colors.dart';

class MovieDetailsCastInfoWidget extends StatelessWidget {
  const MovieDetailsCastInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainWhite,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text('Top Billed Cast',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
          const SizedBox(height: 30),
          SizedBox(
            height: 260,
            child: ListView.builder(
                itemCount: 10,
                itemExtent: 160,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.mainGrey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mainBlack.withOpacity(0.2),
                            blurRadius: 8,
                          )
                        ],
                        color: AppColors.mainWhite),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Image(
                          width: 170,
                          image: AssetImage(AppImages.actor),
                          fit: BoxFit.fitWidth,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Antonio Banderas',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text(
                                'Puss in Boots (voice)',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                })),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Full Cast & Crew',
              style: TextStyle(
                color: AppColors.mainBlack,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
