import 'package:douban_movie_flutter/i10n/localization_intl.dart';
import 'package:douban_movie_flutter/model/cast_vo.dart';
import 'package:douban_movie_flutter/model/director_vo.dart';
import 'package:douban_movie_flutter/model/movie_detail_vo.dart';
import 'package:douban_movie_flutter/model/writer_vo.dart';
import 'package:douban_movie_flutter/service/router_manager.dart';
import 'package:douban_movie_flutter/utils/screen_util.dart';
import 'package:douban_movie_flutter/widget/cache_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'movie_detail_section_widget.dart';

/**
 * 电影详情页演员列表组件
 */
class MovieDetailStaffListWidget extends StatelessWidget {
  final MovieDetailVo movieDetailVo;
  List<DirectorVo> _directorList;
  List<WriterVo> _writerList;
  List<CastVo> _castList;

  MovieDetailStaffListWidget(this.movieDetailVo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _directorList = movieDetailVo.directors;
    _writerList = movieDetailVo.writers;
    _castList = movieDetailVo.casts;

    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieDetailSectionWidget(title: DouBanLocalizations.of(context).staff_list),
          SizedBox(height: 10),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: List.generate(
                    _directorList.length +
                        _writerList.length +
                        _castList.length, (index) {
                  if (_directorList.length > 0 &&
                      index < _directorList.length) {
                    return _buildStaffItem(
                        context: context,
                        id: _directorList[index].id,
                        avatars: _directorList[index].avatars?.small,
                        name: _directorList[index].name,
                        post: DouBanLocalizations.of(context).director);
                  } else if (_writerList.length > 0 &&
                      index < _directorList.length + _writerList.length) {
                    return _buildStaffItem(
                        context: context,
                        id: _writerList[index - _directorList.length].id,
                        avatars: _writerList[index - _directorList.length]
                            .avatars
                            ?.small,
                        name: _writerList[index - _directorList.length].name,
                        post: DouBanLocalizations.of(context).writer);
                  } else {
                    return _buildStaffItem(
                        context: context,
                        id: _castList[index -
                                _directorList.length -
                                _writerList.length]
                            .id,
                        avatars: _castList[index -
                                _directorList.length -
                                _writerList.length]
                            .avatars
                            ?.small,
                        name: _castList[index -
                                _directorList.length -
                                _writerList.length]
                            .name);
                  }

                  return _buildStaffItem();
                }),
              ))
        ],
      ),
    );
  }

  Widget _buildStaffItem(
      {BuildContext context,
      String id,
      String avatars,
      String name,
      String post}) {
    var itemWidth = (ScreenUtil.width - 60) / 4;
    var itemHeight = itemWidth * 4 / 3;

    return InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(RouteName.staffDetailPage, arguments: id);
        },
        child: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CacheImageWidget(
                  url: avatars,
                  radius: 5,
                  width: itemWidth,
                  height: itemHeight,
                ),
                SizedBox(height: 4),
                SizedBox(
                  width: itemWidth,
                  child: Text(
                    post == null ? name : '[$post]$name',
                    style: TextStyle(
                      color: Color(0xAAFFFFFF),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            SizedBox(width: 10),
          ],
        ));
  }
}
