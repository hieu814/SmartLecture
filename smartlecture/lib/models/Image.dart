class Image {
  String _source;
  Image(this._source);
  String get txt => _source;

  set txt(String txt) {
    _source = txt;
  }
}
