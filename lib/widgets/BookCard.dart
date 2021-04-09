import 'package:book_reselling_app/Screens/ImageView.dart';
import 'package:flutter/material.dart';

enum CardOptions { requiest }

class BookTileCard extends StatefulWidget {
  final String title;
  final String sem;
  final String branch;
  final List<dynamic> img;
  final String description;

  const BookTileCard(
      {Key key, this.title, this.description, this.img, this.sem, this.branch})
      : super(key: key);
  @override
  _BookTileCardState createState() => _BookTileCardState();
}

class _BookTileCardState extends State<BookTileCard> {
  CardOptions _selection;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 20,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ImageView(
                      imgs: widget.img,
                    ),
                  ),
                );
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.img[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      PopupMenuButton<CardOptions>(
                        onSelected: (CardOptions result) {
                          setState(() {
                            _selection = result;
                          });
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<CardOptions>>[
                          const PopupMenuItem<CardOptions>(
                            value: CardOptions.requiest,
                            child: Text('Working a lot harder'),
                          ),
                        ],
                      )
                    ],
                  ),
                  Text(
                    "Semester: ${widget.sem} Branch: ${widget.branch}\n",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
