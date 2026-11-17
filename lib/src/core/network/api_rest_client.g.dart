// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _ApiRestClient implements ApiRestClient {
  _ApiRestClient(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://glplkmilkrun.giplapp.in';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<AuthResponse> authenticate(AuthenticateReq req) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req.toJson());
    final _options = _setStreamType<AuthResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/gl/api/Auth/Authenticate',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AuthResponse _value;
    try {
      _value = AuthResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<LoginRsp> login(
    String clientAppID,
    String clientAppHash,
    String authToken,
    LoginReq req,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'sClientAppID': clientAppID,
      r'sClientAppHash': clientAppHash,
      r'sAuthToken': authToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(req.toJson());
    final _options = _setStreamType<LoginRsp>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/gl/api/Auth/Login',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late LoginRsp _value;
    try {
      _value = LoginRsp.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetLibraryRsp> getLibrary(GetLibraryReq req) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req.toJson());
    final _options = _setStreamType<GetLibraryRsp>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/gl/api/Auth/GetLibrary',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetLibraryRsp _value;
    try {
      _value = GetLibraryRsp.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetAllTripPlansAndTripsRsp> getAllTripPlansAndTrips({
    String? fPagination,
    String? sFilter,
    String? jPageNumber,
    String? jCount,
    String? sSorting,
    String? fWithOutDispatched,
    required String suidSession,
    String? sTag,
    String? sTimeZone,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (fPagination != null) {
      _data.fields.add(MapEntry('fPagination', fPagination));
    }
    if (sFilter != null) {
      _data.fields.add(MapEntry('sFilter', sFilter));
    }
    if (jPageNumber != null) {
      _data.fields.add(MapEntry('jPageNumber', jPageNumber));
    }
    if (jCount != null) {
      _data.fields.add(MapEntry('jCount', jCount));
    }
    if (sSorting != null) {
      _data.fields.add(MapEntry('sSorting', sSorting));
    }
    if (fWithOutDispatched != null) {
      _data.fields.add(MapEntry('fWithOutDispatched', fWithOutDispatched));
    }
    _data.fields.add(MapEntry('suidSession', suidSession));
    if (sTag != null) {
      _data.fields.add(MapEntry('sTag', sTag));
    }
    if (sTimeZone != null) {
      _data.fields.add(MapEntry('sTimeZone', sTimeZone));
    }
    final _options = _setStreamType<GetAllTripPlansAndTripsRsp>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data',
          )
          .compose(
            _dio.options,
            '/gl/api/Trip/GetAllTripPlansAndTrips',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetAllTripPlansAndTripsRsp _value;
    try {
      _value = GetAllTripPlansAndTripsRsp.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UpdateTripAndSupplierPickupRsp> updateTripAndSupplierPickup(
    UpdateTripAndSupplierPickupReq req,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req.toJson());
    final _options = _setStreamType<UpdateTripAndSupplierPickupRsp>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/gl/api/Trip/UpdateTripAndSupplierPickup',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late UpdateTripAndSupplierPickupRsp _value;
    try {
      _value = UpdateTripAndSupplierPickupRsp.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetTripSupplierDetailsRsp> getTripSupplierDetails(
    GetTripSupplierDetailsReq req,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req.toJson());
    final _options = _setStreamType<GetTripSupplierDetailsRsp>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/gl/api/Trip/GetTripSupplierDetails',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetTripSupplierDetailsRsp _value;
    try {
      _value = GetTripSupplierDetailsRsp.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
