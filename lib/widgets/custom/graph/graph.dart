import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_journal_v2/data/global_data.dart';
import 'package:workout_journal_v2/theme/colors.dart';
import 'package:workout_journal_v2/theme/text_styles.dart';

class MyLineChart extends StatelessWidget {
  final List<double> data;
  const MyLineChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxValue = data.reduce(max);

    double chartHeight = maxValue * 2;

    return LineChart(
      LineChartData(
        backgroundColor: AppColors.secondary,
        maxX: data.length.toDouble(),
        minX: 0,
        maxY: chartHeight,
        minY: 0,
        gridData: const FlGridData(
          show: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: AppColors.tertiary,
            getTooltipItems: (touchedSpots) => touchedSpots
                .map(
                  (barSpot) => LineTooltipItem(
                    '${Methods.numberFormatter.format(data[barSpot.spotIndex])}${Constants.weightUnit}',
                    GoogleFonts.rubik(
                      color: AppColors.primaryText,
                      fontSize: 14,
                      fontWeight: Weights.medium,
                    ),
                  ),
                )
                .toList(),
            tooltipRoundedRadius: 8,
          ),
        ),
        extraLinesData: ExtraLinesData(
          extraLinesOnTop: false,
          horizontalLines: [
            buildHorizontalLine(0),
            buildHorizontalLine(chartHeight * 1 / 5),
            buildHorizontalLine(chartHeight * 2 / 5),
            buildHorizontalLine(chartHeight * 3 / 5),
            buildHorizontalLine(chartHeight * 4 / 5),
            buildHorizontalLine(chartHeight),
          ],
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              getTitlesWidget: (value, meta) {
                String text;
                if (value.isNaN || value.isInfinite) {
                  text = '';
                } else {
                  text = value.toString();
                }

                return TextHeeboReg(text: text, size: 12);
              },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              getTitlesWidget: (value, meta) {
                String text;
                if (value.isNaN || value.isInfinite) {
                  text = '';
                } else {
                  text = value.toString();
                }

                return TextHeeboReg(text: text, size: 12);
              },
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              getTitlesWidget: (value, meta) {
                String text;
                if (value.isNaN || value.isInfinite) {
                  text = '';
                } else {
                  text = value.toString();
                }

                return TextHeeboReg(text: text, size: 12);
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: chartHeight * 1 / 5,
              getTitlesWidget: (value, meta) {
                return TextHeeboReg(
                  text: Methods.compactNumberFormatter.format(value),
                  size: 6,
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: data.asMap().entries.map(
              (entry) {
                return FlSpot(entry.key.toDouble(), entry.value);
              },
            ).toList(),
            isCurved: true,
            color: AppColors.redAccent,
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: false,
            ),
          ),
        ],
      ),
    );
  }

  HorizontalLine buildHorizontalLine(double value) {
    return HorizontalLine(
        y: value, dashArray: [4, 4], color: AppColors.tertiary);
  }
}
