# Relay

Micro framework for pub/sub decoupling with concurrency support.

\
&nbsp;

\
&nbsp;

## Getting Started

### 0. Install

```bash
pip install msg-relay
```

### 1. Define Event types and their properties

```python
from relay import Event

@dataclass(frozen=True)
class NewUserCreated(Event):
    user_id: str


@dataclass(frozen=True)
class UserDeleted(Event):
    user_id: str
```

### 2. Define Subscribers/Handlers and mapping to event types

```python
from relay import Subscriber

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
```

### 3. Define Channels

```python
from relay import Channel

user_updates_channel = Channel(
    identifier="user_updates",
    supported_events=[NewUserCreated, UserDeleted],
    executor=ProcessingExecutor.MULTIPLE_THREADS
)

# register subscribers
user_updates_channel.subscribe(EmailHandler())
user_updates_channel.subscribe(UserCacheHandler())
```

### 4. Publish events

```python
from relay import publish

# generate events
event2 = NewUserCreated(user_id="21")
event = UserDeleted(user_id="21")

# publish events with channel
user_updates_channel.publish(event)

# or publish events via msgrelay.publish
publish(event2, channel_id="user_updates")
```
