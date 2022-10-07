display notification "" with title "Value journal time!" subtitle "Capture what it is that you're doing right now, and how you are feeling." sound name "Frog"

tell application "Google Chrome"
	if not running then
		run
		delay 0.25
	end if

	activate
    open location "https://docs.google.com/spreadsheets/d/1kX1PgxE8BDUQlvs4mF7vfURh85JkeLu1ZE5GYM_TdHA/edit#gid=0"
    delay 1
    activate
end tell
