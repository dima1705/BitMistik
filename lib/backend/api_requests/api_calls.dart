import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start OpenAPIAI Group Code

class OpenAPIAIGroup {
  static String getBaseUrl() =>
      'https://us-central1-bitmystic-1.cloudfunctions.net';
  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=utf-8',
  };
  static SendPromptCall sendPromptCall = SendPromptCall();
  static GetTypeOfFortuneTellingCall getTypeOfFortuneTellingCall =
      GetTypeOfFortuneTellingCall();
  static GetRandomCardListCall getRandomCardListCall = GetRandomCardListCall();
  static GetTarrotAdviceCall getTarrotAdviceCall = GetTarrotAdviceCall();
}

class SendPromptCall {
  Future<ApiCallResponse> call({
    dynamic? userQuestionnaireJson,
    String? question = '',
    dynamic? cardInfoJson,
    String? spreadType = '',
  }) async {
    final baseUrl = OpenAPIAIGroup.getBaseUrl();

    final userQuestionnaire = _serializeJson(userQuestionnaireJson);
    final cardInfo = _serializeJson(cardInfoJson);
    final ffApiRequestBody = '''
{
  "question": "${escapeStringForJson(question)}",
  "cardInfo": ${cardInfo},
  "questionnaire": ${userQuestionnaire},
  "spreadType": "${escapeStringForJson(spreadType)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Send Prompt',
      apiUrl: '${baseUrl}/getTarotAnswer',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? responseAI(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.reply''',
      ));
  String? resp(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.choices[:].message.content''',
      ));
}

class GetTypeOfFortuneTellingCall {
  Future<ApiCallResponse> call({
    String? question = '',
  }) async {
    final baseUrl = OpenAPIAIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "question": "${escapeStringForJson(question)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Get Type Of Fortune Telling',
      apiUrl: '${baseUrl}/getTarotSpreadNumber',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? responseAIType(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.type''',
      ));
}

class GetRandomCardListCall {
  Future<ApiCallResponse> call({
    String? question = '',
  }) async {
    final baseUrl = OpenAPIAIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "question": "${escapeStringForJson(question)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Get Random Card List',
      apiUrl: '${baseUrl}/getRandomTarotCards',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? randomCards(dynamic response) => getJsonField(
        response,
        r'''$.cards''',
        true,
      ) as List?;
  int? maxcards(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.max_cards''',
      ));
  String? spreadType(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.spread_type''',
      ));
  String? error(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class GetTarrotAdviceCall {
  Future<ApiCallResponse> call({
    String? card = '',
  }) async {
    final baseUrl = OpenAPIAIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "card": "${escapeStringForJson(card)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Get Tarrot Advice',
      apiUrl: '${baseUrl}/tarotAdvice',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? massageAdvice(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

/// End OpenAPIAI Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
