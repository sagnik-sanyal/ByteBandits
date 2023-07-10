import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

import '../errors/failure.dart';
import '../extensions/failure_extension.dart';

final Provider<HttpBaseClient> httpClientProvider = Provider<HttpBaseClient>(
  name: 'httpClientProvider',
  (ProviderRef<HttpBaseClient> ref) {
    final HttpBaseClient httpBaseClient = HttpBaseClient(Client());
    ref.onDispose(httpBaseClient.close);
    return httpBaseClient;
  },
);

String BASE_URL = 'https://fing-go.el.r.appspot.com/';

class HttpBaseClient {
  late final Client _client;

  HttpBaseClient(this._client);

  void close() => _client.close();

  // Get the data from the remote server
  Future<Either<Failure, String>> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      Response response = await _client.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return right(response.body);
      }
      return left(Failure.http(
        code: response.statusCode,
        stackTrace: StackTrace.current,
        message: 'Something went wrong',
      ));
    } on HttpException catch (e, stackTrace) {
      return left(e.toFailure(stackTrace));
    } on IOException catch (e, stackTrace) {
      return left(e.toFailure(stackTrace));
    } on FormatException catch (e, stackTrace) {
      return left(e.toFailure(stackTrace));
    } catch (e, stackTrace) {
      return left(Failure.unkown(stackTrace: stackTrace));
    }
  }

  //Post call to the api
  Future<Either<Failure, String>> post(
    String url, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    try {
      Response response = await _client.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        return right(response.body);
      }
      return left(Failure.http(
        code: response.statusCode,
        stackTrace: StackTrace.current,
        message: 'Something went wrong',
      ));
    } on HttpException catch (e, stackTrace) {
      return left(e.toFailure(stackTrace));
    } on IOException catch (e, stackTrace) {
      return left(e.toFailure(stackTrace));
    } on FormatException catch (e, stackTrace) {
      return left(e.toFailure(stackTrace));
    } catch (e, stackTrace) {
      return left(Failure.unkown(stackTrace: stackTrace));
    }
  }
}
