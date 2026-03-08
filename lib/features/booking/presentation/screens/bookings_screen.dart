import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../widgets/build_flight_list.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  /// UPCOMING BOOKINGS
  final upcomingFlights = [
    {
      "airline": "British Airways",
      "from": "CDG",
      "to": "LHR",
      "fromCity": "PARIS",
      "toCity": "LONDON",
      "departureTime": "10:10",
      "arrivalTime": "10:40",
      "duration": "90 min",
      "date": "Jun 24, 2024",
      "price": "\$150",
      "class": "ECONOMY CLASS",
    },
    {
      "airline": "Air France",
      "from": "HND",
      "to": "CDG",
      "fromCity": "TOKYO",
      "toCity": "PARIS",
      "departureTime": "08:00",
      "arrivalTime": "20:45",
      "duration": "12h 45m",
      "date": "Jun 25, 2024",
      "price": "\$450",
      "class": "BUSINESS CLASS",
    },
    {
      "airline": "British Airways",
      "from": "CDG",
      "to": "LHR",
      "fromCity": "PARIS",
      "toCity": "LONDON",
      "departureTime": "10:10",
      "arrivalTime": "10:40",
      "duration": "90 min",
      "date": "Jun 28, 2024",
      "price": "\$150",
      "class": "ECONOMY CLASS",
    },
  ];

  /// PAST BOOKINGS
  final pastFlights = [
    {
      "airline": "Lufthansa",
      "from": "FRA",
      "to": "CDG",
      "fromCity": "FRANKFURT",
      "toCity": "PARIS",
      "departureTime": "09:00",
      "arrivalTime": "10:15",
      "duration": "1h 15m",
      "date": "May 18, 2024",
      "price": "\$120",
      "class": "ECONOMY CLASS",
    },
    {
      "airline": "Emirates",
      "from": "DXB",
      "to": "LHR",
      "fromCity": "DUBAI",
      "toCity": "LONDON",
      "departureTime": "13:00",
      "arrivalTime": "18:30",
      "duration": "7h 30m",
      "date": "Apr 02, 2024",
      "price": "\$700",
      "class": "BUSINESS CLASS",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyBackground,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Column(
          children: [
            const CustomAppBar(
              backgroundColor: AppColors.primary,
              title: "My Bookings",
              iconColor: AppColors.white,
            ),

            Container(
              color: AppColors.primary,
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.white,
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.white.withValues(alpha: .7),
                tabs: const [
                  Tab(text: "Upcoming"),
                  Tab(text: "Past"),
                ],
                tabAlignment: TabAlignment.start,
                isScrollable: true,
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, "/home");
          } else if (index == 2) {
            Navigator.pushNamed(context, "/profile");
          }
        },
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          BuildFlightList(flights: upcomingFlights),
          BuildFlightList(flights: pastFlights),
        ],
      ),
    );
  }
}
