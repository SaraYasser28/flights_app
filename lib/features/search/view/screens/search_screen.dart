import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/discover_flight_card.dart';
import '../../logic/cubit/search_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/custom_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late SearchCubit _searchCubit;

  // Track which sort option is currently selected
  String? _selectedSort;

  @override
  void initState() {
    super.initState();
    _searchCubit = context.read<SearchCubit>();
    _searchCubit.loadFlights();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyBackground,
      appBar: CustomAppBar(
        backgroundColor: AppColors.primary,
        title: "Search Flights",
        iconColor: AppColors.white,
      ),
      body: Column(
        children: [
          CustomSearchBar(
            controller: _searchController,
            onChanged: (query) {
              _searchCubit.searchFlights(query);
            },
            onFilterTap: () {
              _showFilterBottomSheet();
            },
          ),
          _buildSortButtons(),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        SizedBox(height: 16.h),
                        Text(
                          state.message ?? 'Searching flights...',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is SearchError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64.w,
                          color: AppColors.red,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          state.message,
                          style: AppTextStyles.body,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () => _searchCubit.loadFlights(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Retry',
                            style: AppTextStyles.body.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is SearchLoaded) {
                  if (state.flights.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.flight_takeoff,
                            size: 64.w,
                            color: AppColors.grey,
                          ),
                          SizedBox(height: 16.h),
                          Text('No flights found', style: AppTextStyles.title),
                          SizedBox(height: 8.h),
                          Text(
                            'Try adjusting your search or filters',
                            style: AppTextStyles.body,
                          ),
                          SizedBox(height: 24.h),
                          if (state.filtersApplied || state.isSearching)
                            ElevatedButton(
                              onPressed: () {
                                _searchController.clear();
                                _searchCubit.clearFilters();
                                setState(() {
                                  _selectedSort = null; // Reset selected sort
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                'Clear Filters',
                                style: AppTextStyles.body.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(20.w),
                    itemCount: state.flights.length,
                    itemBuilder: (context, index) {
                      final flight = state.flights[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.flightDetails,
                              arguments: flight,
                            );
                          },
                          child: DiscoverFlightCard(flight: flight),
                        ),
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    final currentFilters = _searchCubit.getCurrentFilters();
    final maxPrice = _searchCubit.getMaxPrice();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => FilterBottomSheet(
        maxPossiblePrice: maxPrice,
        initialPriceRange: currentFilters['priceRange'],
        initialAirline: currentFilters['airline'],
        initialTravelClass: currentFilters['travelClass'],
        onApplyFilters: (filters) {
          _searchCubit.applyFilters(
            priceRange: filters['priceRange'],
            airline: filters['airline'],
            travelClass: filters['travelClass'],
          );
        },
        onClearFilters: () {
          _searchCubit.clearFilters();
        },
      ),
    );
  }

  Widget _buildSortButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.inputBorder, width: 1),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildSortChip(
              label: 'Price: Low to High',
              isSelected: _selectedSort == 'price_asc',
              onTap: () {
                setState(() {
                  _selectedSort = 'price_asc';
                });
                _searchCubit.sortByPriceAscending();
              },
            ),
            SizedBox(width: 8.w),
            _buildSortChip(
              label: 'Price: High to Low',
              isSelected: _selectedSort == 'price_desc',
              onTap: () {
                setState(() {
                  _selectedSort = 'price_desc';
                });
                _searchCubit.sortByPriceDescending();
              },
            ),
            SizedBox(width: 8.w),
            _buildSortChip(
              label: 'Duration',
              isSelected: _selectedSort == 'duration',
              onTap: () {
                setState(() {
                  _selectedSort = 'duration';
                });
                _searchCubit.sortByDuration();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.inputBackground,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.inputBorder,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontSize: 12.sp,
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
