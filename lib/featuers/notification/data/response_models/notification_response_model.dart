// @JsonSerializable()
// class NotificationResponseModel {
//   @JsonKey(name: "message")
//   String? message;
//   @JsonKey(name: "metadata")
//   Metadata? metadata;
//   @JsonKey(name: "notifications")
//   List<dynamic>? notifications;
//
//   NotificationResponseModel({
//     this.message,
//     this.metadata,
//     this.notifications,
//   });
//
//   factory NotificationResponseModel.fromJson(Map<String, dynamic> json) => _$NotificationResponseModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$NotificationResponseModelToJson(this);
// }
//
// @JsonSerializable()
// class Metadata {
//   @JsonKey(name: "currentPage")
//   int? currentPage;
//   @JsonKey(name: "totalPages")
//   int? totalPages;
//   @JsonKey(name: "limit")
//   int? limit;
//   @JsonKey(name: "totalItems")
//   int? totalItems;
//   @JsonKey(name: "unreadCount")
//   int? unreadCount;
//
//   Metadata({
//     this.currentPage,
//     this.totalPages,
//     this.limit,
//     this.totalItems,
//     this.unreadCount,
//   });
//
//   factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);
//
//   Map<String, dynamic> toJson() => _$MetadataToJson(this);
// }
