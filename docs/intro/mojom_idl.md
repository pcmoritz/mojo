# Mojom IDL

The Mojom IDL (interface definition language) is primarily used to describe
*interfaces* to be used on [message pipes](message_pipes.md). Below, we describe
practical aspects of the Mojom language. Elsewhere, we describe the [Mojom
protocol](mojom_protocol.md). (**TODO(vtl)**: Also, serialization format?
Versioning?)

Text files written in Mojom IDL are given the `.mojom` extension by convention
(and are usually referred to as Mojom/mojom/`.mojom` files). The Mojom bindings
generator (**TODO(vtl)**: link?) may be used to generate code in a variety of
languages (including C++, Dart, and Go) from a Mojom file. Such generated code
"implements" the things specified in the Mojom file, in a way that's appropriate
for the particular target language.

## Interfaces

A Mojom *interface* is (typically) used to describe communication on a message
pipe. Typically, message pipes are created with a particular interface in mind,
with one endpoint designated the *client* (which sends *request* messages and
receives *response* messages) and the other designed that *server* or *impl*
(which receives request messages and sends response messages).

For example, take the following Mojom interface definition:
```mojom
interface MyInterface {
  Foo(int32 a, string b);
  Bar() => (bool x, uint32 y);
  Baz() => ();
};
```
This specifies a Mojom interface in which the client may send three types of
messages, namely `Foo`, `Bar`, and `Baz` (see the note below about names in
Mojom). The first does not have a response message defined, whereas the latter
two do. Whenever the server receives a `Bar` or `Baz` message, it *must*
(eventually) send a (single) corresponding response message.

The `Foo` request message contains two pieces of data: a signed (two's
complement) 32-bit integer called `a` and a Unicode string called `b`. On the
"wire", the message basically consists of metadata and a (serialized) *struct*
(see below) containing `a` and `b`.

The `Bar` request message contains no data, so on the wire it's just metadata
and an empty struct. It has a response message, containing a boolean value `x`
and an unsigned 32-bit integer `y`, which on the wire consists of metadata and a
struct with `x` and `y`. Each time the server receives a `Bar` message, it is
supposed to (eventually) respond by sending the response message. (Note: The
client may include as part of the request message's metadata an identifier for
the request; the response's metadata will then include this identifier, allowing
it to match responses to requests.)

The `Baz` request message also contains no data. It requires a response, also
containing no data. Note that even though the response has no data, a response
message must nonetheless be sent, functioning as an "ack". (Thus this is
different from not having a response, as was the case for `Foo`.)

### Names in Mojom

Names in Mojom are not important. Except in affecting compatibility at level of
source code (when generating bindings), names in a Mojom file may be changed
arbitrarily without any effect on the "meaning" of the Mojom file (subject to
basic language requirements, e.g., avoiding collisions with keywords and other
names). E.g., the following is completely equivalent to the interface discussed
above:
```mojom
interface Something {
  One(int32 an_integer, string a_string);
  Two() => (bool a_boolean, uint32 an_unsigned);
  Three() => ();
};
```
The `Something` interface is compatible at a binary level with `MyInterface`. A
client using the `Something` interface may communicate with a server
implementing the `MyInterface` with no issues, and vice versa.

The reason for this is that elements (messages, parameters, struct members,
etc.) are actually identified by *ordinal* value. They may be specified
explicitly (using `@123` notation; see below). If they are not specified
explicitly, they are automatically assigned. (The ordinal values for each
interface/struct/etc. must assign distinct values for each item, in a
consecutive range starting at 0.)

Explicitly assigning ordinals allows Mojom files to be rearranged "physically"
without changing their meaning. E.g., perhaps one would write:
```mojom
interface MyInterface {
  Bar@1() => (bool x@0, uint32 y@1);
  Baz@2() => ();

  // Please don't use this in new code!
  FooDeprecated@0(int32 a@0, string b@1);
};
```

Ordinals also tie into the versioning scheme (**TODO(vtl)**: link?), which
allows Mojom files to be evolved in a backwards-compatible way. We will not
discuss this matter further here.

**TODO(vtl)**: Maybe mention exceptions to this in attributes (e.g.,
`ServiceName`).


**TODO(vtl)**: Write/(re)organize the sections below.

## Structs

## Modules

## Data types

### Primitive types

### Enums

### Strings

### Nullability

### Structs

### Arrays

### Maps

### Unions

### Handle values

### Interface values

### Interface requests

## Consts

## Annotations

## Pipelining
