class FilterClass {
  final String? id;
  final String? name;
  final String? subName;

  /// For Category
  final int? parentId;
  final String? urlTitle;

  const FilterClass({
    this.id,
    this.name,
    this.subName,
    this.parentId,
    this.urlTitle,
  });
}
