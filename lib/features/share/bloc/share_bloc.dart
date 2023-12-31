import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passaround/data_structures/file_info.dart';
import 'package:passaround/features/share/bloc/share_data_access.dart';

import '../../../entities/item.dart';

part 'share_event.dart';
part 'share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  static const String retrieveError = "An error occurred while retrieving items.";
  static const String sendingError = "An error occurred while sending your item.";
  static const String downloadingError = "An error occurred while downloading your file.";
  static const String deletingError = "An error occurred while deleting your item.";
  static const String unknownError = "An unexpected error occurred. Please try again.";

  final ShareDataAccess _dataAccess;
  StreamSubscription<List<Item>>? _itemListener;

  ShareBloc(this._dataAccess) : super(const ShareState.initial()) {
    on<ShareLoadingStarted>(_onLoadingStarted);
    on<ShareTextSent>(_onTextSent);
    on<ShareImageSent>(_onImageSent);
    on<ShareFileSent>(_onFileSent);
    on<ShareDownloadRequested>(_onDownloadRequested);
    on<ShareSucceeded>(_onSucceeded);
    on<ShareFailed>(_onFailed);
    on<ShareReceived>(_onReceived);
    on<ShareDeleted>(_onDeleted);
    on<ShareRecoverFromError>(_onRecoverFromError);
  }

  void _init() {
    listenForNewItems();
  }

  void listenForNewItems() {
    _itemListener = _dataAccess.newItemsStream().listen((items) {
      add(ShareReceived(items));
    });
  }

  Future<void> _onLoadingStarted(ShareLoadingStarted event, Emitter<ShareState> emit) async {
    final ShareState newState = state.copyWith(value: ShareStateValue.loading);
    emit(newState);
    
    final List<Item>? items = await _dataAccess.getItems();
    final succeeded = items != null;
    succeeded ? add(ShareReceived(items)) : add(const ShareFailed(retrieveError));

    _init();
  }

  Future<void> _onTextSent(ShareTextSent event, Emitter<ShareState> emit) async {
    await _waitForIdleState();
    final ShareState newState = state.copyWith(value: ShareStateValue.sending);
    emit(newState);
    bool succeeded = await _dataAccess.writeTextItem(event.text);
    succeeded ? add(const ShareSucceeded()) : add(const ShareFailed(sendingError));
  }

  Future<void> _onImageSent(ShareImageSent event, Emitter<ShareState> emit) async {
    await _waitForIdleState();
    final ShareState newState = state.copyWith(value: ShareStateValue.sending);
    emit(newState);
    bool succeeded = await _dataAccess.writeImageItem(event.fileInfo);
    succeeded ? add(const ShareSucceeded()) : add(const ShareFailed(sendingError));
  }

  Future<void> _onFileSent(ShareFileSent event, Emitter<ShareState> emit) async {
    await _waitForIdleState();
    final ShareState newState = state.copyWith(value: ShareStateValue.sending);
    emit(newState);
    bool succeeded = await _dataAccess.writeFileItem(event.fileInfo);
    succeeded ? add(const ShareSucceeded()) : add(const ShareFailed(sendingError));
  }

  Future<void> _onDownloadRequested(ShareDownloadRequested event, Emitter<ShareState> emit) async {
    await _waitForIdleState();
    final ShareState newState = state.copyWith(value: ShareStateValue.downloading);
    emit(newState);
    bool succeeded = await _dataAccess.download(event.item);
    succeeded ? add(const ShareSucceeded()) : add(const ShareFailed(downloadingError));
  }

  Future<void> _onDeleted(ShareDeleted event, Emitter<ShareState> emit) async {
    await _waitForIdleState();
    final ShareState newState = state.copyWith(value: ShareStateValue.deleting);
    emit(newState);
    bool succeeded = await _dataAccess.deleteItem(event.item);
    succeeded ? add(const ShareSucceeded()) : add(const ShareFailed(deletingError));
  }
  
  void _onSucceeded(ShareSucceeded event, Emitter<ShareState> emit) {
    final ShareState newState = state.copyWith(value: ShareStateValue.idle, errorMessage: "");
    emit(newState);
  }

  void _onFailed(ShareFailed event, Emitter<ShareState> emit) {
    final ShareState newState = state.copyWith(
      value: ShareStateValue.error,
      errorMessage: event.errorMessage,
    );
    emit(newState);
  }

  void _onReceived(ShareReceived event, Emitter<ShareState> emit) {
    final List<Item> newData = event.items;
    final ShareState newState = state.copyWith(value: ShareStateValue.idle, data: newData);
    emit(newState);
  }

  void _onRecoverFromError(ShareRecoverFromError event, Emitter<ShareState> emit) {
    final ShareState newState = state.copyWith(value: ShareStateValue.idle, errorMessage: "");
    emit(newState);
  }

  Future<void> _waitForIdleState() async {
    while(state.value != ShareStateValue.idle) {
      await Future.delayed(const Duration(milliseconds: 5000));
    }
  }

  @override
  Future<void> close() {
    _itemListener?.cancel();
    return super.close();
  }
}

