from relay import Subscriber
from events import NewUserCreated, UserDeleted
import time
from channels import user_updates_channel


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


user_updates_channel.subscribe(UserCacheHandler())
user_updates_channel.subscribe(EmailHandler())
