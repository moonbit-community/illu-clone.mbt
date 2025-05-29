# illusory0x0/clone

The purpose of this repository is to be used in a multi-threaded environment with a native backend. Even though it is an immutable container, the memory management will still modify the rc, causing a race condition.

So there is no trait to track the mutuality of the container.

