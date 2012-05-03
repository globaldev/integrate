# Integrate

[![Build History][2]][1]

Integrate is a Ruby Integration Framework for building messaging systems
following the [Pipes and Filters][pipes-and-filters] architectural style.

Using Integrate you can define a workflow to divide a large processing task
into a sequence of smaller, independent processing steps that are connected by
channels.

## Concepts

### Messages

A Message is a generic container for data consisting of a payload and
headers. The payload can be of any object, headers hold commonly required
information (e.g. id and timestamp).

### Channels

A Channel represents the "pipe" of a [Pipes and Filters][pipes-and-filters]
architecture. Producers send Messages to a Channel, and Consumers receive
Messages from a Channel. A Channel decouples the messaging components.

### Endpoints

An Endpoint represents the "filter" of a
[Pipes and Filters][pipes-and-filters] architecture. It's role is to connect
application code to the messaging framework and to do so in a non-invasive
manner.

#### Transformers

A Transformer allows loose-coupling of Endpoints. Transformers can be added
between Endpoints so that those Endpoints need not know what is expected by
the next Endpoints in a workflow. A Transformer is responsible for converting
a Message's content or structure and returning the modified Message.

#### Filters

A Filter determines whether a Message should be passed to an output channel by
checking for particular payload content, a property value, or the presence of
a header.

#### Routers

A Router decides what Channel should receive a Message next based upon the
Message's payload or headers.

#### Splitters

A Splitter accepts a Message and then splits it into multiple Messages. A
common use case is dividing a "composite" payload object into a group of
Messages containing the sub-divided payloads.

#### Aggregators

An Aggregator is the opposite or a Splitter. It receives multiple Messages and
combines them into a single Message.

#### Service Activators

A Service Activator connects an external service instance to the messaging
system.

#### Channel Adapters

A Channel Adapter connects a Channel to an external system or transport. They
may be either inbound or outbound.

## Licence

(The MIT License)

Copyright (c) 2012 Global Personals, Ltd.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

[pipes-and-filters]: http://www.eaipatterns.com/PipesAndFilters.html "Pipes and Filters"
[1]: http://travis-ci.org/robyoung26/integrate
[2]: https://secure.travis-ci.org/robyoung26/integrate.png?branch=master
