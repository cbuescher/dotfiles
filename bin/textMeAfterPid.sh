#!/bin/sh
if [ "$#" -eq 1 ]; then stdinmsg=$(cat); fi
exec <"$0" || exit; read v; read v; read v; exec /usr/bin/osascript - "$@" "$stdinmsg"; exit

-- another way of waiting until an app is running
on waitUntilRunning(appname, delaytime)
    repeat until my appIsRunning(appname)
        tell application "Messages" to close window 1
        delay delaytime
    end repeat

    -- the fact that Messages.app is running
    -- does not mean it is ready to send,
    -- unfortunately, add another small delay
    delay delaytime
end waitUntilRunning

on appIsRunning(appName)
    application appname is running
end appIsRunning


on waitUntilPidNotRunning(pid, delaytime)
	log " Waiting for "&pid
	repeat
		try
			set myresult to do shell script "ps ax | awk '{ print $1 }' | grep " & pid 
			if myresult is "" then exit repeat
		on error
			exit repeat
		end try
        delay delaytime
	end repeat
end waitUntilPidNotRunning

-- use system events (unused)
on SysevAppIsRunning(appName)
    tell application "System Events" to (name of processes) contains appName
end appIsRunning

-- use finder (unusged)
on finderAppIsRunning(appName)
    tell application "Finder" to (name of every process) contains appName
end appIsRunning

-- taken from:
-- http://stackoverflow.com/questions/11812184/how-to-send-an-imessage-text-with-applescript-only-in-provided-service
-- thanks to users @Senseful and @DigiLord
on run {PID, targetBuddyPhone, targetMessage}

	my waitUntilPidNotRunning(PID, 30)
	
    tell application "Messages"
        -- if Messages.app was not running, launch it
        set wasRunning to true
        if it is not running then
            set wasRunning to false
            launch
            close window 1
            my waitUntilRunning("Messages", 1)
            close window 1
        end if

        -- send the message
        set targetService to 1st service whose service type = iMessage
        set targetBuddy to buddy targetBuddyPhone of targetService
        send targetMessage to targetBuddy

        -- if the app was not running, close the window
        if not wasRunning
            close window 1
        end if
    end tell
end run
