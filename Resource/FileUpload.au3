WinWaitActive("File Upload") ; Wait for the window to become active
ControlSetText("File Upload", "", "Edit1", "\Resource\photo.jpeg") ; Photo file path
ControlClick("File Upload", "", "Button1") ; Open button
