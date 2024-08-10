A server app built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).

This sample code handles HTTP GET requests to `/` and `/echo/<message>`

# Running the sample

## Running with the Dart SDK

run the first node
```
$ dart bin/server.dart --obstructionum-directorium example --producentis 04005c510329ca3d1d08fc1ce0344bb80af9aa837943f846d17fb0c49b517bafbcdab77aee9e0eb9e7c7561951e369bb8ed67038a3b149ef9622db7da1ee613d191e4c01f35de11f2b03cd713a68c1b63bfdeedc3487c1aa74b7fa02568d463c58218dd52753e563f6022e9697a4451786eab83b2d2fd797cdaf5b9aeca1d4526053176668 --incipio-ex 01137e78de5513e580bd068841c1499782aee52ea227405672310f655748f34ae306542bf3146f529c855694a70a182ce492051031f7b8008f0857bc08f4908eb488 --novus-catena
Server listening on port 8080
```
to produce blocks you need 2 nodes run the second node with
```
dart bin/server.dart --obstructionum-directorium abla --producentis 04013e14f9e16d0650ca8b2347804f5a6c7efb916aaf7be96d156347c32fc6611c206a62013873adb913e47d7480866be254e4989e5f87368110f91c93f5c571e41d5001367953bfe9978bd21b0a9ca4490f67f38c39cf231420955d6f503faad7892568196cdce1b3ff473dc20f26c72891ea65b4fef54e54f224742296ac6d81b17580d7 --rpc-portus 8081 --pervideas-portus 1224 --tabernus-nodi 127.0.0.1:8008 --sync-novus
```

## Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker build . -t myserver
$ docker run -it -p 8080:8080 myserver
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080
Hello, World!
$ curl http://0.0.0.0:8080/echo/I_love_Dart
I_love_Dart
```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:04.620417  0:00:00.000158 GET     [200] /
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /echo/I_love_Dart
```
