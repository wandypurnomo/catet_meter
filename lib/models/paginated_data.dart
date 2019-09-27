class PaginatedData<T> {
  int currentPage;
  int firstPage;
  int lastPage;
  int total;
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