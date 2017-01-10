-- simple mail services using AppleScript without opening Mail
-- made by Neel

set operation to display dialog "Click the button you want to perform : " with title "Mail Operation" buttons {"Check inbox", "Send mail", "Open Mail"}

set operationDone to the button returned of operation

if operationDone is equal to "Send mail" then
	
	set email to display dialog "Enter the mail id : " default answer "" with title "Mail" buttons {"Cancel", "Proceed"} default button 2
	
	set emailid to the text returned of email
	
	set sub to display dialog "Enter the Subject : " default answer "" with title "Subject" buttons {"Cancel", "Proceed"} default button 2
	
	set subject1 to the text returned of sub
	
	
	set body to display dialog "Enter the body : " default answer "" with title "Body" buttons {"Cancel", "Proceed"} default button 2
	
	set myBody to text returned of body
	
	set attach to display dialog "Do you want to attach? " with title "Attachment" buttons {"Proceed without Attacment", "Proceed"}
	
	set theattach to the button returned of attach
	
	if theattach is equal to "Proceed" then
		
		set theattachment to choose file
		
		tell application "Mail"
			set theMessage to make new outgoing message with properties {visible:true, subject:"" & subject1, content:"" & myBody}
			
			tell content of theMessage
				make new attachment with properties {file name:theattachment} at after last paragraph
			end tell
			
			tell theMessage
				make new to recipient at end of every to recipient with properties {address:"" & emailid}
			end tell
			delay 5
			set volume 3
			say "Neel, Your mail is being send with attachment"
			send theMessage
			set volume 3
			beep
		end tell
	end if
	
	if theattach is equal to "Proceed without Attacment" then
		
		tell application "Mail"
			set theMessage to make new outgoing message with properties {visible:true, subject:"" & subject1, content:"" & myBody}
			
			tell theMessage
				make new to recipient at end of every to recipient with properties {address:"" & emailid}
			end tell
			delay 5
			set volume 3
			say "Neel, Your mail is being send"
			send theMessage
			beep
			set volume 3
			say "Your mail is being send"
		end tell
	end if
end if

if operationDone is equal to "Check inbox" then
	
	tell application "Finder"
		tell application "Mail"
			check for new mail
			set x to unread count of inbox
			delay 3
			set y to unread count of inbox
			set z to y - x
			set volume 3
			beep
			say "Neel, You have " & z & "number of unread Mail "
		end tell
	end tell
end if

if operationDone is equal to "Open Mail" then
	
	tell application "Finder"
		open application file id "com.apple.mail"
	end tell
	
end if

