# Youtube video

https://www.youtube.com/watch?v=yoHlTwuLWBI

In this video, I'll attempt to

- Deploy one EC2 instance on a public subnet.
- Deploy 100 EC2 instances on a private subnet.
- Host a web server on each EC2 instance.
- Each web server will return the current instance private ip address and will make a request to the next web server.

The end goal is to propogate a request from a public instance to the 100 private EC2 instances.
