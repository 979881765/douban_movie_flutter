import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban_movie_flutter/model/movie_subject.dart';
import 'package:douban_movie_flutter/utils/screen_util.dart';
import 'package:douban_movie_flutter/widget/skeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shimmer/shimmer.dart';

class BillboardBanner extends StatelessWidget {
  var title;
  List<MovieSubject> movieSubjects;

  BillboardBanner({this.title, this.movieSubjects});

  @override
  Widget build(BuildContext context) {
    final height = 190.0;
    return InkWell(
      onTap: () {
        showToast('查看榜单:${title}');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: ScreenUtil.width,
                height: height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        movieSubjects[0].images.medium),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.2),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  width: ScreenUtil.width,
                  height: height * 0.45,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Center(
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _buildMovieInfoItem(index, movieSubjects[index]);
                        },
                        itemCount: 3),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieInfoItem(int index, MovieSubject movieSubject) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '${index + 1}. ${movieSubject.title}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 15),
            Text(
              '${movieSubject.rating.average}',
              style: TextStyle(
                color: Color(0xFFD7B018),
                fontSize: 14,
              ),
            )
          ],
        ),
        SizedBox(height: 5),
      ],
    );
  }
}

class BillboardBannerSkeleton extends StatelessWidget {
  var isDark;

  BillboardBannerSkeleton();

  @override
  Widget build(BuildContext context) {
    isDark = Theme.of(context).brightness == Brightness.dark;

    final height = 190.0;
    return Shimmer.fromColors(
        period: Duration(milliseconds: 1200),
        baseColor: isDark ? Colors.grey[700] : Colors.grey[350],
        highlightColor: isDark ? Colors.grey[500] : Colors.grey[200],
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Stack(
            children: <Widget>[
              Align(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xAAFDFDFD),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(-0.6, -0.2),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 14,
                  width: ScreenUtil.width,
                  decoration: SkeletonDecoration(isDark: isDark),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    width: ScreenUtil.width,
                    height: height * 0.45,
                    child: Center(
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return _buildMovieInfoItemSkeleton(index);
                          },
                          itemCount: 3),
                    )),
              ),
            ],
          ),
        ));
  }

  Widget _buildMovieInfoItemSkeleton(int index) {
    return Column(
      children: <Widget>[
        Container(
          width: ScreenUtil.width,
          margin: EdgeInsets.symmetric(horizontal: 30),
          height: 8,
          decoration: SkeletonDecoration(isDark: isDark),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}