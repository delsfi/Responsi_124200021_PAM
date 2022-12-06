import 'package:flutter/material.dart';
import 'data_source.dart';
import 'detail_page1.dart';
import 'matches_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Piala Dunia 2022"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future:
          ListMatchesSource.instance.loadMatches(),

          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              // debugPrint(snapshot.data);
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              return _buildSuccessSection(snapshot.data);
            }
            return _buildLoadingSection();
          },
        ),
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildSuccessSection(List<dynamic> data) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Piala Dunia 2022"),
      // ),
      body: Stack(
        children: [
          Image.asset("assets/piala.jpg", width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,),
          ListView.builder(
            itemBuilder: (context, index) {
              MatchesModel matchesModel = MatchesModel.fromJson(data[index]);
              return InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: ((context) {
                      return DetailPage(id: matchesModel.id.toString(),);
                                    })
                                )),
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.network("https://countryflagsapi.com/png/${matchesModel.homeTeam?.name}",width: 150,height: 150,),
                          Text("${matchesModel.homeTeam?.name}"),
                        ],
                      ),
                      // Image.network("https://countryflagsapi.com/png/Qatar",width: 120,),
                      SizedBox(width: 20,),
                      Text("${matchesModel.homeTeam?.goals}"),
                      SizedBox(width: 20,),
                      Text("-"),
                      SizedBox(width: 20,),
                      Text("${matchesModel.awayTeam?.goals}"),
                      SizedBox(width: 20,),
                      Column(
                        children: [
                          Image.network("https://countryflagsapi.com/png/${matchesModel.awayTeam?.name}",width: 150,height: 150,),
                          Text("${matchesModel.awayTeam?.name}"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  //   return ListView.builder(
  //       itemCount: 48,
  //       itemBuilder: (BuildContext context, int index) {
  //         MatchesModel matchesModel = MatchesModel.fromJson(data[index]);
  //         return Container(
  //           width: double.infinity,
  //           height: 200,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               InkWell(
  //                 onTap: () => Navigator.push(context, MaterialPageRoute(
  //                     builder: ((context) {
  //
  //                       return DetailPage(id: matchesModel.id.toString(),);
  //                     })
  //                 )),
  //                 child: Card(
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Column(
  //                         children: [
  //                           Image.network("https://countryflagsapi.com/png/${matchesModel.homeTeam?.name}",width: 150,height: 150,),
  //                           Text("${matchesModel.homeTeam?.name}"),
  //                         ],
  //                       ),
  //                       // Image.network("https://countryflagsapi.com/png/Qatar",width: 120,),
  //                       SizedBox(width: 20,),
  //                       Text("${matchesModel.homeTeam?.goals}"),
  //                       SizedBox(width: 20,),
  //                       Text("-"),
  //                       SizedBox(width: 20,),
  //                       Text("${matchesModel.awayTeam?.goals}"),
  //                       SizedBox(width: 20,),
  //                       Column(
  //                         children: [
  //                           Image.network("https://countryflagsapi.com/png/${matchesModel.awayTeam?.name}",width: 150,height: 150,),
  //                           Text("${matchesModel.homeTeam?.name}"),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 // child: Card(
  //                 //
  //                 //   child: Column(
  //                 //     mainAxisAlignment: MainAxisAlignment.center,
  //                 //     children: [
  //                 //       Container(
  //                 //         padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
  //                 //         // width: 470,
  //                 //         // height: 150,
  //                 //         child: Row (
  //                 //           mainAxisAlignment: MainAxisAlignment.center,
  //                 //           crossAxisAlignment: CrossAxisAlignment.center,
  //                 //           children: [
  //                 //             Image.network("https://countryflagsapi.com/png/${matchesModel.homeTeam?.name}", width: 190, height: 150,),
  //                 //             SizedBox(width: 10,),
  //                 //             Text("${matchesModel.homeTeam?.goals}"),
  //                 //             SizedBox(width: 10,),
  //                 //             Text(" - "),
  //                 //             SizedBox(width: 10,),
  //                 //             Text("${matchesModel.awayTeam?.goals}"),
  //                 //             SizedBox(width: 10,),
  //                 //             Image.network("https://countryflagsapi.com/png/${matchesModel.awayTeam?.name}", width: 190, height: 150,),
  //                 //           ],
  //                 //         ),
  //                 //       ),
  //                 //       SizedBox(height: 5,),
  //                 //       Text("${matchesModel.homeTeam?.name}                                                           ${matchesModel.awayTeam?.name}"),
  //                 //     ],
  //                 //   ),
  //                 //
  //                 // ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}