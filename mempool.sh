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

extract_parameters $@

CMD="curl http://$IP:$PORT/api/v1/transactionpool"
echo "$CMD"
run $CMD

echo ""

