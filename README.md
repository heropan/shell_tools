# shell_tools

## query transaction
By default, ip and port is 127.0.0.1:22604

Query hash
```shell
$ ./tx.sh c89b4d2cf1caec7e3f42ad19ae3f06961739f99d179cab24cdda788f8b4465a6
```

Query reverse hash
```
$ ./tx.sh c89b4d2cf1caec7e3f42ad19ae3f06961739f99d179cab24cdda788f8b4465a6 -r
```

Of course, you can specify ip and port with --ip=<address> and --port=<port>
```$xslt
$ ./tx.sh --ip=192.168.1.1 c89b4d2cf1caec7e3f42ad19ae3f06961739f99d179cab24cdda788f8b4465a6 --port=8000
```

For more detail, use --help
```$xslt
$ ./tx.sh --help
```

Query mempool
```
$ ./mempool.sh
```

Enjoy!
