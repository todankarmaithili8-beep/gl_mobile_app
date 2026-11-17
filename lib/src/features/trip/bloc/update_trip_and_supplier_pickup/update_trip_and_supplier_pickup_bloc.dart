import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gl_mobile_app/src/core/network/api_repository.dart';

import 'update_trip_and_supplier_pickup_event.dart';
import 'update_trip_and_supplier_pickup_state.dart';

class UpdateTripAndSupplierPickupBloc
    extends
        Bloc<
          UpdateTripAndSupplierPickupEvent,
          UpdateTripAndSupplierPickupState
        > {
  final ApiRepository _apiRepository;

  UpdateTripAndSupplierPickupBloc(this._apiRepository)
    : super(const UpdateTripAndSupplierPickupInitial()) {
    on<UpdateTripAndSupplierPickupRequested>(_onRequested);
  }

  Future<void> _onRequested(
    UpdateTripAndSupplierPickupRequested event,
    Emitter<UpdateTripAndSupplierPickupState> emit,
  ) async {
    print('========== UPDATE TRIP API START ==========');
    print('API Event Received');

    emit(const UpdateTripAndSupplierPickupLoading());

    try {
      print('Sending API Request...');

      final response = await _apiRepository.updateTripAndSupplierPickup(
        event.request,
      );

      print('========== API RESPONSE ==========');
      print('Status Code: ${response.status?.jStatusCode}');
      print('Message: ${response.status?.sResponseText}');

      if (response.status?.jStatusCode == 0) {
        print('START TRIP API SUCCESS');

        emit(UpdateTripAndSupplierPickupSuccess(response));
      } else {
        print('START TRIP API FAILED');

        emit(
          UpdateTripAndSupplierPickupFailure(
            response.status?.sResponseText ?? 'Unable to update trip.',
          ),
        );
      }
    } on DioException catch (e) {
      print('========== DIO API ERROR ==========');
      print('Error: ${e.message}');
      print('Response: ${e.response?.data}');

      emit(
        UpdateTripAndSupplierPickupFailure(
          e.response?.data?.toString() ?? e.message ?? 'Unknown API error',
        ),
      );
    } catch (e) {
      print('========== UNKNOWN ERROR ==========');
      print(e);

      emit(UpdateTripAndSupplierPickupFailure(e.toString()));
    }
  }
}
