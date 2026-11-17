import 'package:gl_mobile_app/src/features/authentication/model/authenticate/authenticate_req.dart';
import 'package:gl_mobile_app/src/features/authentication/model/authenticate/authenticate_rsp.dart';
import 'package:gl_mobile_app/src/features/authentication/model/login/login_req.dart';
import 'package:gl_mobile_app/src/features/authentication/model/login/login_rsp.dart';
import 'package:gl_mobile_app/src/features/trip/model/get_all_trip_plans_and_trips/get_all_trip_plans_and_trips_rsp.dart';
import 'package:gl_mobile_app/src/features/trip/model/update_trip_and_supplier_pickup/update_trip_and_supplier_pickup_req.dart';
import 'package:gl_mobile_app/src/features/trip/model/update_trip_and_supplier_pickup/update_trip_and_supplier_pickup_rsp.dart';
import 'package:gl_mobile_app/src/core/network/api_rest_client.dart';
import 'package:gl_mobile_app/src/features/trip/model/get_library/get_library_req.dart';
import 'package:gl_mobile_app/src/features/trip/model/get_library/get_library_rsp.dart';
import 'package:gl_mobile_app/src/features/trip/model/get_trip_supplier_details/get_trip_supplier_details_req.dart';
import 'package:gl_mobile_app/src/features/trip/model/get_trip_supplier_details/get_trip_supplier_details_rsp.dart';

class ApiRepository {
  final ApiRestClient _apiRestClient;

  ApiRepository(this._apiRestClient);

  Future<AuthResponse> authenticate(AuthenticateReq request) async {
    return await _apiRestClient.authenticate(request);
  }

  Future<LoginRsp?> login(
    LoginReq loginReq, {
    required String authToken,
    required String clientAppID,
    required String clientAppHash,
  }) async {
    return await _apiRestClient.login(
      clientAppID,
      clientAppHash,
      authToken,
      loginReq,
    );
  }

  Future<GetLibraryRsp> getLibrary(GetLibraryReq request) async {
    return await _apiRestClient.getLibrary(request);
  }

  Future<GetAllTripPlansAndTripsRsp> getAllTripPlansAndTrips({
    required String suidSession,
    String? fPagination,
    String? sFilter,
    String? jPageNumber,
    String? jCount,
    String? sSorting,
    String? fWithOutDispatched,
    String? sTag,
    String? sTimeZone,
  }) async {
    return await _apiRestClient.getAllTripPlansAndTrips(
      suidSession: suidSession,
      fPagination: fPagination,
      sFilter: sFilter,
      jPageNumber: jPageNumber,
      jCount: jCount,
      sSorting: sSorting,
      fWithOutDispatched: fWithOutDispatched,
      sTag: sTag,
      sTimeZone: sTimeZone,
    );
  }

  Future<UpdateTripAndSupplierPickupRsp> updateTripAndSupplierPickup(
    UpdateTripAndSupplierPickupReq request,
  ) async {
    return await _apiRestClient.updateTripAndSupplierPickup(request);
  }

  Future<GetTripSupplierDetailsRsp> getTripSupplierDetails(
    GetTripSupplierDetailsReq request,
  ) async {
    return await _apiRestClient.getTripSupplierDetails(request);
  }
}
