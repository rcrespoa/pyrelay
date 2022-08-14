from dataclasses import dataclass
import time
from relay import Subscriber, Channel, Event, ProcessingExecutor, publish


# Events
@dataclass(frozen=True)
class NewUserCreated(Event):
    user_id: str


@dataclass(frozen=True)
class UserDeleted(Event):
    user_id: str


# Subscribers
class UserCacheHandler(Subscriber):
    def on_new_user(event: NewUserCreated):
        print(f"Publish user to Cache: {event.user_id}")

    def on_user_deleted(event: UserDeleted):
        print(f"Delete user from Cache: {event.user_id}")

    handlers = {
        NewUserCreated: on_new_user,
        UserDeleted: on_user_deleted,
    }


class EmailHandler(Subscriber):
    def on_new_user(event: NewUserCreated):
        time.sleep(10)
        print(f"Sending welcome email to: {event.user_id}")

    handlers = {
        NewUserCreated: on_new_user,
    }


class SMSHandler(Subscriber):
    @property
    def handlers(self):
        return {
            NewUserCreated: SMSHandler.on_new_user,
        }

    def on_new_user(event: NewUserCreated):
        print(f"Sending SMS to: {event.user_id}")


sub1 = UserCacheHandler()
sub2 = EmailHandler()
sub3 = SMSHandler()
sub4 = SMSHandler()
sub5 = SMSHandler()

if __name__ == "__main__":

    # Channel
    user_updates = Channel(
        identifier="user_updates",
        supported_events=[NewUserCreated, UserDeleted],
        executor=ProcessingExecutor.MULTIPLE_THREADS,
        workers=None,
    )

    user_updates2 = Channel(
        identifier="user_updates2",
        supported_events=[NewUserCreated, UserDeleted],
        executor=ProcessingExecutor.MULTIPLE_PROCESSES,
    )
    user_updates3 = Channel(
        identifier="user_updates3",
        supported_events=[NewUserCreated, UserDeleted],
        executor=ProcessingExecutor.MULTIPLE_PROCESSES,
    )

    user_updates.subscribe(sub1)
    user_updates.subscribe(sub3)
    user_updates.subscribe(sub4)
    user_updates.subscribe(sub5)
    user_updates.subscribe(sub2)

    user_updates2.subscribe(sub1)
    user_updates2.subscribe(sub3)
    user_updates2.subscribe(sub4)
    user_updates2.subscribe(sub5)
    user_updates2.subscribe(sub2)

    user_updates3.subscribe(sub1)
    user_updates3.subscribe(sub3)
    user_updates3.subscribe(sub4)
    user_updates3.subscribe(sub5)
    user_updates3.subscribe(sub2)

    event2 = NewUserCreated(user_id="21")
    event = UserDeleted(user_id="21")
    # user_updates.publish(event2)
    # user_updates.publish(event)
    # user_updates3.publish(event2)
    # user_updates3.publish(event)
    # user_updates2.publish(event2)
    # user_updates2.publish(event)
    print(123)

    publish(event, channel_id="user_updates")
    publish(event2, channel_id="user_updates")
