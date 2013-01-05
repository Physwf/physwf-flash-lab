package com.physwf.application.login.rpc
{
	import com.physwf.application.login.msg.MessageManager;
	import com.physwf.application.login.msg.MsgBase;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;

	public class RPCClient
	{
		private static var rawSocket:Socket;
		private static var buffer:ByteArray;
		private static var helpBuffer:ByteArray;
		private static var msgQueue:Vector.<MsgBase>;
		private static var mConnectedCallBack:Function;
		
		private static var sHelpEventDispatcher:EventDispatcher;
		
		public function RPCClient()
		{
		}
		
		public static function initialze():void
		{
			rawSocket = new Socket();
			buffer = new ByteArray();
			helpBuffer = new ByteArray();
			msgQueue = new <MsgBase>[];
			sHelpEventDispatcher = new EventDispatcher();
			
			rawSocket.addEventListener(Event.CONNECT,onConnected);
			rawSocket.addEventListener(Event.CLOSE,onClosed);
			rawSocket.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			rawSocket.addEventListener(IOErrorEvent.IO_ERROR,onSocketError);
			rawSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSocketError);
			
			MessageManager.instance.registerMessage();
		}
		
		private static function onConnected(e:Event):void
		{
			trace("login:socket_connected!");
			mConnectedCallBack();
		}
		
		private static function onClosed(e:Event):void
		{
			trace("login:socket_closed!");
		}
		
		private static function onSocketData(e:ProgressEvent):void
		{
			buffer.clear();
			if(helpBuffer.length>0)
			{
				buffer.writeBytes(helpBuffer);
				helpBuffer.clear();
			}
			if(rawSocket.bytesAvailable)
			{
				rawSocket.readBytes(buffer,buffer.length,rawSocket.bytesAvailable);//读入缓冲
			}
			buffer.position = 0;
			
			while(buffer.bytesAvailable)
			{
				if(buffer.bytesAvailable >= MsgBase.HEAD_LENGTH)
				{
					var msgLen:int = buffer.readUnsignedInt() - MsgBase.HEAD_LENGTH;
					if(buffer.bytesAvailable >= msgLen)
					{
						var mid:uint = buffer.readUnsignedShort();
						var MSG:Class = MessageManager.instance.getMSG(mid);
						var msg:MsgBase = new MSG(mid) as MsgBase;
						buffer.position -= 6;
						msg.readExternal(buffer);
						msgQueue.push(msg);
					}
					else
					{
						buffer.position -= MsgBase.HEAD_LENGTH;
						buffer.readBytes(helpBuffer,0,buffer.bytesAvailable);
					}
				}
				else
				{
					buffer.readBytes(helpBuffer,0,buffer.bytesAvailable);
				}
			}

			if(msgQueue.length>0)
			{
				var message:MsgBase = msgQueue.shift();
				if(message.statusCode>0)
				{
					if(sHelpEventDispatcher.hasEventListener(MessageEvent.MSG_ERROR_+ message.msgid))
						sHelpEventDispatcher.dispatchEvent(new MessageEvent(MessageEvent.MSG_ERROR_ + message.msgid,message));
				}
				else
				{
					if(sHelpEventDispatcher.hasEventListener(MessageEvent.MSG_SUCCESS_ + message.msgid))
						sHelpEventDispatcher.dispatchEvent(new MessageEvent(MessageEvent.MSG_SUCCESS_ + message.msgid,message));
				}
			}
		}
		
		private static function onSocketError(e:Event):void
		{
			switch(e.type)
			{
				case IOErrorEvent.IO_ERROR:
					trace("login:socket_ioError");
					break;
				case SecurityErrorEvent.SECURITY_ERROR:
					trace("login:socket_securityError");
					break;
			}
		}
		
		public static function connect(ip:Object,onConnected:Function=null):void
		{
			if(rawSocket.connected) return;
			rawSocket.connect(ip.host,ip.port);
			mConnectedCallBack = onConnected;
		}
		
		public static function call(msg:MsgBase):void
		{
			if(!rawSocket.connected) throw "网络连接已经断开！";
			var msgData:ByteArray = new ByteArray();
			msg.writeExternal(msgData);
			rawSocket.writeBytes(msgData);
			rawSocket.flush();
		}
		
		public static function addEventListener(type:String,listener:Function,useCapture:Boolean=false,priority:int=0,useWeakReference:Boolean=false):void
		{
			sHelpEventDispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
	}
}