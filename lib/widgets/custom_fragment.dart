import 'package:flutter/material.dart';

class CustomFragment extends StatelessWidget {
  final String sunrise, sunset, minTemp, maxTemp, description, pressure;
  CustomFragment({
    this.sunrise,
    this.sunset,
    this.minTemp,
    this.maxTemp,
    this.pressure,
    this.description,
  });
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyleforSmallTexts = TextStyle(
      color: Color(0xFFBDC2D8),
      fontWeight: FontWeight.bold,
    );

    final TextStyle textStyleForBigTexts = TextStyle(
      color: Color(0xFF697088),
      fontSize: 23,
      fontWeight: FontWeight.bold,
    );

    return Container(
      height: MediaQuery.of(context).size.height / 3.1,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StyledTextRow(
              textStyleforSmallTexts: textStyleforSmallTexts,
              textStyleForBigTexts: textStyleForBigTexts,
              edgeInsets: EdgeInsets.only(top: 25, left: 25),
              data: ['SUNRISE', sunrise, 'SUNSET', sunset],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Divider(),
            ),
            StyledTextRow(
              textStyleforSmallTexts: textStyleforSmallTexts,
              textStyleForBigTexts: textStyleForBigTexts,
              edgeInsets: EdgeInsets.only(left: 25),
              data: ['MIN TEMP', minTemp, 'MAX TEMP', maxTemp],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Divider(),
            ),
            StyledTextRow(
              textStyleforSmallTexts: textStyleforSmallTexts,
              textStyleForBigTexts: textStyleForBigTexts,
              edgeInsets: EdgeInsets.only(left: 25),
              data: ['DESCRIPTION', description, 'PRESSURE', pressure],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
        ),
      ),
    );
  }
}

class StyledTextRow extends StatelessWidget {
  const StyledTextRow(
      {@required this.textStyleforSmallTexts,
      @required this.textStyleForBigTexts,
      this.edgeInsets,
      this.data});

  final TextStyle textStyleforSmallTexts;
  final TextStyle textStyleForBigTexts;
  final EdgeInsets edgeInsets;
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: edgeInsets,
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  data[0],
                  style: textStyleforSmallTexts,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              FittedBox(
                child: Text(
                  data[1],
                  style: textStyleForBigTexts,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: edgeInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  data[2],
                  style: textStyleforSmallTexts,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              FittedBox(
                child: Text(
                  data[3],
                  style: textStyleForBigTexts,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
