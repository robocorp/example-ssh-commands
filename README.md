# Various ways of running SSH commands with/out waiting for output.

## Setup

1. Spawn a *nix environment with SSH access, preferably through a SSH key.
   - Passwords work too, but are less secure and you should pass it to the `Login`
     keyword.
2. Put on the remote environment this dummy Python
   [script](./devdata/Scripts/printer.py) under a _~/Scripts_ directory.
3. Check how it works by running from the remote home directory the following command:
   `cd ~/Scripts && python3 printer.py` and you should see some numbers being printed.

## Test

1. Configure your own `HOST` and `USER` [env](./devdata/env.json) vars first.
2. Run the robot in **VSCode** or with **rcc** and chose between different ways of
   running commands:
   - `Execute And Wait For Output`: Simply executes and waits until the command
     finishes.
   - `Execute And Read Async`: Executes commands without waiting for the previous one
     to finish, then retrieves the output from the most recent one until the first ran.
   - `Write And Read From Terminal`: Writes text into the console and reads until
     there's no more output to be displayed.

## Remarks

- The private key should be kept secret, safe and secure at all costs, that's why is
  called **private**.
  - Same applies to passwords.
- The same code can be adapted to real life scenarios where you execute more complex
  scripts. For dealing with their output, check the following
  [keywords](https://robocorp.com/docs/libraries/3rd-party-libraries/ssh/keywords) as
  well:
  - `Execute Command`
  - `Start Command` & `Read Command Output`
  - `Write[ Bare]` & `Read Until[ Prompt/Regexp]`
