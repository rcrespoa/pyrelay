from relay import Channel, ProcessingExecutor
from events import NewUserCreated, UserDeleted

user_updates_channel = Channel(
    identifier="user_updates",
    supported_events=[NewUserCreated, UserDeleted],
    executor=ProcessingExecutor.MULTIPLE_THREADS,  # [MULTIPLE_PROCESSES, SAME_THREAD, MULTIPLE_THREADS]
    workers=4,  # Set to None for optimized selection
)
