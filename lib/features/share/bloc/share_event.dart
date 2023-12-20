part of 'share_bloc.dart';

@immutable
abstract class ShareEvent {
  const ShareEvent();
}

class ShareLoadingStarted extends ShareEvent {
  const ShareLoadingStarted();
}

class ShareTextSent extends ShareEvent {
  final String text;

  const ShareTextSent(this.text);
}

class ShareImageSent extends ShareEvent {
  final FileInfo fileInfo;

  const ShareImageSent(this.fileInfo);
}

class ShareFileSent extends ShareEvent {
  final FileInfo fileInfo;

  const ShareFileSent(this.fileInfo);
}

class ShareDeleted extends ShareEvent {
  final Item item;
  
  const ShareDeleted(this.item);
}

class ShareDownloadRequested extends ShareEvent {
  final Item item;

  const ShareDownloadRequested(this.item);
}

class ShareSucceeded extends ShareEvent {
  const ShareSucceeded();
}

class ShareFailed extends ShareEvent {
  final String errorMessage;

  const ShareFailed(this.errorMessage);
}

class ShareReceived extends ShareEvent {
  final List<Item> items;

  const ShareReceived(this.items);
}

class ShareRecoverFromError extends ShareEvent {
  const ShareRecoverFromError();
}
