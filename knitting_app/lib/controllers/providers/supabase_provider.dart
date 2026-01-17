import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> posts = [];

  // AUTH FONKSİYONLARI

  Future<bool> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      final Session? session = res.session;
      final User? user = res.user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final Session? session = res.session;
      final User? user = res.user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateUser({
    required String email,
    required String password,
  }) async {
    final UserResponse res = await supabase.auth.updateUser(
      UserAttributes(email: email, password: password),
    );
  }

  Future<void> signOutUser() async {
    await supabase.auth.signOut();
  }

  Future<void> listen() async {
    final authSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        print('signedIn');
      }
    });
  }

  // STORAGE FONKSİYONLARI

  String imageUrl = '';

  Future<void> uploadPhoto({required File selectedImage}) async {
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}';

    await supabase.storage
        .from('posts-images')
        .upload(
          fileName,
          selectedImage,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
    imageUrl = supabase.storage.from('posts-images').getPublicUrl(fileName);
  }

  // DATABASE - POSTS FONKSİYONLARI

  Future<void> readPosts() async {
    final data = await supabase.from('posts').select();
    posts = List<Map<String, dynamic>>.from(data);
    notifyListeners();
  }

  Future<void> insert({required String header, required String content}) async {
    await supabase.from('posts').insert({
      'header': header,
      'content': content,
      'image_url': imageUrl,
    });
  }

  Future<void> update({required String header, required String content}) async {
    await supabase
        .from('posts')
        .update({'header': header, 'content': content})
        .eq('header', header);
  }

  Future<void> delete({required String header}) async {
    await supabase.from('posts').delete().eq('column', header);
  }

  // DATABASE - PROFİL FONKSİYONLARI
  
  /*
  Future<void> fetchProfile() async {
    final data = await supabase
        .from('profiles')
        .select()
        .eq('id', supabase.auth.currentUser.id);
  }
  */
}
