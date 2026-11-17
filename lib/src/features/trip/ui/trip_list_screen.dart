import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gl_mobile_app/src/core/network/api_repository.dart';

import 'package:gl_mobile_app/src/features/trip/bloc/get_all_trip_plans_and_trips/get_all_trip_plans_and_trips_bloc.dart';
import 'package:gl_mobile_app/src/features/trip/bloc/get_all_trip_plans_and_trips/get_all_trip_plans_and_trips_event.dart';
import 'package:gl_mobile_app/src/features/trip/bloc/get_all_trip_plans_and_trips/get_all_trip_plans_and_trips_state.dart';

import 'package:gl_mobile_app/src/features/trip/bloc/get_trip_supplier_details/get_trip_supplier_details_bloc.dart';
import 'package:gl_mobile_app/src/features/trip/bloc/get_trip_supplier_details/get_trip_supplier_details_event.dart';
import 'package:gl_mobile_app/src/features/trip/bloc/get_trip_supplier_details/get_trip_supplier_details_state.dart';

import 'package:gl_mobile_app/src/features/trip/bloc/update_trip_and_supplier_pickup/update_trip_and_supplier_pickup_bloc.dart';
import 'package:gl_mobile_app/src/features/trip/bloc/update_trip_and_supplier_pickup/update_trip_and_supplier_pickup_event.dart';
import 'package:gl_mobile_app/src/features/trip/bloc/update_trip_and_supplier_pickup/update_trip_and_supplier_pickup_state.dart';

import 'package:gl_mobile_app/src/features/trip/model/get_library/get_library_req.dart';
import 'package:gl_mobile_app/src/features/trip/model/get_trip_supplier_details/get_trip_supplier_details_req.dart';
import 'package:gl_mobile_app/src/features/trip/model/update_trip_and_supplier_pickup/update_trip_and_supplier_pickup_req.dart';

import 'package:gl_mobile_app/src/features/trip/ui/trip_details_screen.dart';

class TripListScreen extends StatefulWidget {
  final ApiRepository apiRepository;
  final String suidSession;
  final String username;
  final String vehicleNumber;

  const TripListScreen({
    super.key,
    required this.apiRepository,
    required this.suidSession,
    required this.username,
    required this.vehicleNumber,
  });

  static const Color primaryBlue = Color(0xFF10466B);
  static const Color pageBackground = Color(0xFFF4F7FA);

  @override
  State<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  Map<String, dynamic> tripActionEnums = {};

  String? _pendingTripId;
  int? _pendingAction;

  @override
  void initState() {
    super.initState();
    _getTripActivityLibrary();
  }

  int? _getEnumValue(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }

  Future<void> _getTripActivityLibrary() async {
    try {
      final request = GetLibraryReq(
        sTag: 'TripActivity',
        sTimeZone: 'Asia/Kolkata',
        suidSession: widget.suidSession,
      );

      final response = await widget.apiRepository.getLibrary(request);

      if (!mounted) return;

      if (response.data == null || response.data!.isEmpty) {
        debugPrint('GetLibrary: Empty response data');
        return;
      }

      final decodedData = jsonDecode(response.data!);

      final library = Map<String, dynamic>.from(decodedData['Library'] ?? {});

      final tripAction = Map<String, dynamic>.from(library['TripAction'] ?? {});

      setState(() {
        tripActionEnums = tripAction;
      });

      debugPrint('========== TRIP ACTION ENUMS ==========');
      debugPrint('TripAction: $tripActionEnums');

      debugPrint(
        'BIT_TRIPSTARTED: ${_getEnumValue(tripActionEnums['BIT_TRIPSTARTED'])}',
      );

      debugPrint(
        'BIT_TRIPEND: ${_getEnumValue(tripActionEnums['BIT_TRIPEND'])}',
      );

      debugPrint(
        'BIT_PICKUPSTART: ${_getEnumValue(tripActionEnums['BIT_PICKUPSTART'])}',
      );

      debugPrint(
        'BIT_PICKUPEND: ${_getEnumValue(tripActionEnums['BIT_PICKUPEND'])}',
      );

      debugPrint('GetLibrary Status: ${response.status?.sResponseText}');
    } catch (e) {
      debugPrint('GetLibrary API Error: $e');
    }
  }

  // ======================================================
  // TRIP ACTION
  // ======================================================

  void _updateTripAction({
    required BuildContext context,
    required String tripId,
    required int action,
  }) {
    if (tripId.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Trip ID is missing')));
      return;
    }

    final tripStartedValue = _getEnumValue(tripActionEnums['BIT_TRIPSTARTED']);

    final tripEndValue = _getEnumValue(tripActionEnums['BIT_TRIPEND']);

    final pickupStartValue = _getEnumValue(tripActionEnums['BIT_PICKUPSTART']);

    final pickupEndValue = _getEnumValue(tripActionEnums['BIT_PICKUPEND']);

    final isValidAction =
        action == tripStartedValue ||
        action == tripEndValue ||
        action == pickupStartValue ||
        action == pickupEndValue;

    if (!isValidAction) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid trip action')));
      return;
    }

    // Every action first fetches Supplier Details.
    // Start Trip also fetches Supplier Details before Update API.

    _pendingTripId = tripId;
    _pendingAction = action;

    debugPrint('========== FETCH SUPPLIER DETAILS ==========');
    debugPrint('Trip ID: $tripId');
    debugPrint('Action: $action');

    context.read<GetTripSupplierDetailsBloc>().add(
      FetchTripSupplierDetails(suidTrip: tripId),
    );
  }

  // ======================================================
  // UPDATE TRIP API REQUEST
  // ======================================================

  void _sendUpdateTripRequest({
    required BuildContext context,
    required String tripId,
    required int action,
    required String supplierDetailsId,
  }) {
    if (supplierDetailsId.trim().isEmpty) {
      debugPrint('ERROR: Supplier Details ID is empty');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Supplier Details ID is missing')),
      );
      return;
    }

    final tripStartedValue = _getEnumValue(tripActionEnums['BIT_TRIPSTARTED']);

    final tripEndValue = _getEnumValue(tripActionEnums['BIT_TRIPEND']);

    final pickupStartValue = _getEnumValue(tripActionEnums['BIT_PICKUPSTART']);

    final pickupEndValue = _getEnumValue(tripActionEnums['BIT_PICKUPEND']);

    final currentTime = DateTime.now().toUtc().toIso8601String();

    final isTripStart = action == tripStartedValue;
    final isTripEnd = action == tripEndValue;
    final isPickupStart = action == pickupStartValue;
    final isPickupEnd = action == pickupEndValue;

    final request = UpdateTripAndSupplierPickupReq(
      sTag: 'TripActivity',
      sTimeZone: 'Asia/Kolkata',
      suidSession: widget.suidSession,
      suidTrip: tripId,
      jTripAction: action,

      // START TRIP
      dtActualStart: isTripStart ? currentTime : null,

      // END TRIP
      dtActualEnd: isTripEnd ? currentTime : null,

      // SUPPLIER DETAILS ID
      suidTripSupplierDetails: supplierDetailsId,

      // PICKUP START
      dtArrivalStart: isPickupStart ? currentTime : null,
      dtPickupStart: isPickupStart ? currentTime : null,

      // PICKUP END
      dtDeparture: isPickupEnd ? currentTime : null,
      dtPickupEnd: isPickupEnd ? currentTime : null,
    );

    debugPrint('========== UPDATE TRIP REQUEST ==========');
    debugPrint('Trip ID: $tripId');
    debugPrint('Supplier Details ID: $supplierDetailsId');
    debugPrint('Action: $action');
    debugPrint('Actual Start: ${request.dtActualStart}');
    debugPrint('Actual End: ${request.dtActualEnd}');
    debugPrint('Arrival Start: ${request.dtArrivalStart}');
    debugPrint('Pickup Start: ${request.dtPickupStart}');
    debugPrint('Departure: ${request.dtDeparture}');
    debugPrint('Pickup End: ${request.dtPickupEnd}');
    debugPrint('Request: ${jsonEncode(request.toJson())}');
    debugPrint('========================================');

    context.read<UpdateTripAndSupplierPickupBloc>().add(
      UpdateTripAndSupplierPickupRequested(request: request),
    );
  }

  // ======================================================
  // BUILD
  // ======================================================

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllTripPlansAndTripsBloc>(
          create: (_) => GetAllTripPlansAndTripsBloc(widget.apiRepository)
            ..add(
              GetAllTripPlansAndTripsRequested(suidSession: widget.suidSession),
            ),
        ),

        BlocProvider<GetTripSupplierDetailsBloc>(
          create: (_) => GetTripSupplierDetailsBloc(
            getTripSupplierDetails: (suidTrip) {
              final request = GetTripSupplierDetailsReq(
                sTag: 'TripActivity',
                sTimeZone: 'Asia/Kolkata',
                suidSession: widget.suidSession,
                suidTrip: suidTrip,
              );

              return widget.apiRepository.getTripSupplierDetails(request);
            },
          ),
        ),

        BlocProvider<UpdateTripAndSupplierPickupBloc>(
          create: (_) => UpdateTripAndSupplierPickupBloc(widget.apiRepository),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: TripListScreen.pageBackground,

            appBar: AppBar(
              backgroundColor: TripListScreen.primaryBlue,
              foregroundColor: Colors.white,
              title: const Text(
                'Milk Run Trips',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  tooltip: 'Refresh trips',
                  icon: const Icon(Icons.refresh, size: 28),
                  onPressed: () {
                    context.read<GetAllTripPlansAndTripsBloc>().add(
                      GetAllTripPlansAndTripsRequested(
                        suidSession: widget.suidSession,
                      ),
                    );
                  },
                ),
              ],
            ),

            body: MultiBlocListener(
              listeners: [
                // ==================================================
                // LISTENER 1: SUPPLIER DETAILS RESPONSE
                // ==================================================
                BlocListener<
                  GetTripSupplierDetailsBloc,
                  GetTripSupplierDetailsState
                >(
                  listener: (context, state) {
                    if (state is GetTripSupplierDetailsSuccess) {
                      debugPrint(
                        '========== SUPPLIER DETAILS SUCCESS ==========',
                      );

                      debugPrint(
                        'Supplier Count: ${state.supplierDetails.length}',
                      );

                      // If this fetch was only for opening the details
                      // screen, do not call Update Trip API.
                      final tripId = _pendingTripId;
                      final action = _pendingAction;

                      if (tripId == null || action == null) {
                        debugPrint(
                          'Supplier details fetched for Details Screen only.',
                        );
                        return;
                      }

                      String? supplierDetailsId;

                      for (final supplier in state.supplierDetails) {
                        final id = supplier.suidTripSupplierDetails?.trim();

                        debugPrint('Supplier Name: ${supplier.sSupplierName}');

                        debugPrint('Supplier Details ID: $id');

                        if (id != null && id.isNotEmpty) {
                          supplierDetailsId = id;
                          break;
                        }
                      }

                      debugPrint(
                        'Selected Supplier Details ID: $supplierDetailsId',
                      );

                      if (supplierDetailsId == null) {
                        _pendingTripId = null;
                        _pendingAction = null;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Supplier Details ID not found.'),
                          ),
                        );
                        return;
                      }

                      // Clear pending values after reading them.
                      _pendingTripId = null;
                      _pendingAction = null;

                      // Call Update API with valid Supplier ID.
                      _sendUpdateTripRequest(
                        context: context,
                        tripId: tripId,
                        action: action,
                        supplierDetailsId: supplierDetailsId,
                      );
                    }

                    if (state is GetTripSupplierDetailsFailure) {
                      // Only show action error if an action was pending.
                      final hasPendingAction =
                          _pendingTripId != null && _pendingAction != null;

                      _pendingTripId = null;
                      _pendingAction = null;

                      debugPrint(
                        'Supplier Details API Failed: ${state.message}',
                      );

                      if (hasPendingAction) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    }
                  },
                ),

                // ==================================================
                // LISTENER 2: UPDATE TRIP RESPONSE
                // ==================================================
                BlocListener<
                  UpdateTripAndSupplierPickupBloc,
                  UpdateTripAndSupplierPickupState
                >(
                  listener: (context, state) {
                    if (state is UpdateTripAndSupplierPickupSuccess) {
                      debugPrint('========== UPDATE TRIP SUCCESS ==========');

                      debugPrint(
                        'Response: ${state.response.status?.sResponseText}',
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.response.status?.sResponseText ??
                                'Trip updated successfully',
                          ),
                        ),
                      );

                      // Refresh trip list after successful update.
                      context.read<GetAllTripPlansAndTripsBloc>().add(
                        GetAllTripPlansAndTripsRequested(
                          suidSession: widget.suidSession,
                        ),
                      );
                    }

                    if (state is UpdateTripAndSupplierPickupFailure) {
                      debugPrint('========== UPDATE TRIP FAILURE ==========');
                      debugPrint('Error: ${state.message}');

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                ),
              ],

              // ==================================================
              // TRIP LIST BLOC BUILDER
              // ==================================================
              child:
                  BlocBuilder<
                    GetAllTripPlansAndTripsBloc,
                    GetAllTripPlansAndTripsState
                  >(
                    builder: (context, state) {
                      if (state is GetAllTripPlansAndTripsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is GetAllTripPlansAndTripsFailure) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 56,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  state.message,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    context
                                        .read<GetAllTripPlansAndTripsBloc>()
                                        .add(
                                          GetAllTripPlansAndTripsRequested(
                                            suidSession: widget.suidSession,
                                          ),
                                        );
                                  },
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (state is GetAllTripPlansAndTripsSuccess) {
                        final trips = state.response.data ?? [];

                        return _TripListContent(
                          trips: trips,
                          username: widget.username,
                          tripActionEnums: tripActionEnums,
                          onTripAction:
                              ({
                                required BuildContext context,
                                required String tripId,
                                required int action,
                              }) {
                                _updateTripAction(
                                  context: context,
                                  tripId: tripId,
                                  action: action,
                                );
                              },
                        );
                      }

                      return const Center(
                        child: Text(
                          'Loading trips...',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  ),
            ),

            // ==================================================
            // BOTTOM NAVIGATION
            // ==================================================
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: 0,
              selectedItemColor: TripListScreen.primaryBlue,
              unselectedItemColor: Colors.blueGrey,
              selectedFontSize: 13,
              unselectedFontSize: 13,
              iconSize: 27,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_outlined),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ======================================================
// TRIP LIST CONTENT
// ======================================================

class _TripListContent extends StatefulWidget {
  final List<dynamic> trips;
  final String username;
  final Map<String, dynamic> tripActionEnums;

  final Function({
    required BuildContext context,
    required String tripId,
    required int action,
  })
  onTripAction;

  const _TripListContent({
    required this.trips,
    required this.username,
    required this.tripActionEnums,
    required this.onTripAction,
  });

  @override
  State<_TripListContent> createState() => _TripListContentState();
}

class _TripListContentState extends State<_TripListContent> {
  int selectedFilter = 0;

  static const List<String> filters = [
    'All Trips',
    'Not Started',
    'Running',
    'Delayed',
    'Completed',
    'Delayed Completed',
  ];

  bool _matchesFilter(dynamic item) {
    if (selectedFilter == 0) return true;

    final trip = item.trip;
    final status = (trip?.sTripStatus ?? '').toLowerCase().trim();

    switch (selectedFilter) {
      case 1:
        return status.contains('not started') ||
            status.contains('pending') ||
            status.isEmpty;

      case 2:
        return status.contains('running') || status.contains('started');

      case 3:
        return status.contains('delayed') && !status.contains('completed');

      case 4:
        return status == 'completed' ||
            (status.contains('completed') && !status.contains('delayed'));

      case 5:
        return status.contains('delayed completed');

      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show only trips where suidTrip is not null or empty.
    final trips = widget.trips.where((item) {
      final suid = item.trip?.suidTrip;

      return suid != null && suid.trim().isNotEmpty;
    }).toList();

    // Apply selected filter.
    final filteredTrips = trips.where(_matchesFilter).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good Morning,',
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.username.isNotEmpty ? widget.username : 'Driver',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: TripListScreen.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD6E2EC)),
              ),
              child: const Icon(
                Icons.person_outline,
                size: 30,
                color: TripListScreen.primaryBlue,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // TODAY'S TRIPS CARD
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFD6E2EC)),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F0F8),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.local_shipping,
                  color: TripListScreen.primaryBlue,
                  size: 34,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Trips",
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${trips.length}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: TripListScreen.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // FILTERS
        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final isSelected = selectedFilter == index;

              return ChoiceChip(
                label: Text(
                  filters[index],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : TripListScreen.primaryBlue,
                  ),
                ),
                selected: isSelected,
                showCheckmark: false,
                selectedColor: TripListScreen.primaryBlue,
                backgroundColor: Colors.white,
                side: BorderSide(
                  color: isSelected
                      ? TripListScreen.primaryBlue
                      : const Color(0xFFD0DCE6),
                ),
                onSelected: (_) {
                  setState(() {
                    selectedFilter = index;
                  });
                },
              );
            },
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'Trip List (${filteredTrips.length})',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: TripListScreen.primaryBlue,
          ),
        ),

        const SizedBox(height: 12),

        if (filteredTrips.isEmpty)
          const Padding(
            padding: EdgeInsets.all(30),
            child: Center(
              child: Text('No trips available', style: TextStyle(fontSize: 18)),
            ),
          )
        else
          ...filteredTrips.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            final trip = item.trip;
            final plan = item.tripPlan;

            final tripId = trip?.suidTrip ?? '';
            final tripNumber = trip?.sTripId ?? '';
            final isTripStarted = trip?.dtActualStart != null;

            debugPrint('========== TRIP ID CHECK ==========');
            debugPrint('suidTrip: ${trip?.suidTrip}');
            debugPrint('sTripId: ${trip?.sTripId}');

            final vehicleNo = trip?.sVehicleNumber ?? '';

            final from = plan?.sFromRegion ?? 'From';
            final to = plan?.sToRegion ?? 'To';

            final status =
                trip?.sTripStatus ?? plan?.sTripType ?? 'Not Started';

            final startTime = trip?.sdtExpectedStartTime ?? '';

            debugPrint('Trip ID: $tripId | API Status: "$status"');

            return _TripCard(
              tripNumber: tripNumber.isNotEmpty
                  ? tripNumber
                  : 'Trip ${index + 1}',
              from: from,
              to: to,
              status: status,
              startTime: startTime,
              sTripId: tripId,
              sVehicleNumber: vehicleNo,
              tripActionEnums: widget.tripActionEnums,
              isTripStarted: isTripStarted,
              onTripAction: widget.onTripAction,
            );
          }),
      ],
    );
  }
}

class _TripCard extends StatelessWidget {
  final String tripNumber;
  final String from;
  final String to;
  final String status;
  final bool isTripStarted;
  final String startTime;
  final String sTripId;
  final String sVehicleNumber;
  final Map<String, dynamic> tripActionEnums;

  final Function({
    required BuildContext context,
    required String tripId,
    required int action,
  })
  onTripAction;

  const _TripCard({
    required this.tripNumber,
    required this.from,
    required this.to,
    required this.status,
    required this.isTripStarted,
    required this.startTime,
    required this.tripActionEnums,
    required this.onTripAction,
    this.sTripId = '',
    this.sVehicleNumber = '',
  });

  static const Color cardGreen = Color(0xFF6F9F7A);
  static const Color primaryBlue = TripListScreen.primaryBlue;

  int? _getEnumValue(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }

  // ======================================================
  // OPEN TRIP DETAILS
  // ======================================================

  void _openTripDetails(BuildContext context) {
    // Reuse the existing BLoCs from TripListScreen.
    final updateTripBloc = context.read<UpdateTripAndSupplierPickupBloc>();

    final supplierDetailsBloc = context.read<GetTripSupplierDetailsBloc>();

    // Fetch supplier details for the selected trip.
    supplierDetailsBloc.add(FetchTripSupplierDetails(suidTrip: sTripId));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (detailsContext) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: updateTripBloc),
              BlocProvider.value(value: supplierDetailsBloc),
            ],
            child: TripDetailsScreen(
              tripId: sTripId,
              tripNo: tripNumber,
              status: status,
              location: '$from → $to',
              startTime: startTime,
              estimatedTime: '--',
              vehicleNo: sVehicleNumber,

              onPickupStart: () {
                if (!isTripStarted) {
                  ScaffoldMessenger.of(detailsContext).showSnackBar(
                    const SnackBar(content: Text('Please Start Trip first.')),
                  );
                  return;
                }

                final action = _getEnumValue(
                  tripActionEnums['BIT_PICKUPSTART'],
                );

                if (action == null) {
                  ScaffoldMessenger.of(detailsContext).showSnackBar(
                    const SnackBar(
                      content: Text('Pickup Start action not available'),
                    ),
                  );
                  return;
                }

                onTripAction(
                  context: detailsContext,
                  tripId: sTripId,
                  action: action,
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = status.trim().toLowerCase();

    final isNotStarted =
        normalizedStatus.isEmpty ||
        normalizedStatus.contains('not started') ||
        normalizedStatus.contains('pending');

    final isCompleted = normalizedStatus.contains('completed');

    final isTripRunning =
        normalizedStatus.contains('running') ||
        normalizedStatus.contains('started');

    final buttonText = isCompleted
        ? 'Completed'
        : isNotStarted
        ? 'Start Trip'
        : isTripRunning
        ? 'End Trip'
        : 'Start Trip';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFDFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cardGreen, width: 1.5),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // TRIP NUMBER
            Container(
              width: 100,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Color(0xFFD5E2D7), width: 1.2),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Trip No.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF58735E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tripNumber,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                    ),
                  ),
                ],
              ),
            ),

            // TRIP DETAILS
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 4, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$from → $to',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Vehicle No.: ${sVehicleNumber.isNotEmpty ? sVehicleNumber : '--'}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Status: $status',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Start: ${startTime.isNotEmpty ? startTime : '--:--'}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // START TRIP / END TRIP BUTTON
                    ElevatedButton(
                      onPressed: isCompleted
                          ? null
                          : () {
                              final actionKey = isNotStarted
                                  ? 'BIT_TRIPSTARTED'
                                  : 'BIT_TRIPEND';

                              final action = _getEnumValue(
                                tripActionEnums[actionKey],
                              );

                              if (action == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '$actionKey value not available',
                                    ),
                                  ),
                                );
                                return;
                              }

                              debugPrint('Button Clicked: $buttonText');
                              debugPrint('Trip ID: $sTripId');
                              debugPrint('Action: $action');

                              onTripAction(
                                context: context,
                                tripId: sTripId,
                                action: action,
                              );
                            },
                      child: Text(buttonText),
                    ),
                  ],
                ),
              ),
            ),

            // TRIP DETAILS ARROW
            IconButton(
              onPressed: () => _openTripDetails(context),
              icon: const Icon(
                Icons.chevron_right,
                color: Color(0xFF2876B8),
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
