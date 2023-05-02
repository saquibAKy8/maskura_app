import 'package:maskura_app/consts/consts.dart';

class FirestoreServices {
  static getUser(uid){
    return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();
  }

  static getProducts(category){
    return firestore.collection(productsCollection).where('p_category', isEqualTo: category).snapshots();
  }

  static getSubCategoryProducts(title){
    return firestore.collection(productsCollection).where('p_subcategory', isEqualTo: title).snapshots();
  }

  static getCart(uid){
    return firestore.collection(cartCollection).where('added_by', isEqualTo: uid).snapshots();
  }

  static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getChatMessages(docId){
    return firestore.collection(chatCollection).doc(docId).collection(messageCollection).orderBy('created_on', descending: false).snapshots();
  }

  static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
  }

  //static getAddress(){
  //  return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
  //}

  static getAllMessages(){
    return firestore.collection(chatCollection).where('fromId',isEqualTo: currentUser!.uid).snapshots();
  }

  static getWishlist(){
    return firestore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).snapshots();
  }

  static getCount() async{
    var ac = await Future.wait([
      firestore.collection(cartCollection).where('added_by', isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
    ]);
    return ac;
  }

  static allProducts(){
    return firestore.collection(productsCollection).snapshots();
  }

  static getFeaturedProducts(){
    return firestore.collection(productsCollection).where('p_featured', isEqualTo: true).snapshots();
  }

  static searchProducts(title){
    return firestore.collection(productsCollection).get();
  }
}