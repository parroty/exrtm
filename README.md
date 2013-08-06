Exrtm [![Build Status](https://secure.travis-ci.org/parroty/exrtm.png?branch=master "Build Status")](http://travis-ci.org/parroty/exrtm)
============
An library for accessing remember the milk API implemented using Elixir.

Detail of the API is described in <a href="https://www.rememberthemilk.com/services/api/methods/" target="_blank">https://www.rememberthemilk.com/services/api/methods/</a>.

## Prerequisite

API key is required for remember the milk.

- <a href="https://www.rememberthemilk.com/services/api/keys.rtm" target="_blank">https://www.rememberthemilk.com/services/api/keys.rtm</a>

## Sample Script
sample.sh include sample API usage. It just calls sample.ex.

#### Clone the repository

```
$ git clone git://github.com/parroty/exrtm.git
```

#### Set environment variable for the script

```
$ export RTM_API_KEY="your api key"
$ export RTM_SHARED_SECRET="your shared secret"
```

#### Run script

```
$ ./sample.sh
Access to the following url using browser to authenticate this script, and then press enter to proceed.
http://www.rememberthemilk.com/services/auth/xxxxxx

token = xxxxx

----operate_lists----
<Lists>
Inbox, Personal, Study, Work, Sent, All Tasks
<Inbox>
Exrtm.List[id: "xxxxxx", name: "Inbox", deleted: "0", locked: "1", archived: "0", position: "-1",
smart: "0", sort_order: "0"]

----operate_tasks----
<Tasks>
test2, completed task 2, RTMAPITEST, test, completed task 1
```

## Usage
sample.ex and tests covers the usage examples.

## Notes
It's started for learning Elixir, and only some part of the API is implemented at the moment.

Referenced the followings for implementing the library.
- <a href="https://github.com/mootoh/rtmilk" target="_blank">https://github.com/mootoh/rtmilk</a>
- <a href="https://gist.github.com/sasa1977/5967224" target="_blank">https://gist.github.com/sasa1977/5967224</a>
