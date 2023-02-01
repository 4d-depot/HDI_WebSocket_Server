Case of 
		
	: (FORM Event:C1606.code=On Load:K2:1)
		
		InitWebSocketServer
		
		InitInfo
		
		Init
		
	: (FORM Event:C1606.code=On Unload:K2:2)
		var $state : Object
		// close the websocket server
		//If (Process number("WebSocketServer")>0)
		CALL WORKER:C1389("WebSocketServer"; Formula:C1597(WebSocketServer.terminate()))
		//End if 
		
End case 


