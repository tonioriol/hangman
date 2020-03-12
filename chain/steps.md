# How to chain script in a farm of docker containers

Bootstrap the containers and inject the scrip. Each in a different terminal tab/window
```shell script
docker run -it -v $(pwd)/chain.exs:/chain.exs --rm --name one --network elixir-net elixir bash
docker run -it -v $(pwd)/chain.exs:/chain.exs --rm --name two --network elixir-net elixir bash
docker run -it -v $(pwd)/chain.exs:/chain.exs --rm --name three --network elixir-net elixir bash
docker run -it -v $(pwd)/chain.exs:/chain.exs --rm --name four  --network elixir-net elixir bash
```

Here we started four containers, each with a different name, but on the same network `elixir-net` and injected the chain.exs in the root dir of the container

Inspect the docker network with `docker network inspect elixir-net`. Look for the key `Containers`. Here you will see the ip address of each:

```json
{
    "Containers": {
        "852d401f057ce49387cc0d3b5f5c51fb2ae41faf732884dcecd81869fe365f24": {
            "Name": "one",
            "EndpointID": "1fd4ee9d2ba224cf1d3405676be862be7ba317e666bc8ddf57fb453d95b53072",
            "MacAddress": "02:42:c0:a8:60:02",
            "IPv4Address": "192.168.96.2/20",
            "IPv6Address": ""
        },
        "8b4bce4880fc9dd24ff2280980825ffaab1c66fc8fc17f3afcef3fc13ba697b5": {
            "Name": "three",
            "EndpointID": "a6c8aa7e24101b6d7132eb752b297d368336473c5c34ae6eb7335580692cd2ac",
            "MacAddress": "02:42:c0:a8:60:04",
            "IPv4Address": "192.168.96.4/20",
            "IPv6Address": ""
        },
        "a6979d0cdf6d7cf3016e3877ed4909e53a32cce68a5acf687070c3645147656d": {
            "Name": "four",
            "EndpointID": "4d14e2a0832955ddc7e2d8c3f341a472cd047eb03001b8dc71ad79107771f5b3",
            "MacAddress": "02:42:c0:a8:60:05",
            "IPv4Address": "192.168.96.5/20",
            "IPv6Address": ""
        },
        "dbb7ce07c71fb5e7f1e594b0f4649a9623e8cd0256e10840a65fe9f32b8453e0": {
            "Name": "two",
            "EndpointID": "b54c03b1ad07558d0d0a0d20ebec42bdd0d7e31982b15be2bb96a9d1f36f2ca4",
            "MacAddress": "02:42:c0:a8:60:03",
            "IPv4Address": "192.168.96.3/20",
            "IPv6Address": ""
        }
    }
}

```

With that ip address star an iex session in each docker container:

```shell script
iex --name one@192.168.96.2 --cookie dough
iex --name two@192.168.96.3 --cookie dough
iex --name three@192.168.96.4 --cookie dough
iex --name four@192.168.96.5 --cookie dough
```

Then you can start the chain in each:

```shell script
# from node one
Chain.start_link :"two@192.168.96.3"

# from node two
Chain.start_link :"three@192.168.96.4"

# from node three
Chain.start_link :"four@192.168.96.5"

# from node four
Chain.start_link :"one@192.168.96.1"
```

Then you can send the message that will start the chain:

```shell script
# from node one
send :chainer, {:trigger, []}
```
