class BaseResponse<T> {
  final bool success;
  final String message;
  final T? data;

  BaseResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return BaseResponse(
      success: json["success"] ?? true,
      message: json["message"] ?? "",
      data: fromJsonT != null && json["data"] != null
          ? fromJsonT(json["data"])
          : null,
    );
  }
}