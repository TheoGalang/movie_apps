// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../providers/detail_provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.idMovie}) : super(key: key);
  final int idMovie;

  @override
  Widget build(BuildContext context) {
    final detailState = Provider.of<DetailProvider>(context, listen: true);
    detailState.getDetailMovie == null
        ? detailState.getMovieById(idMovie)
        : print("sukses");
    detailState.getRecommended == null
        ? detailState.getMoviesRecommended(idMovie)
        : print("sukses");
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
                onTap: () {
                  detailState.getDetailMovie = null;
                  detailState.getRecommended = null;
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 20,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                )),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              detailState.getDetailMovie == null
                  ? Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: Colors.yellow,
                        ),
                      ),
                    )
                  : Hero(
                      tag: "imageDetails",
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500/${detailState.getDetailMovie!.posterPath}",
                        imageBuilder: (context, imageProvider) => Container(
                          width: 120,
                          decoration: BoxDecoration(
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
              Consumer<DetailProvider>(
                builder: (context, detailState, child) => detailState
                            .getDetailMovie ==
                        null
                    ? Container()
                    : DraggableScrollableSheet(
                        initialChildSize: 0.4,
                        minChildSize: 0.25,
                        maxChildSize: 0.8,
                        builder: (context, controller) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                color: Colors.black,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    top: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width: 50,
                                        height: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    controller: controller,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 24),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                detailState.getDetailMovie ==
                                                        null
                                                    ? ""
                                                    : detailState
                                                        .getDetailMovie!.title!,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 32),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                width: 120,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.check),
                                                    Text(
                                                      "Watchlist",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                  children: detailState
                                                      .getDetailMovie!.genres!
                                                      .map((e) => Text(
                                                            detailState.getDetailMovie ==
                                                                    null
                                                                ? ""
                                                                : "${e.name!}, ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ))
                                                      .toList()),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                detailState.getDetailMovie ==
                                                        null
                                                    ? ""
                                                    : "${detailState.getDetailMovie!.runtime.toString()} minutes",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  RatingBar.builder(
                                                    initialRating: detailState
                                                            .getDetailMovie!
                                                            .voteAverage! /
                                                        10 *
                                                        5,
                                                    ignoreGestures: true,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 20,
                                                    unratedColor: Colors.grey,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      null;
                                                    },
                                                  ),
                                                  Text(
                                                    detailState.getDetailMovie ==
                                                            null
                                                        ? ""
                                                        : detailState
                                                            .getDetailMovie!
                                                            .voteAverage!
                                                            .toStringAsFixed(1),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 24,
                                              ),
                                              Text(
                                                "Overview",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                detailState.getDetailMovie ==
                                                        null
                                                    ? ""
                                                    : detailState
                                                        .getDetailMovie!
                                                        .overview!,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Recommendations",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  SizedBox(
                                                    height: 150,
                                                    child: ListView.separated(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: detailState
                                                              .getRecommended
                                                              ?.results
                                                              ?.length ??
                                                          5,
                                                      shrinkWrap: true,
                                                      itemBuilder: (context,
                                                              index) =>
                                                          detailState.getRecommended ==
                                                                  null
                                                              ? Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .yellow,
                                                                  ),
                                                                )
                                                              : InkWell(
                                                                  onTap: () => Timer(
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                      () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (_) => DetailPage(
                                                                                  idMovie: detailState.getRecommended!.results![index].id!,
                                                                                )));
                                                                  }),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        "https://image.tmdb.org/t/p/w500/${detailState.getRecommended?.results?[index].posterPath}",
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                      width:
                                                                          120,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              imageProvider,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        color: Colors
                                                                            .yellow,
                                                                      ),
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                                  ),
                                                                ),
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return SizedBox(
                                                          width: 15,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
              ),
            ],
          )),
    );
  }
}
