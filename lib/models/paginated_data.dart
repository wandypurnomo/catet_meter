class PaginatedData<T> {
  String currentPage;
  String firstPage;
  String lastPage;
  String total;
  bool hasMorePages;
  List<T> items;
  bool isEmpty;

  PaginatedData({
    this.currentPage,
    this.firstPage,
    this.lastPage,
    this.total,
    this.hasMorePages,
    this.items,
    this.isEmpty,
  });
}