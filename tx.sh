#!/bin/sh
#
# Copyright (C) 2010 Mystic Tree Games
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

. `dirname $0`/utils.sh

IP=127.0.0.1
register_option "--ip=<address>" do_ip "ip address"
do_ip() {
	IP=$1
}

PORT=22604
register_option "--port=<port>" do_port "port"
do_port() {
	PORT=$1
}

REVERSE_HASH=no
register_option "-r" do_reverse_hash "reverse hash"
do_reverse_hash() {
	REVERSE_HASH=yes
}

extract_parameters $@

PROGRAM_PARAMETERS=hash

TX_HASH=$PARAMETERS

err() {
	echo "ERROR: $1"
	exit 1
}

if [ -z "$TX_HASH" ]; then
	err "Please input tx hash"
fi

HASH_LEN=${#TX_HASH}
if [ $(($HASH_LEN % 2)) != 0 ]; then
	err "'$TX_HASH' length is not even"
fi

reverse_hex_string() {
	reversed_string=
	for ((i = 0; i < $HASH_LEN; i += 2))
	do
		substr=${TX_HASH:$i:2}
		reversed_string=$substr$reversed_string
	done
	TX_HASH=$reversed_string
	echo "reversed_string=$reversed_string"
}

if [ "yes" = "$REVERSE_HASH" ]; then
	echo "reverse hash = $TX_HASH"
	reverse_hex_string $TX_HASH
fi

CMD="curl http://$IP:$PORT/api/v1/transaction/$TX_HASH"
echo "$CMD"
run $CMD

echo ""

