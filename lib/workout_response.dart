// To parse this JSON data, do
//
//     final workoutResponse = workoutResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class WorkoutResponse {
  WorkoutResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.usage,
    required this.choices,
  });

  final String id;
  final String object;
  final int created;
  final String model;
  final Usage usage;
  final List<Choice> choices;

  factory WorkoutResponse.fromJson(String str) =>
      WorkoutResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorkoutResponse.fromMap(Map<String, dynamic> json) => WorkoutResponse(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        model: json["model"],
        usage: Usage.fromMap(json["usage"]),
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "usage": usage.toMap(),
        "choices": List<dynamic>.from(choices.map((x) => x.toMap())),
      };
}

class Choice {
  Choice({
    required this.message,
    required this.finishReason,
    required this.index,
  });

  final Message message;
  final String finishReason;
  final int index;

  factory Choice.fromJson(String str) => Choice.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Choice.fromMap(Map<String, dynamic> json) => Choice(
        message: Message.fromMap(json["message"]),
        finishReason: json["finish_reason"],
        index: json["index"],
      );

  Map<String, dynamic> toMap() => {
        "message": message.toMap(),
        "finish_reason": finishReason,
        "index": index,
      };
}

class Message {
  Message({
    required this.role,
    required this.content,
  });

  final String role;
  final String content;

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        role: json["role"],
        content: json["content"],
      );

  Map<String, dynamic> toMap() => {
        "role": role,
        "content": content,
      };
}

class Usage {
  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  factory Usage.fromJson(String str) => Usage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usage.fromMap(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"],
        completionTokens: json["completion_tokens"],
        totalTokens: json["total_tokens"],
      );

  Map<String, dynamic> toMap() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
      };
}
