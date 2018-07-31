# shell_tools

## query mempool
By default, ip and port is 127.0.0.1:22604

It will automatically query hash and its reverse
```shell
$ ./mempool.sh --hash=c89b4d2cf1caec7e3f42ad19ae3f06961739f99d179cab24cdda788f8b4465a6
```

Of course, you can specify ip and port with --ip=<address> and --port=<port>
```$xslt
$ ./mempool.sh --ip=192.168.1.1 --port=8000 --hash=c89b4d2cf1caec7e3f42ad19ae3f06961739f99d179cab24cdda788f8b4465a6
```

For more detail, use --help
```$xslt
$ ./mempool.sh --help
```

Enjoy!
