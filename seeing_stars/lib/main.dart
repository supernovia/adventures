// main.dart — Seeing Stars 🟡🌌

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(SeeingStarsApp());

/// 🎨 Define custom colors
class AppColors {
  static const twilightTop = Color.fromARGB(255, 1, 28, 58);
  static const twilightBottom = Color.fromARGB(255, 26, 47, 82);
  static const star = Color.fromARGB(255, 245, 243, 237);
  static const panelBackground = Color.fromARGB(255, 15, 22, 41);
}

/// 💅 Shared styles
class AppStyles {
  static final primaryButton = OutlinedButton.styleFrom(
    backgroundColor: AppColors.panelBackground,
    foregroundColor: AppColors.star,
    side: BorderSide(color: AppColors.star),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  static const modalText = TextStyle(
    fontSize: 16,
    color: AppColors.star,
  );
}

class SeeingStarsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seeing Stars',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Arial'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/// 🧠 Game state and logic lives here
class _HomePageState extends State<HomePage> {
  bool isCountingDown = false;
  int countdown = 3;
  int? numberOfStars;
  int level = 1;
  final controller = TextEditingController();
  final focusNode = FocusNode();

  List<Offset> starPositions = [];
  List<double> starSizes = [];
  List<double> starRotations = [];
  List<double> scores = [];

  Stopwatch? stopwatch;

  bool showResultModal = false;
  bool showGuessBox = false;

  int guess = 0;
  int actual = 0;
  int diff = 0;
  double seconds = 0;
  double percentScore = 0;
  String resultText = '';
  String speed = '';

  /// 🎬 Start countdown and challenge
  void startChallenge() {
    setState(() {
      isCountingDown = true;
      countdown = 3;
      numberOfStars = null;
      showResultModal = false;
      showGuessBox = false;
      controller.clear();
      starPositions.clear();
      starSizes.clear();
      starRotations.clear();
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() => countdown--);
      if (countdown == 0) {
        timer.cancel();
        generateStars();
        stopwatch = Stopwatch()..start();
        setState(() {
          isCountingDown = false;
          showGuessBox = true;
        });
        FocusScope.of(context).requestFocus(focusNode);
      }
    });
  }

  /// 🌟 Star generation with non-overlapping placement
  void generateStars() {
    final rand = Random();
    int minStars = 5, maxStars = 10;
    if (level == 2) {
      minStars = 10;
      maxStars = 25;
    } else if (level == 3) {
      minStars = 25;
      maxStars = 100;
    }
    numberOfStars = minStars + rand.nextInt(maxStars - minStars + 1);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height - 120;

    for (int i = 0; i < 2000 && starPositions.length < numberOfStars!; i++) {
      double x = rand.nextDouble() * (w - 24);
      double y = rand.nextDouble() * (h - 24);
      Offset candidate = Offset(x, y);
      if (starPositions.every((p) => (p - candidate).distance > 30)) {
        starPositions.add(candidate);
        starSizes.add(5 + rand.nextDouble() * 3);
        starRotations.add(rand.nextDouble() * 2 * pi);
      }
    }
  }

  /// ✅ Guess logic and scoring
  void submitGuess() {
    stopwatch?.stop();
    guess = int.tryParse(controller.text) ?? 0;
    actual = numberOfStars ?? 0;
    diff = (guess - actual).abs();
    seconds = stopwatch!.elapsedMilliseconds / 1000.0;

    final signedDiff = guess - actual;
    resultText = signedDiff == 0
        ? 'Perfect score! 🎯'
        : 'You were ${signedDiff > 0 ? '' : ''}${signedDiff} ${signedDiff > 0 ? 'over' : 'under'}';

    percentScore = (1 - (diff / actual)).clamp(0.0, 1.0) * 100;
    scores.add(percentScore);

    speed = seconds < 3
        ? 'Fast'
        : seconds < 7
            ? 'OK'
            : 'Try estimating instead of counting!';

    setState(() {
      showGuessBox = false;
      showResultModal = true;
    });
  }

Widget buildScoreChart() {
  final displayScores = scores.length <= 10
      ? scores
      : scores.sublist(scores.length - 10);
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.star.withOpacity(0.6)),
    ),
    height: 150,
    child: LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              displayScores.length,
              (index) => FlSpot(index.toDouble(), displayScores[index]),
            ),
            isCurved: true,
            barWidth: 2,
            color: AppColors.star,
            dotData: FlDotData(show: true),
          )
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 10,
              reservedSize: 30,
              getTitlesWidget: (value, meta) => Text(
                '${value.toInt()}',
                style: TextStyle(color: Colors.white54, fontSize: 10),
              ),
            ),
          ),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          horizontalInterval: 10,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.white24,
            strokeWidth: 0.5,
          ),
          drawVerticalLine: false,
        ),
        minY: 0,
        maxY: 100,
      ),
    ),
  );
}

  /// 📊 Result modal content
Widget _buildResultsSummary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Your Guess: $guess", style: AppStyles.modalText),
      Text("Correct Number: $actual", style: AppStyles.modalText),
      Text(resultText, style: AppStyles.modalText),
      Text("Score: ${percentScore.toStringAsFixed(0)}%", style: AppStyles.modalText),
      SizedBox(height: 8),
      Text("Time: ${seconds.toStringAsFixed(2)}s — $speed", style: AppStyles.modalText),
      if (scores.length > 1) ...[
        SizedBox(height: 16),
        Text("Your Progress:", style: AppStyles.modalText),
        buildScoreChart(),
      ]
    ],
  );
}


  /// 🧱 Main UI layout
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double modalMargin = width * 0.1;
    double modalWidth = width * 0.8;

    return Scaffold(
      backgroundColor: AppColors.twilightBottom,
      body: Stack(
        children: [
          /// 🎨 Star field background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.twilightTop, AppColors.twilightBottom],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// 🌟 Star painter
          if (!isCountingDown && numberOfStars != null)
            CustomPaint(
              size: Size.infinite,
              painter: StarPainter(starPositions, starSizes, starRotations),
            ),

          /// 🕒 Countdown display
          if (isCountingDown)
            Center(
              child: Text(
                "$countdown",
                style: TextStyle(fontSize: 64, color: AppColors.star),
              ),
            ),

          /// 🧠 Guessing input
          if (showGuessBox)
            Positioned(
              bottom: 30,
              left: modalMargin,
              right: modalMargin,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  border: Border.all(color: AppColors.star.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        focusNode: focusNode,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => submitGuess(),
                        style: TextStyle(color: AppColors.star),
                        decoration: InputDecoration(
                          hintText: '⭐ Type your Guess',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: submitGuess,
                      style: AppStyles.primaryButton,
                      child: Text("Go"),
                    )
                  ],
                ),
              ),
            ),

          /// 📋 Result modal
          if (showResultModal)
            Center(
              child: Container(
                width: modalWidth,
                margin: EdgeInsets.all(modalMargin),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.star.withOpacity(0.6)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildResultsSummary(),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      children: [
                        OutlinedButton(
                          onPressed: startChallenge,
                          style: AppStyles.primaryButton,
                          child: Text("Play Again"),
                        ),
                        if (level < 3)
                          OutlinedButton(
                            onPressed: () => setState(() {
                              level++;
                              startChallenge();
                            }),
                            style: AppStyles.primaryButton,
                            child: Text("Try Next Level"),
                          )
                      ],
                    )
                  ],
                ),
              ),
            ),

          /// 🎬 Title + start button (when not active)
          if (!isCountingDown && numberOfStars == null && !showResultModal)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🌟 Seeing Stars 🌟',
                      style: TextStyle(
                        fontSize: 32,
                        color: AppColors.star,
                        fontFamily: 'Courier',
                      )),
                  SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: startChallenge,
                    style: AppStyles.primaryButton,
                    child: Text('Start'),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// 🧵 Draw stars manually
class StarPainter extends CustomPainter {
  final List<Offset> stars;
  final List<double> sizes;
  final List<double> rotations;

  StarPainter(this.stars, this.sizes, this.rotations);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.star;
    for (int i = 0; i < stars.length; i++) {
      drawStar(canvas, stars[i], sizes[i], rotations[i], paint);
    }
  }

  void drawStar(Canvas canvas, Offset center, double radius, double rotation, Paint paint) {
    const int points = 5;
    final double step = pi / points;
    final path = Path();

    for (int i = 0; i < 2 * points; i++) {
      double r = i.isEven ? radius : radius / 2.5;
      double angle = i * step - pi / 2 + rotation;
      double x = center.dx + r * cos(angle);
      double y = center.dy + r * sin(angle);
      if (i == 0) path.moveTo(x, y);
      else path.lineTo(x, y);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
