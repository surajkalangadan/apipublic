import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Bloc/anime_bloc.dart';
import '../Repository/modelclass/AimeModel.dart';

class screen1 extends StatefulWidget {
  const screen1({super.key});

  @override
  State<screen1> createState() => _screen1State();
}
late AimeModel anime;
class _screen1State extends State<screen1> {
  @override
  void initState() {
    BlocProvider.of<AnimeBloc>(context)
        .add(FetchAnime());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<AnimeBloc, AnimeState>(
        builder: (context, state) {
      if (state is AnimeblocLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is AnimeblocError) {
        return RefreshIndicator(
          onRefresh: () async {
            return BlocProvider.of<AnimeBloc>(context)
                .add(FetchAnime());
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
                height: MediaQuery.of(context).size.height * .9,
                // color: Colors.red,
                child:
                const Center(child: Text('Oops something went wrong'))),
          ),
        );
      }
      if (state is AnimeblocLoaded) {
        anime=BlocProvider.of<AnimeBloc>(context).animeModel;
     return    ListView.builder(
          itemCount: anime.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 100.h,
              width: 325.w,
              color: Colors.black,
              child: Row(
                children: [
                  Container(
                      height: 100.h,
                      width: 100.w,
                      child: Image.network(
                        anime.data![index].image.toString(),
                        fit: BoxFit.fill,
                      )),
                  Padding(
                    padding:EdgeInsets.only(left: 15.w),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NAME : ${anime.data![index].title.toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: "caros",
                              color: Colors.white),
                        ),Text(
                          "Episodes : ${anime.data![index].episodes.toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: "caros",
                              color: Colors.white),
                        ),
                        Text(
                          "Ranking :${anime.data![index].ranking.toString()} ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: "caros",
                              color: Colors.white),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );}else{
        return SizedBox();
      }
      },
      ),
    );
  }
}
