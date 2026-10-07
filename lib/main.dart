import 'package:flutter/material.dart';
import 'dart:ui'; // Glassmorphism effect ke liye zaroori hai

void main() {
  runApp(const SmartHomeApp());
}

// 1. App Theme aur Global Colors
class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1A2342),
        primaryColor: const Color(0xFF654DE4),
      ),
      home: const MainContainerScreen(),
    );
  }
}

// 2. Main Container Screen (Dashboard aur Living Room)
class MainContainerScreen extends StatefulWidget {
  const MainContainerScreen({super.key});

  @override
  State createState() => _MainContainerScreenState();
}

class _MainContainerScreenState extends State {
  final PageController _pageController = PageController();
  int _currentIndex = 0; // Track karne ke liye ki abhi kaunsi screen par hain

  // Next ya previous page par smoothly move karne ka function
  void _navigateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF252C56),
              Color(0xFF1A2342),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Upar wala title text
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Interactive Temperature Panel',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              // PageView jisme 2 screens hain (Swipeable)
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: const [
                    DashboardScreen(),  // Page 0: Dashboard/Home
                    LivingRoomScreen(), // Page 1: Living Room Controls
                  ],
                ),
              ),
              // Neeche wala navigation bar (2 dots ke sath)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      color: Colors.white.withValues(alpha: 0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Previous / Back Icon Button
                          GestureDetector(
                            onTap: () {
                              if (_currentIndex > 0) {
                                _navigateToPage(_currentIndex - 1);
                              }
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: _currentIndex > 0 ? Colors.white : Colors.grey.withValues(alpha: 0.3),
                              size: 20,
                            ),
                          ),
                          // 2 Dots Indicators
                          Row(
                            children: List.generate(2, (index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentIndex == index
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.3),
                                ),
                              );
                            }),
                          ),
                          // Next / Forward Icon Button
                          GestureDetector(
                            onTap: () {
                              if (_currentIndex < 1) {
                                _navigateToPage(_currentIndex + 1);
                              }
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: _currentIndex < 1 ? Colors.white : Colors.grey.withValues(alpha: 0.3),
                              size: 20,
                            ),
                          ),
                        ],
                      ),
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
}

// ==========================================================
// 1. Screen 1: Dashboard Screen (Home Dashboard)
// ==========================================================
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State {
  // Routines ka state track karne ke liye
  String _selectedRoutine = 'Morning';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Home Temperature",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF7B68EE).withValues(alpha: 0.5),
                child: const Icon(Icons.person, color: Colors.white, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Temperature & Humidity Glassmorphism Card
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('24°C', 'avg house temp'),
                    Container(height: 40, width: 1, color: Colors.white.withValues(alpha: 0.1)),
                    _buildStatItem('69%', 'humidity'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text('Routines', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          // Routines Selection Row (Clickable)
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedRoutine = 'Morning'),
                  child: _buildRoutineCard('Morning', Icons.wb_sunny, _selectedRoutine == 'Morning'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedRoutine = "I'm Out"),
                  child: _buildRoutineCard("I'm Out", Icons.security, _selectedRoutine == "I'm Out"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13)),
      ],
    );
  }

  Widget _buildRoutineCard(String label, IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE65C9D) : Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20),
        border: isActive ? null : Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
        ],
      ),
    );
  }
}

// ==========================================================
// 2. Screen 2: Living Room Control Screen (Interactive Temp & Modes)
// ==========================================================
class LivingRoomScreen extends StatefulWidget {
  const LivingRoomScreen({super.key});

  @override
  State createState() => _LivingRoomScreenState();
}

class _LivingRoomScreenState extends State {
  // Temperature aur active mode ko track karne ke variables
  int _currentTemperature = 23;
  String _selectedMode = 'Cool';
  bool _isPowerOn = true;

  // Temperature increase karne ka function
  void _increaseTemp() {
    setState(() {
      if (_currentTemperature < 30) _currentTemperature++;
    });
  }

  // Temperature decrease karne ka function
  void _decreaseTemp() {
    setState(() {
      if (_currentTemperature > 16) _currentTemperature--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Living room',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 30),

          // Temperature Adjustment Buttons Row (- aur +)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _decreaseTemp,
                icon: const Icon(Icons.remove_circle_outline, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 20),
              // Circular Thermostat UI
              Container(
                width: 220,
                height: 220,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE65C9D), width: 8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE65C9D).withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$_currentTemperature°C',
                      style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    const Text('74%', style: TextStyle(color: Colors.white60, fontSize: 14)),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPowerOn = !_isPowerOn;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            color: _isPowerOn ? const Color(0xFF5BC0EB) : Colors.redAccent,
                            size: 26,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _isPowerOn ? 'Click to turn off' : 'Click to turn on',
                            style: TextStyle(
                              color: _isPowerOn ? const Color(0xFF5BC0EB) : Colors.redAccent,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: _increaseTemp,
                icon: const Icon(Icons.add_circle_outline, color: Colors.white, size: 32),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Mode Buttons (Cool, Heat, Fan, Auto) - Clickable
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildModeButton('Cool', Icons.ac_unit),
              _buildModeButton('Heat', Icons.wb_sunny),
              _buildModeButton('Fan', Icons.air),
              _buildModeButton('Auto', Icons.autorenew),
            ],
          ),
        ],
      ),
    );
  }

  // Clickable Mode Button helper widget
  Widget _buildModeButton(String label, IconData icon) {
    bool isActive = _selectedMode == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMode = label; // Jis button par click hoga woh active ho jayega
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFE65C9D) : Colors.white.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.8),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}