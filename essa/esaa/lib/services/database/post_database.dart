import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/services/database/database.dart';

class PostDatabase {
  PostDatabase();

  static CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future<void> createPost(Map<String, dynamic> post) async {
    try {
      final result = await postsCollection.add(post);

      await updatePostDetails({"id": result.id});
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<void> updatePostDetails(Map<String, dynamic> values) async {
    try {
      await postsCollection.doc(values["id"]).update(values);
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<Post?> getPost(String postId) async {
    try {
      final result = await postsCollection.where("id", isEqualTo: postId).get();

      if (result.docs.isNotEmpty) {
        for (QueryDocumentSnapshot documentSnapshot in result.docs) {
          return Post.fromDocumentSnapshot(documentSnapshot);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return null;
    }
  }

  Stream<Post> getPostAsStream(String postId) {
    return postsCollection
        .where("id", isEqualTo: postId)
        .snapshots()
        .map((querySnapshot) {
      Post post = Post.empty();

      for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
        post = Post.fromDocumentSnapshot(snapshot);
      }
      return post;
    });
  }

  Stream<List<Post>> getPostsByQuery(Query query) {
    return query.snapshots().map((querySnapshot) {
      List<Post> posts = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        posts.add(Post.fromDocumentSnapshot(documentSnapshot));
      }

      return posts;
    });
  }

  Stream<List<Post>> getAvailablePosts() {
    return postsCollection
        .where("offerStatus", whereIn: ["pending", "assigned"])
        .snapshots()
        .map((querySnapshot) {
          List<Post> posts = [];
          for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
            posts.add(Post.fromDocumentSnapshot(documentSnapshot));
          }

          return posts;
        });
  }

  Future<bool> deletePost(String postId) async {
    try {
      await postsCollection.doc(postId).delete();
      return true;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return false;
    }
  }
}
