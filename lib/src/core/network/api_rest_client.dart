import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:gl_mobile_app/src/features/authentication/model/authenticate/authenticate_req.dart';
import 'package:gl_mobile_app/src/features/authentication/model/authenticate/authenticate_rsp.dart';
import 'package:gl_mobile_app/src/features/authentication/model/login/login_req.dart';
import 'package:gl_mobile_app/src/features/authentication/model/login/login_rsp.dart';

import 'package:gl_mobile_app/src/features/trip/model/get_all_trip_plans_and_trips/get_all_trip_plans_and_trips_rsp.dart';
import 'package:gl_mobile_app/src/features/trip/model/get_library/get_library_req.dart';
import 'package:gl_mobile_app/src/features/trip/model/get_library/get_library_rsp.dart';

import 'package:gl_mobile_app/src/features/trip/model/update_trip_and_supplier_pickup/update_trip_and_supplier_pickup_req.dart';
import 'package:gl_mobile_app/src/features/trip/model/update_trip_and_supplier_pickup/update_trip_and_supplier_pickup_rsp.dart';
import 'package:gl_mobile_app/src/features/trip/model/get_trip_supplier_details/get_trip_supplier_details_req.dart';
import 'package:gl_mobile_app/src/features/trip/model/get_trip_supplier_details/get_trip_supplier_details_rsp.dart';
part 'api_rest_client.g.dart';

@RestApi(baseUrl: 'https://glplkmilkrun.giplapp.in')
abstract class ApiRestClient {
  factory ApiRestClient(Dio dio, {String? baseUrl}) = _ApiRestClient;

  @POST('/gl/api/Auth/Authenticate')
  Future<AuthResponse> authenticate(@Body() AuthenticateReq req);

  @POST('/gl/api/Auth/Login')
  Future<LoginRsp> login(
    @Header('sClientAppID') String clientAppID,
    @Header('sClientAppHash') String clientAppHash,
    @Header('sAuthToken') String authToken,
    @Body() LoginReq req,
  );

  @POST('/gl/api/Auth/GetLibrary')
  Future<GetLibraryRsp> getLibrary(@Body() GetLibraryReq req);

  @POST('/gl/api/Trip/GetAllTripPlansAndTrips')
  @MultiPart()
  Future<GetAllTripPlansAndTripsRsp> getAllTripPlansAndTrips({
    @Part(name: 'fPagination') String? fPagination,
    @Part(name: 'sFilter') String? sFilter,
    @Part(name: 'jPageNumber') String? jPageNumber,
    @Part(name: 'jCount') String? jCount,
    @Part(name: 'sSorting') String? sSorting,
    @Part(name: 'fWithOutDispatched') String? fWithOutDispatched,
    @Part(name: 'suidSession') required String suidSession,
    @Part(name: 'sTag') String? sTag,
    @Part(name: 'sTimeZone') String? sTimeZone,
  });

  @POST('/gl/api/Trip/UpdateTripAndSupplierPickup')
  Future<UpdateTripAndSupplierPickupRsp> updateTripAndSupplierPickup(
    @Body() UpdateTripAndSupplierPickupReq req,
  );
  @POST('/gl/api/Trip/GetTripSupplierDetails')
  Future<GetTripSupplierDetailsRsp> getTripSupplierDetails(
    @Body() GetTripSupplierDetailsReq req,
  );
}
