This is a Cisco test task implementation

# Requirements

- docker. tested with version 19.03.1, most likely will work with any version
- Valid api key for macaddress.io

# Usage

build image:

```
docker build -t macapi .
```

write macaddress api key to the .macaddress.key file
 
run docker container (passing api key file via read-only volume):
```
docker run -it -v $(pwd)/.macaddress.key:/etc/macaddress.key:ro --rm macapi [mac address]
```

alternatively you can pass api key as a second argument (less secure, other users will be able to see it via "ps ax"):
```
docker run -it --rm macapi [mac address] [api_key]
```

# Further improvements

- handling unknown companies
- handling network errors with retries
