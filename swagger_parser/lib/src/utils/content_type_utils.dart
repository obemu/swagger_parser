import 'dart:io';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

@immutable
final class SwaggerContentType implements ContentType {
  /// Creates a new content type object setting the primary type and
  /// sub type. The charset and additional parameters can also be set
  /// using [charset] and [parameters]. If charset is passed and
  /// [parameters] contains charset as well the passed [charset] will
  /// override the value in parameters. Keys passed in parameters will be
  /// converted to lower case. The `charset` entry, whether passed as `charset`
  /// or in `parameters`, will have its value converted to lower-case.
  factory SwaggerContentType(
    String primaryType,
    String subType, {
    String? charset,
    Map<String, String?> parameters = const {},
  }) {
    return SwaggerContentType.fromContentType(ContentType(
      primaryType,
      subType,
      charset: charset,
      parameters: parameters,
    ));
  }

  factory SwaggerContentType.parse(String value) =>
      SwaggerContentType.fromContentType(ContentType.parse(value));

  const SwaggerContentType.fromContentType(this._inner);

  final ContentType _inner;

  /// Content type for `multipart/form-data`.
  static final multipart = SwaggerContentType('multipart', 'form-data');

  /// Content type for `application/x-www-form-urlencoded`.
  static final formUrlEncoded =
      SwaggerContentType('application', 'x-www-form-urlencoded');

  /// Content type for `application/x-ndjson`.
  ///
  /// NDJSON (Newline Delimited JSON) is a text format where each line contains
  /// exactl. one JSON object, separated by newline characters.
  ///
  /// See:
  ///   * https://jsonltools.com/ndjson-format-specification
  ///   * https://github.com/ndjson/ndjson-spec
  static final ndJson = SwaggerContentType('application', 'x-ndjson');

  @override
  String get primaryType => _inner.primaryType;

  @override
  String get subType => _inner.subType;

  @override
  String? get charset => _inner.charset;

  @override
  String get mimeType => _inner.mimeType;

  @override
  String get value => _inner.value;

  @override
  Map<String, String?> get parameters => _inner.parameters;

  @override
  int get hashCode => Object.hash(
        primaryType,
        subType,
        charset,
        mimeType,
        value,
        const MapEquality<String, String?>().hash(parameters),
      );

  @override
  bool operator ==(Object other) {
    return other is ContentType &&
        primaryType == other.primaryType &&
        subType == other.subType &&
        charset == other.charset &&
        mimeType == other.mimeType &&
        value == other.value &&
        const MapEquality<String, String?>()
            .equals(parameters, other.parameters);
  }

  @override
    String toString() => _inner.toString();
}

extension ContentTypeX on ContentType {
  /// True if this is equal to [SwaggerContentType.multipart].
  bool get isMultiPart => SwaggerContentType.multipart == this;

  /// True if this is equal to [SwaggerContentType.formUrlEncoded].
  bool get isFormUrlEncoded => SwaggerContentType.formUrlEncoded == this;

  /// True if this is equal to [SwaggerContentType.ndJson].
  bool get isNdJson => SwaggerContentType.ndJson == this;
}
