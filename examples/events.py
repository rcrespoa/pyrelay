from dataclasses import dataclass
from pysub import Event


@dataclass(frozen=True)
class NewUserCreated(Event):
    user_id: str


@dataclass(frozen=True)
class UserDeleted(Event):
    user_id: str
