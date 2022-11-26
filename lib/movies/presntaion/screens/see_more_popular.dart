import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_archeticture_movies/core/utiles/enums.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/service/service_local.dart';
import '../../../core/utiles/constance.dart';
import '../controller/movies_bloc.dart';
import '../controller/movies_event.dart';
import '../controller/movies_state.dart';

class SeeMorePoPular extends StatelessWidget {
  const SeeMorePoPular({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MoviesBloc>()
        ..add(
          GetPopularEvent(),
        ),
      child: BlocBuilder<MoviesBloc, MoviesState>(
        buildWhen: (previous, current) =>
            previous.nowPopularState != current.nowPopularState,
        builder: (context, state) {
          switch (state.nowPopularState) {
            case RequestState.loading:
              print("object");
              return Container(
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.grey[850],
                )),
              );
            case RequestState.loaded:
              print("333");
              return Scaffold(
                backgroundColor: Color(192734).withOpacity(0.1),
                body: ListView.separated(
                  itemCount: state.nowPopularMovies.length,
                  itemBuilder: ((context, index) {
                    final x = state.nowPopularMovies[index];
                    return Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(20),
                        gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade800.withOpacity(0.3),
                              Colors.black26,
                              Colors.black38,
                              Colors.black54,
                              Colors.grey.shade800.withOpacity(0.4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            tileMode: TileMode.clamp),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                useOldImageOnUrlChange: true,
                                height: 170,
                                width: 100,
                                fit: BoxFit.cover,
                                imageUrl: Appconstance.imageUrl(x.backdropPath),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[850]!,
                                  highlightColor: Colors.grey[800]!,
                                  child: Container(
                                    height: 170.0,
                                    width: 120.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  ListTile(
                                    isThreeLine: true,
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          x.title,
                                          style: GoogleFonts.poppins(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      x.overview,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    );
                    // return Card(
                    //   elevation: 3,
                    //   shadowColor: Colors.grey,
                    //   color: Colors.grey.shade900,
                    //   child: ListTile(
                    //     isThreeLine: true,
                    //     leading: CachedNetworkImage(
                    //       fit: BoxFit.cover,
                    //       imageUrl: Appconstance.imageUrl(x.backdropPath!),
                    //     ),
                    //     title: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Text(
                    //         x.title,
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 20,
                    //             color: Colors.white70),
                    //       ),
                    //     ),
                    //     subtitle: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Text(
                    //         x.overview,
                    //         maxLines: 4,
                    //         style: TextStyle(
                    //             color: Colors.grey.shade600,
                    //             fontSize: 18,
                    //             fontStyle: FontStyle.italic),
                    //       ),
                    //     ),
                    //   ),
                    // );
                  }),
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(color: Colors.grey),
                  ),
                ),
              );

            case RequestState.erorr:
              return SizedBox(
                height: 400,
                child: Center(
                  child: Text(state.nowPlayingmessage),
                ),
              );
          }
        },
      ),
    );
  }
}
