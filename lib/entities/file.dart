class FileData{
  int id;
  String title;
  String part;
  String fileName;
  bool isLiked;

  FileData(int id, String title, String part, String fileName, bool isLiked){
    this.id = id;
    this.title = title;
    this.part = part;
    this.fileName = fileName;
    this.isLiked = isLiked;
  }
}