// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propnex_test/pages/search_page.dart';

import 'package:propnex_test/widgets/v_widgets.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: Text(
          "Ditonton",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => SearchPage())),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              CardMovieNowPlaying(title: "Now Playing", type: "now_playing", seeMore: false),
              SizedBox(
                height: 16,
              ),
              // CardMoviePopular(title: "Popular", seeMore: false),
              CardMovieNowPlaying(title: "Popular", type: "popular", seeMore: false),
              SizedBox(
                height: 16,
              ),
              CardMovieTopRated(title: "Top Rated", seeMore: false),
            ],
          ),
        ),
      ),
    );
  }
}
