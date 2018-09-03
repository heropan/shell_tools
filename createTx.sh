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

FROM=""
register_option "--from=<address>" do_ip "Transfer  address"
do_ip() {
	FROM=$1
}

AMOUNT=10
register_option "--amount=<value>" do_set_amount "Transfer asset amount."
do_set_amount() {
	AMOUNT=$1
}

FEE=0.000001
register_option "--fee=<value>" do_set_fee "Transaction fee."
do_set_fee() {
	FEE=$1
}

PASSWD=1
register_option "--pwd=<password>" do_set_passwd "Password."
do_set_passwd() {
	PASSWD=$1
}

extract_parameters $@

if [ "X$FROM" = "X" ]; then
	FROM_ARG=
else
	FROM_ARG="--from $FROM"
fi

./ela-cli wallet -t create $FROM_ARG --to $PARAMETERS --amount $AMOUNT --fee $FEE
./ela-cli wallet -t sign --file to_be_signed.txn -p $PASSWD
./ela-cli wallet -t send --file ready_to_send.txn
