class FeedPhotos {
// field name for firestore documents
  static const COLLECTION = 'feedPhotos';
  static const IMAGE_FOLDER =
      'feedPicsFolder'; // for the folder name and path
  //static const PROFILE_FOLDER = 'profilePictures';
  static const CAPTION = 'caption'; // title
  static const PRICE = 'price'; // memo
  static const CREATED_BY = 'createdBy';
  static const PHOTO_URL = 'photoURL';
  static const PHOTO_PATH = 'photoPath';
  static const UPDATED_AT = 'updatedAt';


  String docId; // firebase doc id
  String createdBy;
  String caption;// title
  String price; // memo
  String
      photoPath; // path to cloud store will be stored here, firebase storage, image file name
  String photoURL; // fire base storage; image URL for internet access
  DateTime updatedAt; // created or revised time


  FeedPhotos({
    // defult constructor
    this.docId,
    this.createdBy,
    this.caption,
    this.price,
    this.photoPath,
    this.photoURL,
    this.updatedAt,

  }); 
// conver dart object to firestore document
  Map<String, dynamic> serialized() {
    // transfer it to map data
    return <String, dynamic>{
      CAPTION: caption,
      CREATED_BY: createdBy,
      PRICE: price,
      PHOTO_PATH: photoPath,
      PHOTO_URL: photoURL,
      UPDATED_AT: updatedAt,

    };
  }

  //convert firestore doc to dart object
  static FeedPhotos deserialize(Map<String, dynamic> data, String docId) {
    return FeedPhotos(
      docId: docId,
      createdBy: data[FeedPhotos.CREATED_BY],
      caption: data[FeedPhotos.CAPTION],
      price: data[FeedPhotos.PRICE],
      photoPath: data[FeedPhotos.PHOTO_PATH],
      photoURL: data[FeedPhotos.PHOTO_URL],
      updatedAt: data[FeedPhotos.UPDATED_AT] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              data[FeedPhotos.UPDATED_AT].millisecondsSinceEpoch)
          : null,
    );
  }

  @override
  String toString() {
    return '$docId $price $createdBy $caption /n $photoURL'; // to print after sign on pressed from signIn screen class
  }
}
