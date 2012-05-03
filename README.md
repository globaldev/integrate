# Integrate

[![Build History][2]][1]

Integrate is a Ruby Integration Framework for building messaging systems
following the [Pipes and Filters][pipes-and-filters] architectural style.

Using Integrate you can define a workflow to divide a large processing task
into a sequence of smaller, independent processing steps that are connected by
channels.

## Concepts

Integrate follows [Enterprise Integration Patterns][eai-patterns].

### Messages

A Message is a generic container for data consisting of a payload and headers
that Message Producers and Message Consumers share over a Channel.

### Channels

Use a Channel to decouple Message Producers from Message Consumers.

### Routers

Use a Router to route a Message to a Channel based upon that Message's
payload or headers.

### Transformers

A Transformer allows loose-coupling of Message Producers and Message Consumers
in a Workflow. Transformers can be added between Message Producers and Message
Consumers so that those Components need not know what is expected by the next
Component in a workflow.

### Endpoints

Use an Endpoint to connect the various messaging Components to Channels.

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
[eai-patterns]: http://www.eaipatterns.com/ "Enterprise Integration Patterns"
[1]: http://travis-ci.org/robyoung26/integrate
[2]: https://secure.travis-ci.org/robyoung26/integrate.png?branch=master
