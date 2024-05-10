class BreedImage {
  final List<String>? message;
  final String? status;

  BreedImage({
    this.message,
    this.status,
  });

  BreedImage.fromJson(Map<String, dynamic> json)
      : message = List<String>.from(json['message']),
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'message': message,
        'status': status,
      };
}
