import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// TO VIEW STATISTIC PAGE
class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HorizontalBarChart.withSampleData();
  }
}

class HorizontalBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HorizontalBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory HorizontalBarChart.withSampleData() {
    return new HorizontalBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    // For horizontal bar charts, set the [vertical] flag to false.
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      vertical: false,

      behaviors: [
        new charts.SeriesLegend(

          position: charts.BehaviorPosition.end,

          outsideJustification: charts.OutsideJustification.startDrawArea,

          horizontalFirst: false,

          desiredMaxRows: 2,

          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),

          entryTextStyle: charts.TextStyleSpec(
              color: charts.Color(r: 127, g: 63, b: 191),
              fontFamily: 'Georgia',
              fontSize: 12),
        )
      ],
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<Statistics, String>> _createSampleData() {

    final budgetData = [
      new Statistics ('Food', 500),
      new Statistics('Housing', 500),
      new Statistics('Health', 100),
      new Statistics('Transport', 200),
      new Statistics('Utilities', 150),
      new Statistics('Savings', 500),
      new Statistics('Care', 50),
      new Statistics('Ad Hoc', 400),
      new Statistics('Social',60),
      new Statistics('Discretionary', 200),
    ];


    final expensesData = [
      new Statistics ('Food', 300),
      new Statistics('Housing', 400),
      new Statistics('Health', 40),
      new Statistics('Transport', 100),
      new Statistics('Utilities', 200),
      new Statistics('Savings', 100),
      new Statistics('Care', 10),
      new Statistics('Ad Hoc', 80),
      new Statistics('Social', 25),
      new Statistics('Discretionary', 50),
    ];

    return [

      new charts.Series<Statistics , String>(
        id: 'Budget',
        domainFn: (Statistics  data, _) => data.category,
        measureFn: (Statistics  data, _) => data.spending,
        data: budgetData,
      ),
      new charts.Series<Statistics , String>(
        id: 'Expenses',
        domainFn: (Statistics  data, _) => data.category,
        measureFn: (Statistics  data, _) => data.spending,
        data: expensesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class  Statistics {
  final String category;
  final int spending;

  Statistics(this.category, this.spending);
}

