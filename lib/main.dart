import 'package:flutter/material.dart';

void main() {
  runApp(CalendarApp());
}

class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendario de Vania',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF1a1a2e),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF16213e),
          foregroundColor: Colors.white,
        ),
      ),
      home: CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '📅 Calendario de Vania',
          style: TextStyle(
            fontFamily: 'Comic Sans MS',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.chevron_left, size: 35),
                      color: Colors.white,
                    ),
                    Text(
                      'Diciembre 2024',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Comic Sans MS',
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 3,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.chevron_right, size: 35),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1976D2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    _buildDayHeader('L', 0),
                    _buildDayHeader('M', 1),
                    _buildDayHeader('X', 2),
                    _buildDayHeader('J', 3),
                    _buildDayHeader('V', 4),
                    _buildDayHeader('S', 5),
                    _buildDayHeader('D', 6),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2c3e50),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _buildCalendarRow([29, 30, 1, 2, 3, 4, 5]),
                        _buildCalendarRow([6, 7, 8, 9, 10, 11, 12]),
                        _buildCalendarRow([13, 14, 15, 16, 17, 18, 19]),
                        _buildCalendarRow([20, 21, 22, 23, 24, 25, 26]),
                        _buildCalendarRow([27, 28, 29, 30, 31, 1, 2]),
                        _buildCalendarRow([3, 4, 5, 6, 7, 8, 9]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayHeader(String day, int dayIndex) {
    bool isWeekend = dayIndex == 5 || dayIndex == 6;
    
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Comic Sans MS',
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarRow(List<int> days) {
    return Expanded(
      child: Row(
        children: days.asMap().entries.map((entry) => 
          _buildDayCell(entry.value, entry.key)).toList(),
      ),
    );
  }

  Widget _buildDayCell(int day, int dayOfWeek) {
    bool isCurrentMonth = day >= 1 && day <= 31;
    bool isToday = day == 15;
    bool isWeekend = dayOfWeek == 5 || dayOfWeek == 6; 
    bool isTuesday = dayOfWeek == 1; // Martes
    
    Color cellColor;
    Color textColor;
    String? eventText;
    
    if (isToday) {
      cellColor = Color(0xFFFF6B6B);
      textColor = Colors.white;
    } else if (isWeekend && isCurrentMonth) {
      cellColor = Color(0xFF4CAF50);
      textColor = Colors.white;
    } else if (isTuesday && isCurrentMonth) {
      cellColor = Color(0xFF2196F3);
      textColor = Colors.white;
      eventText = "Dart";
    } else if (isCurrentMonth) {
      cellColor = Color(0xFF1976D2);
      textColor = Colors.white;
    } else {
      cellColor = Color(0xFF424242);
      textColor = Colors.grey[400]!;
    }
    
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: cellColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
                  color: textColor,
                  fontFamily: 'Comic Sans MS',
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 1,
                      offset: Offset(0.5, 0.5),
                    ),
                  ],
                ),
              ),
              if (eventText != null && isCurrentMonth)
                Text(
                  eventText,
                  style: TextStyle(
                    fontSize: 8,
                    color: textColor,
                    fontFamily: 'Comic Sans MS',
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}