Class constructor($countClient : Integer; $request : Object)
	/// Class that defines a connection behavior 
	var $colors : Collection
	
	// Creates the user name that appear in conversation
	This:C1470.name:="Client"+String:C10($countClient)
	// Definition of the color text for the current user in conversation
	$colors:=New collection:C1472("aqua"; "blue"; "fuchsia"; "gray"; "green"; "lime"; "maroon"; "navy"; "olive"; "purple"; "silver"; "teal")
	This:C1470.color:=$colors[Mod:C98($countClient; $colors.length)]
	
	// Stores the remote address
	This:C1470.address:=$request.remoteAddress
	
	
	/// Defines a connection behavior
Function onOpen($ws : 4D:C1709.WebSocketConnection; $info : Object)
	var $client : Object
	
	$ws.wss.handler.logFile("New client connected: "+This:C1470.name+" - "+This:C1470.address)
	
	// Send a message to the client chat to let him know he is connected
	$ws.send(This:C1470.serverMessage("Welcome on the chat!"))
	
	// Send the message "new client connected" to all clients
	For each ($client; $ws.wss.connections)
		If ($client.id#$ws.id)
			$client.send(This:C1470.myMessage(This:C1470.color; String:C10(This:C1470.name)+" connected!"))
		End if 
	End for each 
	
	// Called each time the user sends a message
Function onMessage($ws : Object; $info : Object)
	var $client : Object
	
	// Resend the message to all clients
	For each ($client; $ws.wss.connections)
		If ($client.id#$ws.id)
			$client.send($client.handler.myMessage(This:C1470.color; This:C1470.name+": "+String:C10($info.data)))
		End if 
	End for each 
	
	// Called when an error occured
Function onError($ws : Object; $info : Object)
	
	$ws.wss.handler.logFile("*** Error: "+This:C1470.name+" - "+This:C1470.address+" - "+JSON Stringify:C1217($info.status))
	
	// Called when the session is closed
Function onTerminate($ws : Object; $info : Object)
	var $client : Object
	
	$ws.wss.handler.logFile("Connection closed: "+This:C1470.name+" - "+String:C10(This:C1470.address)+" - code: "+String:C10($info.code)+" "+String:C10($info.reason))
	// resend the message "new client connected" to all clients
	For each ($client; $ws.wss.connections)
		If ($client.id#$ws.id)
			$client.send(This:C1470.myMessage(This:C1470.color; String:C10(This:C1470.name)+" disconnected!"))
		End if 
	End for each 
	
	/// creates a server type message (display in red in the chat)
Function serverMessage($message : Text) : Text
	return "<p style='color:red'>"+String:C10($message)+"</p>"
	
	/// Creates a message with a defined user color 
Function myMessage($color : Text; $message : Text) : Text
	return "<p style='color:"+$color+"'>"+String:C10($message)+"</p>"