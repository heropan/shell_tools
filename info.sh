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

# Function
# 1. height:	block height
# 2. block:		block details
# 3. tx:        the information of transaction
# 4. txpool:    transaction pool
# 5. balance:   the balance of the address
# 6. utxo:      the utxo of the address

# set the node of query
mode="height"
register_option "--mode=<function name>" do_mode "function name"
do_mode() {
	mode=$1
}

# Get parameter
# 1. Height
hei=0
register_option "--hei=<block height>" do_hei "block height"
do_hei() {
	hei=$1
}

# 2. Hash
hash=""
register_option "--hash=<hash id>" do_hash "hash id"
do_hash() {
	hash=$1
}

# 3. Address
add=""
register_option "--add=<address>" do_add "address"
do_add() {
	add=$1
}

# 4. Net
net="rt"
register_option "--net=<domain name>" do_net "domain name"
do_net() {
	net=$1
}

# 5. Node
node="ela"
register_option "--node=<node name>" do_node "node name"
do_node() {
	node=$1
}


extract_parameters $@

# Parse the port according to the environment
if [ $node = "ela" ]
then
	if [ $net = "rt" ]
	then
		restport=22334
		rpcport=22336
	elif [ $net = "tn" ]
	then
		restport=21334
		rpcport=21336
	else
		restport=20334
		rpcport=20336
	fi
elif [ $node = "did" ]
then
	if [ $net = "rt" ]
	then
		restport=22604
		rpcport=22606
	elif [ $net = "tn" ]
	then
		restport=21604
		rpcport=21606
	else
		restport=20604
		rpcport=20606
	fi
elif [ $node = "did" ]
then
	if [ $net = "rt" ]
	then
		restport=22604
		rpcport=22606
	elif [ $net = "tn" ]
	then
		restport=21604
		rpcport=21606
	else
		restport=20604
		rpcport=20606
	fi	
elif [ $node = "token" ]
then
	if [ $net = "rt" ]
	then
		restport=22614
		rpcport=22616
	elif [ $net = "tn" ]
	then
		restport=21614
		rpcport=21616
	else
		restport=20614
		rpcport=20616
	fi	
elif [ $node = "arbiter" ]
then
	if [ $net = "rt" ]
	then
		restport=22534
		rpcport=22536
	elif [ $net = "tn" ]
	then
		restport=21534
		rpcport=21536
	else
		restport=20534
		rpcport=20536
	fi
fi

# The mainnet node does not run the did, token node, and uses the domain name to access the node.
url="localhost"
if [ $net = "main" ]
then
	if [ $node = "did" ]
	then
		url="did-mainnet-001.elastos.org"
	elif [ $node = "token" ]
	then
		url="did-mainnet-001.elastos.org"
	fi
fi

# Function Set
get_block_height() {
	# get block height
	curl http://${url}:${restport}/api/v1/block/height
}

get_block_details() {
	# get block details of height
	curl http://${url}:${restport}/api/v1/block/details/height/$hei
}

get_block_data() {
	# get block details of height
	curl --request POST --url http://${url}:${rpcport} --header 'Content-Type: application/json' --header 'cache-control: no-cache' --data '{  "method": "getblock","params": {"blockhash": "${hash}", "verbosity": 0}}'
}

get_tran_info() {
	# get transaction info
	curl http://${url}:${restport}/api/v1/transaction/$hash
}

get_tranpool() {
	# get transaction pool
	curl http://${url}:${restport}/api/v1/transactionpool
}

get_balance() {
	# get transaction pool
	curl http://${url}:${restport}/api/v1/asset/balances/$add
}

get_utxos() {
	# get transaction pool
	curl http://${url}:${restport}/api/v1/asset/utxos/$add
}

# Main Function
if [ $mode = "height" ]
then
	echo "get block height of [$net]"
	get_block_height
elif [ $mode = "block" ]
then
	echo "get block details of height[$hei] on net[$net]"
	get_block_details
elif [ $mode = "blockdata" ]
then
	echo "get rawblock of height[$hei] on net[$net]"
	get_block_data
elif [ $mode = "tx" ]
then
	echo "get transaction info of txid[$hash]"
	get_tran_info
elif [ $mode = "txpool" ]
then
	echo "get transaction pool of net[$net]"
	get_tranpool
elif [ $mode = "balance" ]
then
	echo "get balance of address[$add]"
	get_balance
elif [ $mode = "utxo" ]
then
	echo "get transaction pool of net[$net]"
	get_utxos
fi
