# autodelegator

Simple auto delegator bot for Desmos Blockchain validators. It is still very rough and not refined. 
For any suggestion or if you find a bug please open an issue!
I started from the [Self Delegator Bot](https://github.com/g-luca/selfdeleg) made by g-luca, which is much more sophisticated and with more functionalities. This script is intended to be lightweight and doesn't need additional libs nor python<br> 

Once again, thank you [g-luca](https://github.com/g-luca) for all the top-notch work you did!

## Requirements

* Desmos CLI

## 1\. Install

``` bash
git clone https://github.com/g-luca/autodelegator.git && cd autodelegator
```
## 2\. Configuration

``` bash
mv template.ini config.ini && nano config.ini
```

And edit:

1. `KEY_NAME` with your validator key name, and `KEY_BACKEND` if you use a different [keyring backend](https://docs.cosmos.network/v0.42/run-node/keyring.html). <br>
If you use the **test** keyring, in the future steps you can replace the password inputs with spaces/random characters
2. `VALIDATOR_ADDRESS`, `USER_ADDRESS`, `DELEGATE_ADDRESS`, with your addresses.
If you want to self delegate, `USER_ADDRESS` and `DELEGATE_ADDRESS` should match.
3. If you are installing the bot in a machine that is not running a node/validator configure `DEFAULT_NODE_ADDRESS` and `DEFAULT_NODE_PORT` with remote nodes addresses
4. `MINIMUM_BALANCE` amount of DARIC that the bot will always keep (minimum 1 DARIC)
5. The other configuration values are optional

## 3\. Run

To run the bot, use:

``` bash
./autodelegator.sh
```
Then insert your keyring password only once at the first time it is asked and then let it run...

