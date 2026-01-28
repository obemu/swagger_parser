import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:swagger_parser/src/parser/model/universal_request_type.dart';
import 'package:swagger_parser/src/parser/model/universal_type.dart';
import 'package:swagger_parser/src/utils/content_type_utils.dart';

/// Universal template for containing information about Request
@immutable
final class UniversalRequest {
  /// Constructor for [UniversalRequest]
  UniversalRequest({
    required this.name,
    required this.requestType,
    required this.route,
    required this.returnType,
    required this.parameters,
    this.tags = const [],
    this.operationId,
    this.externalDocsUrl,
    SwaggerContentType? contentType,
    this.returnContentType,
    this.description,
    this.isDeprecated = false,
  }) : contentType = contentType ?? SwaggerContentType('application', 'json');

  /// Request name
  final String name;

  /// Request description
  final String? description;

  /// Original OpenAPI tags
  final List<String> tags;

  /// Original OpenAPI operationId
  final String? operationId;

  /// Optional OpenAPI externalDocs url
  final String? externalDocsUrl;

  /// HTTP type of request
  final HttpRequestType requestType;

  /// Request route
  final String route;

  /// Request return type
  final UniversalType? returnType;

  /// The content type of the response.
  final SwaggerContentType? returnContentType;

  /// Request parameters
  final List<UniversalRequestType> parameters;

  /// Request content-type
  final SwaggerContentType contentType;

  /// Value indicating whether this request is deprecated
  final bool isDeprecated;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UniversalRequest &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          requestType == other.requestType &&
          contentType == other.contentType &&
          route == other.route &&
          returnType == other.returnType &&
          returnContentType == other.returnContentType &&
          const DeepCollectionEquality().equals(tags, other.tags) &&
          operationId == other.operationId &&
          externalDocsUrl == other.externalDocsUrl &&
          const DeepCollectionEquality().equals(parameters, other.parameters);

  @override
  int get hashCode =>
      name.hashCode ^
      requestType.hashCode ^
      route.hashCode ^
      returnType.hashCode ^
      returnContentType.hashCode ^
      tags.hashCode ^
      operationId.hashCode ^
      externalDocsUrl.hashCode ^
      contentType.hashCode ^
      parameters.hashCode;

  @override
  String toString() => 'UniversalRequest(name: $name, '
      'tags: $tags, '
      'operationId: $operationId, '
      'externalDocsUrl: $externalDocsUrl, '
      'requestType: $requestType, '
      'route: $route, '
      'parameters: $parameters, '
      'contentType: $contentType, '
      'returnContentType: $returnContentType)';
}

/// Request type
enum HttpRequestType {
  /// GET
  get,

  /// POST
  post,

  /// HEAD
  head,

  /// PUT
  put,

  /// DELETE
  delete,

  /// PATCH
  patch,

  /// CONNECT
  connect,

  /// OPTIONS
  options,

  /// TRACE
  trace;

  /// Constructor for [HttpRequestType]
  const HttpRequestType();

  /// Get type from string
  static HttpRequestType? fromString(String type) =>
      HttpRequestType.values.firstWhereOrNull((e) => e.name == type);
}
