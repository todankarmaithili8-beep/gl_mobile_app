import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gl_mobile_app/src/core/network/api_repository.dart';

import 'get_all_trip_plans_and_trips_event.dart';
import 'get_all_trip_plans_and_trips_state.dart';

class GetAllTripPlansAndTripsBloc
    extends Bloc<GetAllTripPlansAndTripsEvent, GetAllTripPlansAndTripsState> {
  final ApiRepository _apiRepository;

  GetAllTripPlansAndTripsBloc(this._apiRepository)
    : super(const GetAllTripPlansAndTripsInitial()) {
    on<GetAllTripPlansAndTripsRequested>(_onRequested);
  }

  Future<void> _onRequested(
    GetAllTripPlansAndTripsRequested event,
    Emitter<GetAllTripPlansAndTripsState> emit,
  ) async {
    emit(const GetAllTripPlansAndTripsLoading());

    try {
      print('Trip API: Request started');
      print('Trip API Session empty: ${event.suidSession.isEmpty}');
      print('Trip API Session length: ${event.suidSession.length}');

      final response = await _apiRepository.getAllTripPlansAndTrips(
        suidSession: event.suidSession,
        fPagination: 'false',
        jPageNumber: '1',
        jCount: '20',
        fWithOutDispatched: 'false',
        sTag: 'MilkRun',
        sTimeZone: DateTime.now().timeZoneName,
      );

      print('Trip API: Request completed');
      print('Trip API Status: ${response.status?.jStatusCode}');
      print('Trip API Message: ${response.status?.sResponseText}');
      print('Trip API Records: ${response.data?.length ?? 0}');

      if (response.status?.jStatusCode == 0) {
        emit(GetAllTripPlansAndTripsSuccess(response));
      } else {
        emit(
          GetAllTripPlansAndTripsFailure(
            response.status?.sResponseText ?? 'Unable to load trips.',
          ),
        );
      }
    } on DioException catch (e, stackTrace) {
      print('TRIP API ERROR: ${e.message}');
      print('TRIP API STATUS CODE: ${e.response?.statusCode}');
      print('TRIP API RESPONSE: ${e.response?.data}');
      print('TRIP API URL: ${e.requestOptions.uri}');
      print('TRIP API METHOD: ${e.requestOptions.method}');
      print('TRIP API CONTENT TYPE: ${e.requestOptions.contentType}');
      print('TRIP API STACKTRACE: $stackTrace');

      emit(
        GetAllTripPlansAndTripsFailure(
          'Trip request failed (${e.response?.statusCode ?? 'unknown'}): '
          '${e.response?.data ?? e.message ?? 'Unknown error'}',
        ),
      );
    } catch (e, stackTrace) {
      emit(GetAllTripPlansAndTripsFailure(e.toString()));
    }
  }
}
