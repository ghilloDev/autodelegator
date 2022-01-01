# autodelegator

Simple auto delegator bot for Desmos Blockchain validators. It delegates both commision and rewards to the specified validator address. And loops this operation with a specificed interval.<br> 
I started from the [Self Delegator Bot](https://github.com/g-luca/selfdeleg) made by g-luca, which is much more sophisticated and with more functionalities. This script is intended to be lightweight with no need of additional libs nor python.<br> 
Once again, thank you [g-luca](https://github.com/g-luca) for all the top-notch work you did!<br> 

Currently it is still very rough and not refined. <br> 
For any suggestion or if you find a bug please open an issue.<br> 

## Requirements

* Desmos CLI

## 1\. Install

``` bash
git clone https://github.com/ghilloDev/autodelegator.git && cd autodelegator && chmod u+x autodelegator.sh
```
## 2\. Configuration

``` bash
mv template.ini config.ini && nano config.ini
```

And edit it with your values.

## 3\. Run

To run the bot, use:

``` bash
./autodelegator.sh
```
Then insert your keyring password only once at the first time it is asked and let the script run without any other input.

