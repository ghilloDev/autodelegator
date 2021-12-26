# autodelegator

Simple auto delegator bot for Desmos Blockchain validators. It is still very rough and not refined. 
For any suggestion or if you find a bug please open an issue!
I started from the [Self Delegator Bot](https://github.com/g-luca/selfdeleg) made by g-luca, which is much more sophisticated and with more functionalities. This script is intended to be lightweight and doesn't need additional libs nor python<br> 

Once again, thank you [g-luca](https://github.com/g-luca) for all the top-notch work you did!

## Requirements

* Desmos CLI

## 1\. Install

``` bash
git clone https://github.com/ghilloDev/autodelegator.git && cd autodelegator
```
## 2\. Configuration

``` bash
mv template.ini config.ini && nano config.ini
```

And edit:

1. `KEY_NAME` with your validator key name. <br>
If you use the **test** keyring, in the future steps you can replace the password inputs with spaces/random characters
2. `VALIDATOR_ADDRESS`, ``DELEGATE_ADDRESS`, with your addresses.
(TODO) If you want to self delegate, `USER_ADDRESS` and `DELEGATE_ADDRESS` should match.
3. `MINIMUM_BALANCE` amount that the bot will always keep (eg. minimum 1000000 uDARIC) (TODO)
4. The other configuration values are optional

## 3\. Run

To run the bot, use:

``` bash
./autodelegator.sh
```
Then insert your keyring password only once at the first time it is asked and then let it run...

