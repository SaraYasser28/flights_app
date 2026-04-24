import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/primary_button.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;
  final VoidCallback onClearFilters;
  final RangeValues? initialPriceRange;
  final String? initialAirline;
  final int? initialTravelClass;
  final double maxPossiblePrice;

  const FilterBottomSheet({
    super.key,
    required this.onApplyFilters,
    required this.onClearFilters,
    this.initialPriceRange,
    this.initialAirline,
    this.initialTravelClass,
    this.maxPossiblePrice = 1000,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late RangeValues _priceRange;
  late TextEditingController _airlineController;
  int? _travelClass;
  bool _isApplying = false;

  @override
  void initState() {
    super.initState();
    _priceRange =
        widget.initialPriceRange ?? RangeValues(0, widget.maxPossiblePrice);
    _airlineController = TextEditingController(
      text: widget.initialAirline ?? '',
    );
    _travelClass = widget.initialTravelClass;
  }

  @override
  void didUpdateWidget(FilterBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialPriceRange != null) {
      _priceRange = widget.initialPriceRange!;
    }
    if (widget.initialAirline != _airlineController.text) {
      _airlineController.text = widget.initialAirline ?? '';
    }
    if (widget.initialTravelClass != _travelClass) {
      _travelClass = widget.initialTravelClass;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: AppTextStyles.title.copyWith(fontSize: 20.sp),
              ),
              TextButton(
                onPressed: _isApplying
                    ? null
                    : () {
                        _clearFilters();
                        widget.onClearFilters();
                        if (mounted) {
                          Navigator.pop(context);
                        }
                      },
                child: Text('Clear All', style: AppTextStyles.primaryLink),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          Text(
            'Flight Class',
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildClassChip(
                label: 'Economy',
                value: 1,
                icon: Icons.flight_class,
              ),
              SizedBox(width: 12.w),
              _buildClassChip(label: 'Business', value: 3, icon: Icons.work),
            ],
          ),

          SizedBox(height: 20.h),

          // Price Range Filter
          Text(
            'Price Range',
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: widget.maxPossiblePrice,
            divisions: 20,
            labels: RangeLabels(
              '\$${_priceRange.start.round()}',
              '\$${_priceRange.end.round()}',
            ),
            onChanged: _isApplying
                ? null
                : (values) {
                    setState(() {
                      _priceRange = values;
                    });
                  },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${_priceRange.start.round()}'),
              Text('\$${_priceRange.end.round()}'),
            ],
          ),

          SizedBox(height: 20.h),

          // Airline Filter
          Text(
            'Airline',
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: _airlineController,
            enabled: !_isApplying,
            decoration: InputDecoration(
              hintText: 'Enter airline name',
              hintStyle: AppTextStyles.inputHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.inputBorder),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
          ),

          SizedBox(height: 24.h),

          PrimaryButton(
            text: _isApplying ? 'Applying...' : 'Apply Filters',
            onTap: _isApplying ? null : _applyFilters,
          ),
        ],
      ),
    );
  }

  Widget _buildClassChip({
    required String label,
    required int value,
    required IconData icon,
  }) {
    final isSelected = _travelClass == value;
    return Expanded(
      child: GestureDetector(
        onTap: _isApplying
            ? null
            : () {
                setState(() {
                  _travelClass = isSelected ? null : value;
                });
              },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.inputBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.inputBorder,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18.w,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: AppTextStyles.body.copyWith(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _applyFilters() async {
    if (!mounted) return;
    setState(() {
      _isApplying = true;
    });

    final filters = {
      'priceRange': _priceRange,
      'airline': _airlineController.text.isNotEmpty
          ? _airlineController.text
          : null,
      'travelClass': _travelClass,
    };

    try {
      await widget.onApplyFilters(filters);

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isApplying = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to apply filters: $e'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }

  void _clearFilters() {
    setState(() {
      _priceRange = RangeValues(0, widget.maxPossiblePrice);
      _airlineController.clear();
      _travelClass = null;
    });
  }

  @override
  void dispose() {
    _airlineController.dispose();
    super.dispose();
  }
}
