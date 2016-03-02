# Message pipes

Message pipes are the primary communication mechanism between Mojo programs. A
*message pipe* is a point-to-point (with each side being called a message pipe
*endpoint*), bidirectional message passing mechanism, where messages may contain
both data and Mojo handles.

It's important to understand that a message pipe is a "transport": it provides a
way for data and handles to be sent between Mojo programs. The system is unaware
of the meaning of the data or of the handles (other than their intrinsic
properties).

That said, Mojo provides a *standard* way of communicating over message pipes,
namely via a standardized protocol together with [Mojom IDL](mojom.md) files.

## Messages

A *message* consists of two things:
* a finite sequence of bytes, and
* a finite sequence of Mojo handles.

Both of these are determined when the message is sent (or *written*). Messages
are *framed* in the sense that they are "atomic" units: they are sent and
received (or *read*) as entire units, not just by Mojo programs themselves but
by the system, which is aware of and enforces the message boundaries.

(Note on terminology: We'll use "send" and "write" interchangeably, and
similarly for "receive" and "read". "Write" and "read" correspond more closely
to the names usually given to the basic Mojo operations, e.g.,
`MojoWriteMessage()` and `MojoReadMessage()`.

## Asynchronous operation and queueing

Message pipes are *asynchronous* in the sense that sent messages do not have
intrinsic response messages mediated/enforced by the system. (This is different
from saying that message write/read are asynchronous operations: these
operations are actually synchronous and complete "immediately". However, note
that reading a message is "nonblocking" in the sense that it will fail if a
message is not available to be read. Thus a message must be waited for, and the
combined wait-then-read may form an asynchronous pattern.)

To allow message writes to complete immediately, messages are queued. Indeed,
one can understand a message pipe as a pair of queues, one in each direction.
Each endpoint has opposite notions of incoming and outgoing queues (recall that
message pipes have a pair of endpoints).

Writing a message to an endpoint then simply entails enqueueing that message on
that endpoint's outgoing queue (which is the *peer* endpoint's incoming queue).
Reading a message from an endpoint is just dequeueing a message from that
endpoint's incoming queue (which is the peer endpoint's outgoing queue).

Queueing is unlimited. Why? The problem is that limiting queueing exposes Mojo
programs to complex deadlock problems:
* One way of limiting queue sizes is to block the sender if the queue is "full".
  However, the receiver may not be able or willing to consume messages until the
  sender does something else (and this is often the case in asynchronous
  programming). For example, perhaps the putative "receiver" does not yet even
  have a handle to the endpoint yet, and that handle is sent in a message (over
  some other message pipe).
* Another way would be to have the write fail if the queue is full. Then the
  sender would want to additionally queue on its side. The thread would continue
  running and, e.g., run its message loop. However, sender-side queueing
  basically makes it impossible for the sender to transfer that endpoint
  (handle), at least until the sender-side queue is cleared. However, the
  receiver may not be able/willing to proceed until the sender has transferred
  the aforementioned endpoint.

Thus we allow unlimited queueing. (**TODO(vtl)**: Probably we'll eventually
allow "hard" queue limits to be set for the purposes of preventing
denial-of-service. However, the response to overruns will be hard failures, in
the sense that the message pipe may be destroyed, rather than soft,
"recoverable" failures -- since those expose deadlock issues.) It is then up to
Mojo programs to implement flow control in some way. (**TODO(vtl)**: Write more
about this in the context of Mojom.)

## "Synchronous" operation

**TODO(vtl)**
