#!/usr/bin/expect -f
#set MODE [lindex $argv 0]
#set PWD [lindex $argv 1]   
set VALIDATOR_ADDRESS [lindex $argv 0]
set KEY_NAME [lindex $argv 1]
set DELEGATE_ADDRESS [lindex $argv 2]
set CHAIN_ID [lindex $argv 3]
set NODE_ADDRESS_PORT [lindex $argv 4]
set CURRENCY [lindex $argv 5]
set TRANSACTION_FEES [lindex $argv 6]
#set AMOUNT [lindex $argv 6]
set COMMAND ""
log_user 0

stty -echo
send_user "Enter Desmos keyring passphrase (just this time, please ignore next output messages since they'll be managed by the bot):\n"
expect_user -re "(.*)\n" 
set PWD $expect_out(1,string)
stty echo
#puts "Your pwd is $PWD\n" 
set AVAILABLE 12345
#spawn desmos tx distribution withdraw-rewards desmosvaloper1s7kph9sdftky9df2wqaku0ut8hm7uewxytd9ss --commission --from roberto --fees 200udaric --chain-id morpheus-apollo-2 --yes
set COMMAND 'ciao'
puts "command = $COMMAND"
#set COMMAND 'desmos tx distribution withdraw-rewards desmosvaloper1s7kph9sdftky9df2wqaku0ut8hm7uewxytd9ss --commission --from roberto --fees 200udaric --chain-id morpheus-apollo-2 --yes'
#set COMMAND "desmos tx distribution withdraw-rewards $VALIDATOR_ADDRESS --commission --from $KEY_NAME --fees ${TRANSACTION_FEES}${CURRENCY} --chain-id $CHAIN_ID --yes"
#set COMMAND "desmos q bank balances desmos1s7kph9sdftky9df2wqaku0ut8hm7uewx6x936z --node tcp://127.0.0.1:26657 -o json | jq -r \".balances\[0\].amount\""
set COMMAND "desmos q bank balances $DELEGATE_ADDRESS --node tcp://$NODE_ADDRESS_PORT -o json | jq -r \".balances\[0\].amount\""
puts $COMMAND
spawn {*}$COMMAND
#set AVAILABLE $expect_out(1,string)
puts "Actually available $AVAILABLE$CURRENCY\n"  
sleep 1

if { "$MODE" == "w" } {
    set COMMAND "desmos tx distribution withdraw-rewards $VALIDATOR_ADDRESS --commission --from $KEY_NAME --fees ${TRANSACTION_FEES}${CURRENCY} --chain-id $CHAIN_ID --yes"
    puts "MODE: Withdrawal"
} elseif { "$MODE" == "d" } {
    set COMMAND "desmos tx staking delegate $VALIDATOR_ADDRESS --from $KEY_NAME ${AMOUNT}${CURRENCY} --fees ${TRANSACTION_FEES}${CURRENCY} --chain-id $CHAIN_ID --yes"
    puts "MODE: Delegator"
} else  {
    puts "Wrong params. "
    puts "1 param is MODE: w (for withdrawals) or d (for delegations)"
    puts "2 param is PWD: your keyring password"
    puts "3 param is VALIDATOR_ADDRESS"
    puts "4 param is KEY_NAME"
    puts "5 param is CHAIN_ID"
    puts "6 param is CURRENCY"
    puts "7 param is TRANSACTION_FEES"
    puts "8 param is AMOUNT: delegating amount (used only when delegating)"
    exit -1
}

spawn {*}$COMMAND
expect ".*"
send -- "$PWD\r"
expect eof
