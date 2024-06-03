import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_application_mobile/SqfLitelocalstorage/NoteDbHelper.dart';
import 'package:flutter_application_mobile/RepeatedFunction/repttext.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../helper/favorite_item_model.dart';

class AddToFavorite extends StatefulWidget {
  final int userId;
  final int id;
  final String type;
  final List<Map<String, dynamic>> details;

  AddToFavorite({
    required this.userId,
    required this.id,
    required this.type,
    required this.details,
  });

  @override
  _AddToFavoriteState createState() => _AddToFavoriteState();
}

class _AddToFavoriteState extends State<AddToFavorite> {
  Color favoriteColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    bool isFavorite = await HiveService.isFavorite(widget.userId, widget.id);
    setState(() {
      favoriteColor = isFavorite ? Colors.red : Colors.white;
    });
  }

  Future<void> _toggleFavorite() async {
    if (favoriteColor == Colors.white) {
      await HiveService.addFavorite(FavoriteItem(
        userId: widget.userId,
        itemId: widget.id,
        itemType: widget.type,
      ));
      Fluttertoast.showToast(
        msg: "Added to Favorite",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      await HiveService.removeFavorite(widget.userId, widget.id);
      Fluttertoast.showToast(
        msg: "Removed from Favorite",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    _checkFavoriteStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width / 2,
            child: Container(
              height: 55,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 50,
                width: 50,
                child: IconButton(
                  icon: Icon(Icons.favorite, color: favoriteColor, size: 30),
                  onPressed: () {
                    _toggleFavorite();
                  },
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showShareDialog(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.share, color: Colors.white, size: 20),
                  SizedBox(width: 10),
                  normaltext("Share"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showShareDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(18, 18, 18, 1),
          title: normaltext("Movie Hunt By Niranjan"),
          content: Container(
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          Icon(Icons.share, color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          normaltext("Share to Social Media"),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var url = "https://www.facebook.com/sharer/sharer.php?u=https://www.themoviedb.org/${widget.type}/${widget.id}";
                          await launch(url);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.facebook_rounded, color: Colors.white, size: 30),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          var url = "https://wa.me/?text=Check%20out%20this%20link:%20https://www.themoviedb.org/${widget.type}/${widget.id}";
                          await launch(url);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 30),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          var url = "https://www.linkedin.com/shareArticle?mini=true&url=https://www.themoviedb.org/${widget.type}/${widget.id}&title=Movie Hunt&summary=Check%20out%20this%20link:%20https://www.themoviedb.org/${widget.type}/${widget.id}&source=Movie%20Hunt";
                          await launch(url);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.linkedin, color: Colors.white, size: 30),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          var url = "https://twitter.com/intent/tweet?text=Check%20out%20this%20link:%20https://www.themoviedb.org/${widget.type}/${widget.id}";
                          await launch(url);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.twitter, color: Colors.white, size: 30),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
