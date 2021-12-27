#!/bin/bash

CONFIG_FILE="config.ini"
KEY_NAME=$(awk -F "=" '/KEY_NAME/ {gsub(/[ \t]/, "", $2); print $2}' $CONFIG_FILE)
CHAIN_ID=$(awk -F "=" '/CHAIN_ID/ {gsub(/[ \t]/, "", $2); print $2}' $CONFIG_FILE)
VALIDATOR_ADDRESS=$(awk -F "=" '/VALIDATOR_ADDRESS/ {gsub(/[ \t]/, "", $2); print $2}' $CONFIG_FILE)
DELEGATE_ADDRESS=$(awk -F "=" '/DELEGATE_ADDRESS/ {gsub(/[ \t]/, "", $2); print $2}' $CONFIG_FILE)
NODE_ADDRESS_PORT=$(awk -F "=" '/NODE_ADDRESS_PORT/ {gsub(/[ \t]/, "", $2); print $2}' $CONFIG_FILE)
CURRENCY=$(awk -F "=" '/CURRENCY/ {gsub(/[ \t]/, "", $2); print $2}' $CONFIG_FILE)
MINIMUM_BALANCE=$(awk -F "=" '/MINIMUM_BALANCE/ {gsub(/[ \t]/, "", $2); print $2}' $CONFIG_FILE)
TRANSACTION_FEES=$(awk -F "=" '/TRANSACTION_FEES/ {gsub(/[ \t]/, "", $2); print $2}' $CONFIG_FILE)
THRESHOLD_MOVEMENT_AMOUNT=$(awk -F "=" '/THRESHOLD_MOVEMENT_AMOUNT/ {gsub(/[ \t]/, "", $2); print $2}' $CONFIG_FILE)
REFRESH_TIME=$(awk -F "=" '/REFRESH_TIME/ {gsub(/[ \t]/, "", $2); print $2}' $CONFIG_FILE)

echo "Enter Desmos keyring passphrase (just this time, please ignore next output messages since they'll be managed by the bot):"
read -s PWD
while true
do
    AVAILABLE=$(desmos q bank balances $DELEGATE_ADDRESS --node tcp://$NODE_ADDRESS_PORT -o json | jq -r ".balances[0].amount") 
    printf "Actually available %u %s\n" $AVAILABLE $CURRENCY
    echo "WHITDRAW START"
    ./desmos_expectise.sh w $PWD $VALIDATOR_ADDRESS $KEY_NAME $CHAIN_ID $CURRENCY $TRANSACTION_FEES
    printf "WHITDRAW ENDED, checking new availability\n" 
    sleep 25
    AVAILABLE=$(desmos q bank balances $DELEGATE_ADDRESS --node tcp://$NODE_ADDRESS_PORT -o json | jq -r ".balances[0].amount") 
    printf "Now available %s \n" $AVAILABLE
    AMOUNT=$((AVAILABLE-MINIMUM_BALANCE-TRANSACTION_FEES))
    if [[ $AMOUNT -ge $THRESHOLD_MOVEMENT_AMOUNT ]]
    then
        printf "DELEGATION START ...of amount %s \n" $AMOUNT
        ./desmos_expectise.sh d $PWD $VALIDATOR_ADDRESS $KEY_NAME $CHAIN_ID $CURRENCY $TRANSACTION_FEES $AMOUNT
    else 
        printf "DELEGATION SKIPPED this time. Available amount %s is lower than the threshold %s\n" $AMOUNT $THRESHOLD_MOVEMENT_AMOUNT
    fi 
    printf "DELEGATION ENDED ...go sleeping for %s \n" $REFRESH_TIME
    sleep $REFRESH_TIME
done