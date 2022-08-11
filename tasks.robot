*** Settings ***
Documentation       Various ways of running SSH commands with/out waiting for output.

Library    SSHLibrary

Suite Setup            Open Connection And Log In
Suite Teardown         Close All Connections


*** Variables ***
${COMMAND}    cd ~/Scripts && python3 printer.py


*** Keywords ***
Open Connection And Log In
    Open Connection     %{HOST}
    # Logins with the private SSH key found in your home directory. (otherwise store
    #  and retrieve the key from the Vault and use it with `Login With Public Key`)
    Login    %{USER}    look_for_keys=${True}


*** Tasks ***
Execute And Wait For Output
    ${out} =    Execute Command    ${COMMAND}
    Log To Console    Full output: ${out}


Execute And Read Async
    # Add as many commands as you like.
    @{commands} =    Create List
    ...    ${COMMAND} &  # not really necessary to have an `&` (background process)
    ...    whoami

    FOR    ${command}    IN    @{commands}
        Start Command    ${command}
    END

    ${count} =    Get Length    ${commands}
    FOR    ${idx}    IN RANGE    ${count}    0    -1
        ${out} =     Read Command Output
        Log To Console    Output #${idx}: ${out}
    END


Write And Read From Terminal
    Write    ${COMMAND}
    WHILE  ${True}
        ${out} =    Read    delay=1s
        ${size} =    Get Length    ${out}
        IF    ${size} == ${0}    BREAK

        Log To Console    Partial output: ${out}
    END
