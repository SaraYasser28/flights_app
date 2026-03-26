import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/data/models/flight_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../logic/cubit/booking_cubit.dart';

class BookingScreen extends StatefulWidget {
  final FlightModel flight;

  const BookingScreen({super.key, required this.flight});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _passengers = 1;
  bool _isBooking = false;

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.flight.price * _passengers;

    return Scaffold(
      backgroundColor: AppColors.lightGreyBackground,
      appBar: CustomAppBar(
        backgroundColor: AppColors.primary,
        title: "Book Flight",
        iconColor: AppColors.white,
        showBackButton: true,
      ),
      body: BlocListener<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Booking confirmed! Reference: ${state.booking.bookingReference}',
                ),
                backgroundColor: AppColors.green,
                duration: const Duration(seconds: 3),
              ),
            );
            Navigator.pushReplacementNamed(context, '/bookings');
          } else if (state is BookingError) {
            setState(() {
              _isBooking = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Flight Summary Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.05),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Flight Details',
                      style: AppTextStyles.title.copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.flight.fromCity,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              widget.flight.departureTime,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward, size: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.flight.toCity,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              widget.flight.arrivalTime,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Divider(color: AppColors.inputBorder),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Airline',
                          style: TextStyle(color: AppColors.grey),
                        ),
                        Text(
                          widget.flight.airline,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Flight Number',
                          style: TextStyle(color: AppColors.grey),
                        ),
                        Text(widget.flight.flightNumber),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date', style: TextStyle(color: AppColors.grey)),
                        Text(widget.flight.formattedDate),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              /// Passenger Selection - FIXED OVERFLOW
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.05),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Passengers',
                      style: AppTextStyles.title.copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Flexible text to prevent overflow
                        Flexible(
                          child: Text(
                            'Number of Passengers',
                            style: TextStyle(fontSize: 14.sp),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(width: 8.w),

                        /// Passenger counter - fixed width to prevent shrinking
                        Container(
                          constraints: BoxConstraints(minWidth: 100.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: _passengers > 1
                                    ? () {
                                        setState(() {
                                          _passengers--;
                                        });
                                      }
                                    : null,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  size: 28.w,
                                  color: _passengers > 1
                                      ? AppColors.primary
                                      : AppColors.grey,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              SizedBox(
                                width: 30.w,
                                child: Text(
                                  '$_passengers',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passengers++;
                                  });
                                },
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 28.w,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              /// Price Summary
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.05),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Summary',
                      style: AppTextStyles.title.copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Base Price',
                          style: TextStyle(color: AppColors.grey),
                        ),
                        Text(
                          '\$${widget.flight.price.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'x $_passengers passenger${_passengers > 1 ? 's' : ''}',
                          style: TextStyle(color: AppColors.grey),
                        ),
                        Text(
                          '\$${(widget.flight.price * _passengers).toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Divider(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              /// Book Button
              PrimaryButton(
                text: _isBooking ? 'Booking...' : 'Confirm Booking',
                onTap: _isBooking
                    ? null
                    : () {
                        setState(() {
                          _isBooking = true;
                        });
                        context.read<BookingCubit>().bookFlight(
                          flightId: widget.flight.id,
                          passengers: _passengers,
                          flight: widget.flight,
                        );
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
