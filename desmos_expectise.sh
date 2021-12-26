#!/usr/bin/expect -f
set MODE [lindex $argv 0]
set PWD [lindex $argv 1]
set VALIDATOR_ADDRESS [lindex $argv 2]
set KEY_NAME [lindex $argv 3]
set CHAIN_ID [lindex $argv 4]
set CURRENCY [lindex $argv 5]
set TRANSACTION_FEES [lindex $argv 6]
set AMOUNT [lindex $argv 7]
set COMMAND ""
if { "$MODE" == "w" } {
    set COMMAND "desmos tx distribution withdraw-rewards $VALIDATOR_ADDRESS --commission --from $KEY_NAME --fees ${TRANSACTION_FEES}${CURRENCY} --chain-id $CHAIN_ID --yes"
    puts "MODE: Withdrawal $COMMAND"
} elseif { "$MODE" == "d" } {
    set COMMAND "desmos tx staking delegate $VALIDATOR_ADDRESS --from $KEY_NAME ${AMOUNT}${CURRENCY} --fees ${TRANSACTION_FEES}${CURRENCY} --chain-id $CHAIN_ID --yes"
    puts "MODE: Delegator $COMMAND"
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
