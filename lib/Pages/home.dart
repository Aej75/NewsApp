
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../model/article_model.dart';
import '../models/newsModel.dart';
import '../newsBloc.dart';
import '../repos/news_repos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String catagory = 'science';

  Future<List<Articles>> api() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$catagory&apiKey=315e2c5c75164bfeb0e20f97e1efdb75";

    Response res = await get(Uri.parse(url));
    print(res.statusCode);

    var data = jsonDecode(res.body);
    var articleData = data['articles'];

    List<Articles> articleList = [];

    for (var i in articleData) {
      Articles aData = Articles(
          // source: i['source'],
          author: i['author'],
          title: i['title'],
          url: i['url'],
          urlToImage: i['urlToImage'],
          publishedAt: i['publishedAt'],
          description: i['description'],
          content: i['content']);
      articleList.add(aData);
    }
    print(articleList[0]);

    return articleList;
  }

  late ArticlesModel articlesModel = ArticlesModel();

  @override
  Widget build(BuildContext context) {
    ShowNews catagory = ShowNews(articlesModel, this.catagory);

    final newsBloc = BlocProvider.of<NewsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("News App", style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
        if (state is NotFetched) {
          return FutureBuilder<List<Articles>>(
              future: api(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //let's check if we got a response or not
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 70,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  this.catagory = 'science';
                                  newsBloc.add(FetchNews(this.catagory));
                                });
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                                      width: 110,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      width: 110,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: this.catagory == 'science'
                                          ? const Text('Science',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))
                                          : const Text(
                                              "Science",style: TextStyle(
                                        color: Colors.white,)
                                            ))
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  this.catagory = 'sports';
                                  newsBloc.add(FetchNews(this.catagory));
                                });
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80',
                                      width: 110,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 110,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: this.catagory == 'sports'
                                        ? const Text('Sports',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18))
                                        : const Text(
                                            "Sports",style: TextStyle(
                                      color: Colors.white,)
                                          ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  this.catagory = 'business';
                                  newsBloc.add(FetchNews(this.catagory));
                                });
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1591696205602-2f950c417cb9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                                      width: 110,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      width: 110,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    child: this.catagory == 'business'
                                        ? const Text('Business',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))
                                        : const Text(
                                      "Business",style: TextStyle(
                                      color: Colors.white,)
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  this.catagory = 'entertainment';
                                  newsBloc.add(FetchNews(this.catagory));
                                });
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1603739903239-8b6e64c3b185?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171',
                                      width: 110,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      width: 110,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    child: this.catagory == 'entertainment'
                                        ? const Text('Entertainment',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))
                                        : const Text(
                                      "Entertainment",style: TextStyle(
                                      color: Colors.white,)
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Flexible(
                        child: ListView.builder(
                            padding: const EdgeInsets.only(top: 20,bottom: 20),
                            //Now let's create our custom List tile
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.data[index].urlToImage != null &&
                                  snapshot.data[index].description != null) {
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: 250,
                                          child: Image.network(
                                            '${snapshot.data[index].urlToImage}',
                                            height: 200,
                                            fit: BoxFit.fitWidth,
                                          )),
                                      Text(
                                        snapshot.data[index].title,
                                        style: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'SourceSansPro'),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapshot.data[index].description,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'SourceSansPro',

                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Text('No Image Found'),
                                        ),
                                        height: 200,
                                      ),
                                      Text(
                                        snapshot.data[index].title,
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text("no Description available!",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Raleway')),
                                    ],
                                  ),
                                );
                              }

                              // return ListTile(
                              //   title: Text(snapshot.data[index].title),
                              //   trailing: Image.network(
                              //       '${snapshot.data[index].urlToImage}'),
                              // );
                            }),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
        } else if (state is Fetching) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Fetched) {
          return ShowNews(state.getNews, 'business');
        } else {
          return Center(child: const CircularProgressIndicator());
        }
      }
          // child: FutureBuilder<List<Articles>>(
          //     future: api(),
          //     builder: (BuildContext context, AsyncSnapshot snapshot) {
          //       //let's check if we got a response or not
          //       if (snapshot.hasData) {
          //         return Column(
          //           children: [
          //             SizedBox(height: 10.0,),
          //             SizedBox(
          //
          //               height: 70,
          //               child: ListView(
          //                 scrollDirection: Axis.horizontal,
          //                 children: [
          //                   const SizedBox(
          //                     width: 10,
          //                   ),
          //                   Stack(
          //                     children: [
          //                       ClipRRect(
          //                         borderRadius: BorderRadius.circular(8),
          //                         child: Image.network(
          //                           'https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
          //                           width: 110,
          //                           height: 80,
          //                           fit: BoxFit.cover,
          //                         ),
          //                       ),
          //                       Container(
          //                           alignment: Alignment.center,
          //                           width: 110,
          //                           height: 80,
          //                           decoration: BoxDecoration(
          //                               color: Colors.black12,
          //                               borderRadius: BorderRadius.circular(8)),
          //                           child: const Text(
          //                             'Science',
          //                             style: TextStyle(color: Colors.white),
          //                           ))
          //                     ],
          //                   ),
          //                   const SizedBox(
          //                     width: 10,
          //                   ),
          //                   Stack(
          //                     children: [
          //                       ClipRRect(
          //                         borderRadius: BorderRadius.circular(8),
          //                         child: Image.network(
          //                           'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80',
          //                           width: 110,
          //                           height: 80,
          //                           fit: BoxFit.cover,
          //                         ),
          //                       ),
          //                       Container(
          //                           alignment: Alignment.center,
          //                           width: 110,
          //                           height: 80,
          //                           decoration: BoxDecoration(
          //                               color: Colors.black12,
          //                               borderRadius: BorderRadius.circular(8)),
          //                           child: const Text(
          //                             'Sports',
          //                             style: TextStyle(color: Colors.white),
          //                           ))
          //                     ],
          //                   ),
          //                   const SizedBox(
          //                     width: 10,
          //                   ),
          //                   Stack(
          //                     children: [
          //                       ClipRRect(
          //                         borderRadius: BorderRadius.circular(8),
          //                         child: Image.network(
          //                           'https://images.unsplash.com/photo-1512076249812-fd58fb2c8748?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80',
          //                           width: 110,
          //                           height: 80,
          //                           fit: BoxFit.cover,
          //                         ),
          //                       ),
          //                       Container(
          //                           alignment: Alignment.center,
          //                           width: 110,
          //                           height: 80,
          //                           decoration: BoxDecoration(
          //                               color: Colors.black12,
          //                               borderRadius: BorderRadius.circular(8)),
          //                           child: const Text(
          //                             'International',
          //                             style: TextStyle(color: Colors.white),
          //                           ))
          //                     ],
          //                   ),
          //                   const SizedBox(
          //                     width: 10,
          //                   ),
          //                   Stack(
          //                     children: [
          //                       ClipRRect(
          //                         borderRadius: BorderRadius.circular(8),
          //                         child: Image.network(
          //                           'https://images.unsplash.com/photo-1603739903239-8b6e64c3b185?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171',
          //                           width: 110,
          //                           height: 80,
          //                           fit: BoxFit.cover,
          //                         ),
          //                       ),
          //                       Container(
          //                           alignment: Alignment.center,
          //                           width: 110,
          //                           height: 80,
          //                           decoration: BoxDecoration(
          //                               color: Colors.black12,
          //                               borderRadius: BorderRadius.circular(8)),
          //                           child: const Text(
          //                             'Entertainment',
          //                             style: TextStyle(color: Colors.white),
          //                           ))
          //                     ],
          //                   ),
          //                   const SizedBox(
          //                     width: 10,
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             Flexible(
          //               child: ListView.builder(
          //                   padding:const EdgeInsets.all(7),
          //                   //Now let's create our custom List tile
          //                   itemCount: snapshot.data.length,
          //                   itemBuilder: (BuildContext context, int index) {
          //
          //                     if(snapshot.data[index].urlToImage != null && snapshot.data[index].description != null){
          //                       return Container(
          //                         padding: const EdgeInsets.all(5),
          //
          //
          //                         child: Column(
          //                           children: [
          //                             SizedBox(height: 250,child: Image.network('${snapshot.data[index].urlToImage}', height: 200,fit: BoxFit.fitWidth,)),
          //                             Text(snapshot.data[index].title,style: const TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold),),
          //                             const SizedBox(height: 5,),
          //                             Text(snapshot.data[index].description,style: const TextStyle(fontSize: 15),),
          //
          //
          //                           ],
          //                         ),
          //                       );
          //
          //                     }else{
          //                       return Container(
          //                         padding: EdgeInsets.all(5),
          //
          //
          //                         child: Column(
          //                           children: [
          //
          //                             Container(child: Center(child: Text('No Image Found'),), height: 200,  ),
          //                             Text(snapshot.data[index].title,style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold),),
          //                             const SizedBox(height: 5,),
          //                             Text("no Description available!",style: TextStyle(fontSize: 15),),
          //                           ],
          //                         ),
          //                       );
          //                     }
          //
          //
          //
          //                     // return ListTile(
          //                     //   title: Text(snapshot.data[index].title),
          //                     //   trailing: Image.network(
          //                     //       '${snapshot.data[index].urlToImage}'),
          //                     // );
          //                   }),
          //             ),
          //           ],
          //         );
          //       }
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }),
          ),
    );
  }
}

class ShowNews extends StatelessWidget {
  NewsBloc newsBloc = NewsBloc(NewsRepos());

  ArticlesModel articlesModel;
  final catagory;

  ShowNews(this.articlesModel, this.catagory, {Key? key}) : super(key: key);

  Future<List<Articles>> api() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$catagory&apiKey=315e2c5c75164bfeb0e20f97e1efdb75";

    Response res = await get(Uri.parse(url));
    print(res.statusCode);

    var data = jsonDecode(res.body);
    var articleData = data['articles'];

    List<Articles> articleList = [];

    for (var i in articleData) {
      Articles aData = Articles(
          // source: i['source'],
          author: i['author'],
          title: i['title'],
          url: i['url'],
          urlToImage: i['urlToImage'],
          publishedAt: i['publishedAt'],
          description: i['description'],
          content: i['content']);
      articleList.add(aData);
    }
    print(articleList[0]);
    return articleList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Articles>>(
        future: api(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //let's check if we got a response or not
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 70,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          newsBloc.add(FetchNews('science'));
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                                width: 110,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                width: 110,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Text(
                                  'Science',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          newsBloc.add(FetchNews('sports'));
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80',
                                width: 110,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                width: 110,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Text(
                                  'Sports',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1512076249812-fd58fb2c8748?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80',
                              width: 110,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                              alignment: Alignment.center,
                              width: 110,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Text(
                                'International',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1603739903239-8b6e64c3b185?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171',
                              width: 110,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                              alignment: Alignment.center,
                              width: 110,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Text(
                                'Entertainment',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(7),
                      //Now let's create our custom List tile
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data[index].urlToImage != null &&
                            snapshot.data[index].description != null) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 250,
                                    child: Image.network(
                                      '${snapshot.data[index].urlToImage}',
                                      height: 200,
                                      fit: BoxFit.fitWidth,
                                    )),
                                Text(
                                  snapshot.data[index].title,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  snapshot.data[index].description,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Container(
                                  child: Center(
                                    child: Text('No Image Found'),
                                  ),
                                  height: 200,
                                ),
                                Text(
                                  snapshot.data[index].title,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "no Description available!",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          );
                        }

                        // return ListTile(
                        //   title: Text(snapshot.data[index].title),
                        //   trailing: Image.network(
                        //       '${snapshot.data[index].urlToImage}'),
                        // );
                      }),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
