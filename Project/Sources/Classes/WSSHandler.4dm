Class constructor($winRef : Integer)
	
	This:C1470.countClient:=0
	This:C1470.dataType:="object"
	This:C1470.winRef:=$winRef
	
	/// Function called when the server starts
Function onOpen($wss : Object; $param : Object)
	var $url : Text
	
	This:C1470.logFile("*** Server started")
	
	// Load the chat in the webarea
	$url:="http:///127.0.0.1:8080/ws client.htm"
	CALL FORM:C1391(This:C1470.winRef; Formula:C1597(WA OPEN URL:C1020(*; "Web Area"; $url)))
	
/** Function called each time a new user log in
 In this example, we accept all the connections */
Function onConnection($wss : Object; $param : Object) : Object
	
	This:C1470.logFile("*** New connection request from: "+$param.request.remoteAddress)
	
	$wss.handler.countClient+=1
	// Instanciates WSClientHandler class that manage the user connection behavior
	return cs:C1710.WSClientHandler.new($wss.handler.countClient; $param.request)
	
	/// Function called when the server closes
Function onTerminate
	
	This:C1470.logFile("*** Server closed")
	
	/// Function called when the an error occured
Function onError($wss : Object; $param : Object)
	
	This:C1470.logFile("!!! Server error: "+$param.statusText)
	
	/// Write information in the log file
Function logFile($log : Text)
	var $text : Text
	var $doc : Object
	$doc:=Folder:C1567(fk logs folder:K87:17).file("websocket.log")
	
	$text:=$doc.exists ? Document to text:C1236($doc.platformPath) : ""
	
	TEXT TO DOCUMENT:C1237($doc.platformPath; $text+"\r"+String:C10(Timestamp:C1445)+"   "+$log)
	