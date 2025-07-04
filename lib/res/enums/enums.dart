enum Type {
    ILLUSTRATION,
    PHOTO
}

final typeValues = EnumValues({
    "illustration": Type.ILLUSTRATION,
    "photo": Type.PHOTO
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}