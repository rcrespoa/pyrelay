from events import NewUserCreated, UserDeleted
from pyrelay import publish
import handlers  # imported for initializing the channels & handlers

if __name__ == "__main__":
    event1 = NewUserCreated(user_id="1")
    event2 = NewUserCreated(user_id="2")
    event3 = NewUserCreated(user_id="3")
    event4 = UserDeleted(user_id="1")
    publish(event1, "user_updates")
    publish(event2, "user_updates")
    publish(event3, "user_updates")
    publish(event4, "user_updates")
