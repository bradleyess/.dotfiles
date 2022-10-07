display notification "" with title "?? It's time to write!" subtitle "Mindful writing makes you feel good and think better." sound name "Frog"

tell application "Obsidian"
	if not running then
		run
		delay 0.25
	end if
	activate
end tell