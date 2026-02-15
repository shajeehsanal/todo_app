import 'package:flutter/material.dart';

class InProgressWidget extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String category;
  final Color progressBarColor;
  final double percent;
  const InProgressWidget({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.title,
    required this.category,
    required this.progressBarColor,
    required this.iconColor,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final value = width > height;
    double fontSize = value ? width * 0.15 : height * 0.2;
    double iconSize = value ? width * 0.1 : height * 0.1;

    return Container(
      width: width * (value ? 0.4 : 0.6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(bottom: value ? height * 0.02 : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: fontSize * 0.08,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.02),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: iconSize * 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.02),
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize * 0.12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: width,
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: percent),
              duration: const Duration(milliseconds: 600),
              builder: (context, value, child) => Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: LinearProgressIndicator(
                  value: value,
                  valueColor: AlwaysStoppedAnimation(progressBarColor),
                  minHeight: height * 0.01,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            // child: LinearPercentIndicator(
            //   progressColor: progressBarColor,
            //   percent: percent,
            //   animationDuration: 600,
            //   animation: true,
            //   backgroundColor: Colors.white,
            //   barRadius: const Radius.circular(15),
            //   lineHeight: height * 0.01,
            // ),
          ),
        ],
      ),
    );
  }
}
