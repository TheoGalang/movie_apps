// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propnex_test/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../pages/detail_page.dart';

class CardMovieNowPlaying extends StatelessWidget {
  CardMovieNowPlaying({Key? key, required this.title, required this.seeMore, required this.type})
      : super(key: key);
  final String title;
  final String type;
  final bool seeMore;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
      print("type = $type , data = ${homeProvider.movieData[type]}" );
      homeProvider.movieData[type] == null
          ? homeProvider.getMovies(type)
          : print("sukses");
    });
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Visibility(
                visible: seeMore,
                child: GestureDetector(
                  onTap: () {
                    // homeState.getMovies();
                  },
                  child: Row(
                    children: [
                      Text(
                        "See More",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.white,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 200,
            child: Consumer<HomeProvider>(
              builder: (context, homeProvider, _) => homeProvider.movieData[type] ==
                      null
                  ? Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: Colors.yellow,
                        ),
                      ),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          homeProvider.movieData[type]?.results?.length ?? 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          homeProvider.movieData[type] == null
                              ? SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: Colors.yellow,
                                  ),
                                )
                              : InkWell(
                                  onTap: () => Timer(Duration(seconds: 1), () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DetailPage(
                                                  idMovie: homeProvider
                                                      .movieData[type]!
                                                      .results![index]
                                                      .id!,
                                                )));
                                  }),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/w500/${homeProvider.movieData[type]!.results![index].posterPath}",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: imageProvider,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 15,
                        );
                      },
                    ),
            ),
          ),
        ]);
  }
}


class CardMovieTopRated extends StatelessWidget {
  CardMovieTopRated({Key? key, required this.title, required this.seeMore})
      : super(key: key);
  final String title;
  final bool seeMore;

  @override
  Widget build(BuildContext context) {
    final homeState = Provider.of<HomeProvider>(context, listen: false);
    homeState.getMovieTopRatedResponse == null
        ? homeState.getMoviesTopRated("popular")
        : print("sukses");
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Visibility(
                visible: seeMore,
                child: GestureDetector(
                  onTap: () {
                    // homeState.getMovies();
                  },
                  child: Row(
                    children: [
                      Text(
                        "See More",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.white,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 200,
            child: Consumer<HomeProvider>(
              builder: (context, homeState, _) => homeState
                          .getMovieTopRatedResponse ==
                      null
                  ? Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: Colors.yellow,
                        ),
                      ),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          homeState.getMovieTopRatedResponse?.results?.length ??
                              5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => homeState
                                  .getMovieTopRatedResponse ==
                              null
                          ? SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: Colors.yellow,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, __, ___) => DetailPage(
                                          idMovie: homeState
                                              .getMovieTopRatedResponse!
                                              .results![index]
                                              .id!,
                                        )));
    },
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://image.tmdb.org/t/p/w500/${homeState.getMovieTopRatedResponse!.results![index].posterPath}",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: imageProvider,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.yellow,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 15,
                        );
                      },
                    ),
            ),
          ),
        ]);
  }
}
