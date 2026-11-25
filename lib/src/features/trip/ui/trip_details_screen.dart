import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gl_mobile_app/src/features/trip/model/get_trip_supplier_details/get_trip_supplier_details_rsp.dart';
import 'package:gl_mobile_app/src/features/trip/bloc/get_trip_supplier_details/get_trip_supplier_details_bloc.dart';

import 'package:gl_mobile_app/src/features/trip/bloc/get_trip_supplier_details/get_trip_supplier_details_event.dart';

import 'package:gl_mobile_app/src/features/trip/bloc/get_trip_supplier_details/get_trip_supplier_details_state.dart';

class TripDetailsScreen extends StatelessWidget {
  final String tripId;
  final String tripNo;
  final String status;
  final String location;
  final String startTime;
  final String estimatedTime;
  final String vehicleNo;

  final VoidCallback onPickupStart;

  const TripDetailsScreen({
    super.key,
    required this.tripId,
    required this.tripNo,
    required this.status,
    required this.location,
    required this.startTime,
    required this.estimatedTime,
    required this.vehicleNo,
    required this.onPickupStart,
  });

  static const Color primaryBlue = Color(0xFF10466B);
  static const Color pageBackground = Color(0xFFF4F7FA);
  static const Color cardGreen = Color(0xFF6F9F7A);

  @override
  Widget build(BuildContext context) {
    // Reuse the existing BLoC provided by the parent.
    final supplierBloc = context.read<GetTripSupplierDetailsBloc>();

    return BlocProvider.value(
      value: supplierBloc..add(FetchTripSupplierDetails(suidTrip: tripId)),
      child: Scaffold(
        backgroundColor: pageBackground,

        appBar: AppBar(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          title: const Text(
            'Trip Details',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trip Number Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: cardGreen, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TRIP NUMBER',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      tripNo,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5F0F8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          color: primaryBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // Trip Information
              const Text(
                'Trip Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),

              const SizedBox(height: 12),

              _buildDetailCard(
                icon: Icons.location_on_outlined,
                title: 'Location',
                value: location,
              ),

              _buildDetailCard(
                icon: Icons.access_time,
                title: 'Start Time',
                value: startTime,
              ),

              _buildDetailCard(
                icon: Icons.timer_outlined,
                title: 'Estimated Time',
                value: estimatedTime,
              ),

              _buildDetailCard(
                icon: Icons.local_shipping_outlined,
                title: 'Vehicle Number',
                value: vehicleNo,
              ),

              const SizedBox(height: 12),

              // Supplier Information
              const Text(
                'Supplier Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),

              const SizedBox(height: 12),

              BlocBuilder<
                GetTripSupplierDetailsBloc,
                GetTripSupplierDetailsState
              >(
                builder: (context, state) {
                  if (state is GetTripSupplierDetailsLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: CircularProgressIndicator(color: primaryBlue),
                      ),
                    );
                  }

                  if (state is GetTripSupplierDetailsSuccess) {
                    final suppliers = state.supplierDetails;

                    if (suppliers.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'No supplier details available',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: List.generate(suppliers.length, (index) {
                        return _buildSupplierCard(suppliers[index], index + 1);
                      }),
                    );
                  }

                  if (state is GetTripSupplierDetailsFailure) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 35,
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Unable to load supplier details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black54),
                          ),

                          const SizedBox(height: 12),

                          ElevatedButton(
                            onPressed: () {
                              context.read<GetTripSupplierDetailsBloc>().add(
                                FetchTripSupplierDetails(suidTrip: tripId),
                              );
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: Text('Supplier details not loaded'),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),

        // Pickup Start Button
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onPickupStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.play_arrow),
                label: const Text(
                  'Pickup Start',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Supplier Card
  static Widget _buildSupplierCard(
    TripSupplierDetailModel supplier,
    int index,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFDFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardGreen, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Supplier $index',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          // Supplier Name from API
          Text(
            supplier.sSupplierName ?? '--',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  // Supplier Row
  static Widget _supplierRow(IconData icon, String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryBlue, size: 21),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              value == null || value.isEmpty ? '--' : value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Common Trip Detail Card
  static Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFDFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardGreen, width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFE5F0F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primaryBlue, size: 27),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value.isNotEmpty ? value : '--',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
