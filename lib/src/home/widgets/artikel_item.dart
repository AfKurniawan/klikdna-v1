import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/home/models/artikel_model.dart';

class ArtikelItem extends StatefulWidget {
  final Artikel model;

  const ArtikelItem({
    Key key, this.model
  }) : super(key: key);

  @override
  _ArtikelItemState createState() => _ArtikelItemState();
}

class _ArtikelItemState extends State<ArtikelItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushNamed("detail_artikel_page", arguments: widget.model);
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    imageUrl: AppConstants.IMAGE_ARTIKEL_URL+ widget.model.image,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 7,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Expanded(
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(widget.model.title,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Row(
                children: [
                  Flexible(
                      child: Text(widget.model.description, overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(color: Colors.grey, fontSize: 14))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}