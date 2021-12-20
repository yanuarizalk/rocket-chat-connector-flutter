// Mocks generated by Mockito 5.0.3 from annotations
// in rocket_chat_connector_flutter/test/services/authentication_service_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:http/src/response.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rocket_chat_connector_flutter/models/authentication.dart'
    as _i6;
import 'package:rocket_chat_connector_flutter/models/filters/filter.dart'
    as _i5;
import 'package:rocket_chat_connector_flutter/services/http_service.dart'
    as _i3;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeResponse extends _i1.Fake implements _i2.Response {}

/// A class which mocks [HttpService].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpService extends _i1.Mock implements _i3.HttpService {
  MockHttpService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Response> getWithFilter(String? uri, _i5.Filter? filter,
          _i6.Authentication? authentication, {Map query = const {}}) =>
      (super.noSuchMethod(
              Invocation.method(#getWithFilter, [uri, filter, authentication]),
              returnValue: Future.value(_FakeResponse()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> get(
          String? uri, _i6.Authentication? authentication) =>
      (super.noSuchMethod(Invocation.method(#get, [uri, authentication]),
              returnValue: Future.value(_FakeResponse()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> post(
          String? uri, String? body, _i6.Authentication? authentication) =>
      (super.noSuchMethod(Invocation.method(#post, [uri, body, authentication]),
              returnValue: Future.value(_FakeResponse()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> put(
          String? uri, String? body, _i6.Authentication? authentication) =>
      (super.noSuchMethod(Invocation.method(#put, [uri, body, authentication]),
              returnValue: Future.value(_FakeResponse()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> delete(
          String? uri, _i6.Authentication? authentication) =>
      (super.noSuchMethod(Invocation.method(#delete, [uri, authentication]),
              returnValue: Future.value(_FakeResponse()))
          as _i4.Future<_i2.Response>);
}
