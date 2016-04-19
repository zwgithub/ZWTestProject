// This file contains the source for the Javascript side of the
// WebViewJavascriptBridge. It is plaintext, but converted to an NSString
// via some preprocessor tricks.
//
// Previous implementations of WebViewJavascriptBridge loaded the javascript source
// from a resource. This worked fine for app developers, but library developers who
// included the bridge into their library, awkwardly had to ask consumers of their
// library to include the resource, violating their encapsulation. By including the
// Javascript as a string resource, the encapsulation of the library is maintained.

#import "WebViewJavascriptBridge_JS.h"

NSString * WebViewJavascriptBridge_js() {
	#define __wvjb_js_func__(x) #x
	
	// BEGIN preprocessorJSCode
	static NSString * preprocessorJSCode = @__wvjb_js_func__(
;(function() {
	if (window.WebViewJavascriptBridge) {
		return;
	}
        
        //alert("bridge_js中");
        
        //把一个 JSON 串赋值给 WebViewJavascriptBridge
	window.WebViewJavascriptBridge = {
		registerHandler: registerHandler,
		callHandler: callHandler,
		_fetchQueue: _fetchQueue,
		_handleMessageFromObjC: _handleMessageFromObjC
	};

	var messagingIframe;
	var sendMessageQueue = [];
	var messageHandlers = {};
	
	var CUSTOM_PROTOCOL_SCHEME = 'wvjbscheme';
	var QUEUE_HAS_MESSAGE = '__WVJB_QUEUE_MESSAGE__';
	
	var responseCallbacks = {};
	var uniqueId = 1;

	function registerHandler(handlerName, handler) {
//        alert("bridge_js中registerHandler");
		messageHandlers[handlerName] = handler;
	}
        
    function alertObjVars(obj){
        var description = "";
        for(var i in obj){
            var property=obj[i];
            description+=i+" = "+property+"\n";
        }
        alert(description);
    }
	
	function callHandler(handlerName, data, responseCallback) {
		if (arguments.length == 2 && typeof data == 'function') {
			responseCallback = data;
			data = null;
		}
		_doSend({ handlerName:handlerName, data:data }, responseCallback);
	}
	
	function _doSend(message, responseCallback) {
        //mesage 包含responseId,responseData
        //responseCallback为空
        
        //alertObjVars(message);
        //alertObjVars(responseCallback);
        
		if (responseCallback) {
			var callbackId = 'cb_'+(uniqueId++)+'_'+new Date().getTime();
			responseCallbacks[callbackId] = responseCallback;
			message['callbackId'] = callbackId;
		}
        
        alert("_doSend");
        
        sendMessageQueue.push(message);
		messagingIframe.src = CUSTOM_PROTOCOL_SCHEME + '://' + QUEUE_HAS_MESSAGE;
	}

	function _fetchQueue() {
        
        //JSON.stringify 用来生成 JSON 字符串
		var messageQueueString = JSON.stringify(sendMessageQueue);
		sendMessageQueue = [];
		return messageQueueString;
	}

	function _dispatchMessageFromObjC(messageJSON) {
        //messageJSON 里面包含 data  callbackId  handlerName
		setTimeout(function _timeoutDispatchMessageFromObjC() {
            //使用 JSON.parse 将 JSON 字符串转换为对象
			var message = JSON.parse(messageJSON);
			var messageHandler;
			var responseCallback;

			if (message.responseId) {
				responseCallback = responseCallbacks[message.responseId];
				if (!responseCallback) {
					return;
				}
				responseCallback(message.responseData);
				delete responseCallbacks[message.responseId];
			} else {
				if (message.callbackId) {
					var callbackResponseId = message.callbackId;
					responseCallback = function(responseData) {
						_doSend({ responseId:callbackResponseId, responseData:responseData });
					};
				}
				var handler = messageHandlers[message.handlerName];
				try {
					handler(message.data, responseCallback);
				} catch(exception) {
					console.log("WebViewJavascriptBridge: WARNING: javascript handler threw.", message, exception);
				}
				if (!handler) {
					console.log("WebViewJavascriptBridge: WARNING: no handler for message from ObjC:", message);
				}
			}
		});
	}
	
	function _handleMessageFromObjC(messageJSON) {
        _dispatchMessageFromObjC(messageJSON);
	}

	messagingIframe = document.createElement('iframe');
	messagingIframe.style.display = 'none';
	messagingIframe.src = CUSTOM_PROTOCOL_SCHEME + '://' + QUEUE_HAS_MESSAGE;
	document.documentElement.appendChild(messagingIframe);

//        alert("bridge_js中创建了iframe");
        
        
	setTimeout(_callWVJBCallbacks, 0);
	function _callWVJBCallbacks() {
		var callbacks = window.WVJBCallbacks;
        
		delete window.WVJBCallbacks;
		for (var i=0; i<callbacks.length; i++) {
//            alert("bridge_js准备开始执行");
			callbacks[i](WebViewJavascriptBridge);
		}
	}
})();
	); // END preprocessorJSCode

	#undef __wvjb_js_func__
	return preprocessorJSCode;
};