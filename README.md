[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://github.com/JonnyWong16/plexpy
[hub]: https://hub.docker.com/r/linuxserver/plexpy/
[tautsite]: http://tautulli.com

The [LinuxServer.io][linuxserverurl] team and Scott Higgins bring you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!
* Note: I am utilizing almost all of their setup with a minor tweak to create this image. All props go to them, I'm just standing on the shoulders of giants.

## shiggins8/tautulli
[Tautulli][appurl] Is a Python-based Plex Usage tracker, that is currently in active development.

For a more detailed description, check out [this page][tautsite]. This software is still in Beta and looking for constructive feedback. If upgrading from PlexPy, make sure that you back up your database to prevent and loss of information related to potential bugs in the beta. 

## Usage

```
docker create \ 
  --name=tautulli \
  -v <path to data>:/config \
  -v <path to plexlogs>:/logs:ro \
  -e PGID=<gid> -e PUID=<uid>  \
  -e TZ=<timezone> \
  -p 8181:8181 \
  shiggins8/tautulli
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 8181` - Port for webui
* `-v /config` Containes plexpy config and database
* `-v /logs` Map this to Plex Media servers log directory - bonus points for mapping RO
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for setting timezone information, eg Europe/London

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it plexpy /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application
Access the webui at `<your-ip>:8181`, for more information check out [Plexpy][appurl].

## Info

* To monitor the logs of the container in realtime `docker logs -f tautulli`.
