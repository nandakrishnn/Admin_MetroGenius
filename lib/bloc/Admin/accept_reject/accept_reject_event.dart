part of 'accept_reject_bloc.dart';
@immutable
sealed class AcceptRejectEvent {}

final class Accepted extends AcceptRejectEvent{
  final DocumentSnapshot data;
  Accepted(this.data);
}
final class Rejected extends AcceptRejectEvent{
  final String id;
  Rejected(this.id);

}