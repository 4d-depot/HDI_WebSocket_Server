//%attributes = {}
// Init webserver 
var $webServer : 4D:C1709.WebServer
var $handler : cs:C1710.WSSHandler

// Start the web server if necessary
$webServer:=WEB Server:C1674(Web server host database:K73:31)
If (Not:C34($webserver.isRunning))
	$webserver.start()
End if 

// Class that defines the server behavior
$handler:=cs:C1710.WSSHandler.new(Current form window:C827)

// Creation of the websocket server 
CALL WORKER:C1389("WebSocketServer"; Formula:C1597(WebSocketServer:=4D:C1709.WebSocketServer.new($handler)))