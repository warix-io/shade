import 'dart:io';
import 'dart:convert';

import 'package:shade/src/http/http.dart';

/// Middleware to used parse the request body to json.
///
/// Stores the Json into the response [State] with key `json`.
///
/// Not be parsed if request `mimeType` is not `application/json`, the request body is not valid json, and/or the request body is not `UTF-8`.
void JsonBodyParser(Request req, Response res, Step step) {
  if (req.headers.contentType.mimeType == ContentType.json.mimeType) {
    utf8.decoder
        .bind(req.data)
        .join()
        .then((content) => res.state["json"] = json.decode(content))
        .catchError((_) => null)
        .then((_) => step());
  } else {
    step();
  }
}