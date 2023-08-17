// FutureBuilder<List<NewsModel>>(
//                 future: _getNewsHot.getNewsList(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   return Column(children: <Widget>[
//                      Padding(
//                         padding: const EdgeInsets.only(top: 15, left: 15),
//                         child: Align(
//                             alignment: Alignment.topLeft,
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.new_releases,
//                                   size: 30,
//                                   color: Colors.yellow,
//                                 ),
//                                 Text('ข่าวล่าสุด  ',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                         letterSpacing: 1)),
//                               ],
//                             )),
//                       ),
//                       CarouselSlider.builder(
//                           itemCount: snapshot.data?.length,
//                           options: CarouselOptions(
//                             scrollDirection: Axis.horizontal,
//                             height: 150,
//                             initialPage: 2,
//                           ),
//                           itemBuilder: (BuildContext context, int i,
//                                   int realIndex) =>
//                               Container(
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         PageTransition(
//                                             child: Details(
//                                                 list: _getNews.data, index: i),
//                                             type: PageTransitionType
//                                                 .rightToLeftWithFade));
//                                   },
//                                   child: Card(
        
//                                       //elevation: 5,
        
//                                       child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: Stack(children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                               colorFilter: ColorFilter.mode(
//                                                   Colors.black87.withOpacity(0.1),
//                                                   BlendMode.darken),
//                                               fit: BoxFit.cover,
//                                               image: NetworkImage("${Api().domain}/" +
//                                                   '${snapshot.data?[i].newsImg}')),
//                                         ),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             Align(
//                                               alignment: Alignment.bottomLeft,
//                                               child: Container(
//                                                 padding: EdgeInsets.all(5),
//                                                 margin: EdgeInsets.only(
//                                                   left: 10,
//                                                 ),
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.blue
//                                                       .withOpacity(0.8),
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                 ),
//                                                 child: Text(
//                                                   '${snapshot.data?[i].newsType}',
//                                                   style: TextStyle(
//                                                       color: Colors.white),
//                                                 ),
//                                               ),
//                                             ),
//                                             Align(
//                                                 alignment: Alignment.bottomLeft,
//                                                 child: Container(
//                                                   padding: EdgeInsets.only(
//                                                       left: 10,
//                                                       bottom: 5,
//                                                       right: 5),
//                                                   width: double.infinity,
//                                                   decoration: BoxDecoration(
//                                                       gradient: LinearGradient(
//                                                           begin: Alignment
//                                                               .bottomCenter,
//                                                           end:
//                                                               Alignment.topCenter,
//                                                           colors: <Color>[
//                                                         Color.fromARGB(
//                                                             255, 24, 24, 24),
//                                                         Colors.transparent
//                                                       ])),
//                                                   child: Stack(children: [
//                                                     Text(
//                                                       '${snapshot.data?[i].newsTitle}',
//                                                       //maxLines: 2,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: TextStyle(
//                                                           shadows: [
//                                                             Shadow(
//                                                               blurRadius: 10,
//                                                               color:
//                                                                   Color.fromARGB(
//                                                                       255,
//                                                                       24,
//                                                                       24,
//                                                                       24),
//                                                               offset:
//                                                                   Offset(1, 1),
//                                                             )
//                                                           ],
//                                                           letterSpacing: 0.5,
//                                                           fontSize: 20,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           color: Colors.white),
//                                                     ),
//                                                     Container(
//                                                       margin:
//                                                           const EdgeInsets.only(
//                                                               top: 30),
//                                                       //padding: const EdgeInsets.all(8.0),
//                                                       child: Text(
//                                                         DateFormat.yMMMMd('en_US')
//                                                             .format(DateTime.parse(
//                                                                 '${snapshot.data?[i].newsDate}')),
//                                                         style: TextStyle(
//                                                             color: Colors.white),
//                                                       ),
//                                                     ),
//                                                   ]),
//                                                 )),
//                                           ],
//                                         ),
//                                       ),
//                                     ]),
//                                   )),
//                                 ),
//                               )),
//                   ],);
//                 })



// -------------------------------------------------------------------------------------

// Padding(
//                         padding: const EdgeInsets.only(top: 15, left: 15),
//                         child: Align(
//                             alignment: Alignment.topLeft,
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.newspaper,
//                                   size: 30,
//                                   color: Colors.blue,
//                                 ),
//                                 Text('ข่าวทั้งหมด ',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                         letterSpacing: 1)),
//                               ],
//                             )),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         padding: const EdgeInsets.all(10),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (BuildContext context, int i) {
//                           return InkWell(
//                               onTap: () {},
//                               child: Container(
//                                   height: 100,
//                                   margin: const EdgeInsets.all(8),
//                                   child: Row(children: <Widget>[
//                                     Card(
//                                       clipBehavior: Clip.antiAlias,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(24),
//                                       ),
//                                       child: AspectRatio(
//                                           aspectRatio: 1,
//                                           child: Image.network(
//                                             "${Api().domain}/" +
//                                                 '${snapshot.data?[i].newsImg}',
//                                             fit: BoxFit.cover,
//                                           )),
//                                     ),
//                                     SizedBox(
//                                       width: 16,
//                                     ),
//                                     Flexible(
//                                         child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Text(
//                                           '${snapshot.data?[i].newsTitle}',
//                                           overflow: TextOverflow.ellipsis,
//                                           style: const TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           '${snapshot.data?[i].newsDetail}',
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                         Text(
//                                           DateFormat.yMMMMd('en_US').format(
//                                               DateTime.parse(
//                                                   '${snapshot.data?[i].newsDate}')),
//                                           style: TextStyle(color: Colors.grey),
//                                         ),
//                                       ],
//                                     ))
//                                   ])));
//                         },
//                       ),