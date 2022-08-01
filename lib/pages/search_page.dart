// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

Timer? _debounce;

class _SearchPageState extends State<SearchPage> {
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: true);
    _onSearchChanged(String query) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        homeProvider.getSearch(query);
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Consumer<HomeProvider>(
                    builder: (context, homeProvider, child) => TextField(
                      controller: homeProvider.searchCtrl,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: _onSearchChanged,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: 'Search Movie',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          homeProvider.getSearchResponse?.results?.isEmpty == true || homeProvider.getSearchResponse == null
              ? Center(
                  child: Text(
                    "No Data Shows",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 24),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          child: Consumer<HomeProvider>(
                            builder: (context, homeProvider, child) =>
                                homeProvider.getSearchResponse?.results
                                            ?.isEmpty ==
                                        true || homeProvider.getSearchResponse == null
                                    ? Center(
                                  child: Text(
                                    "No Data Shows",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                                    : ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: homeProvider
                                                .getSearchResponse
                                                ?.results
                                                ?.length ??
                                            5,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () =>
                                              Timer(Duration(seconds: 1), () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => DetailPage(
                                                          idMovie: homeProvider
                                                              .getSearchResponse!
                                                              .results![index]
                                                              .id!,
                                                        )));
                                          }),
                                          child:CachedNetworkImage(
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/w500/${homeProvider.getSearchResponse?.results?[index].posterPath}",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 120,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: imageProvider,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.yellow,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            width: 15,
                                          );
                                        },
                                      ),
                          ),
                        ),
                      ]),
                )
        ],
      )),
    );
  }
}
