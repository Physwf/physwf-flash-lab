package com.physwf.components.rpc
{
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.components.rpc.msg.MessageManager;
	import com.physwf.components.rpc.msg.MsgBase;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;

	public class RPCConnectioin extends EventDispatcher
	{
		public static var login:RPCConnectioin;
		public static var online:RPCConnectioin;
		
		private var rawSocket:Socket;
		private var buffer:ByteArray;
		private var helpBuffer:ByteArray;
		private var msgQueue:Vector.<MsgBase>;
		private var mConnectedCallBack:Function;
		
		public function RPCConnectioin()
		{
			
		}
		
		public function initialze():void
		{
			rawSocket = new Socket();
			buffer = new ByteArray();
			helpBuffer = new ByteArray();
			msgQueue = new <MsgBase>[];
			
			rawSocket.addEventListener(Event.CONNECT,onConnected);
			rawSocket.addEventListener(Event.CLOSE,onClosed);
			rawSocket.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			rawSocket.addEventListener(IOErrorEvent.IO_ERROR,onSocketError);
			rawSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSocketError);
		}
		
		private function onConnected(e:Event):void
		{
			trace("online:socket_connected!");
			mConnectedCallBack();
		}
		
		private function onClosed(e:Event):void
		{
			trace("online:socket_closed!");
		}
		
		private function onSocketData(e:ProgressEvent):void
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
//						if(!MSG) 
//						{
//							trace("未知的协议id:",mid);
//							return;
//						}
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
			
			while(msgQueue.length>0)
			{
				var message:MsgBase = msgQueue.shift();
				if(message.statusCode>0)
				{
					if(hasEventListener(MessageEvent.MSG_ERROR_+ message.msgid))
						dispatchEvent(new MessageEvent(MessageEvent.MSG_ERROR_ + message.msgid,message));
				}
				else
				{
					if(hasEventListener(MessageEvent.MSG_SUCCESS_ + message.msgid))
						dispatchEvent(new MessageEvent(MessageEvent.MSG_SUCCESS_ + message.msgid,message));
				}
			}
		}
		
		private function onSocketError(e:Event):void
		{
			switch(e.type)
			{
				case IOErrorEvent.IO_ERROR:
					trace("online:socket_ioError");
					break;
				case SecurityErrorEvent.SECURITY_ERROR:
					trace("online:socket_securityError");
					break;
			}
		}
		
		public function connect(ip:Object,onConnected:Function=null):void
		{
			if(rawSocket.connected) return;
			rawSocket.connect(ip.host,ip.port);
			mConnectedCallBack = onConnected;
		}
		
		public function close():void
		{
			if(rawSocket.connected) rawSocket.close();
		}
		public function call(msg:MsgBase):void
		{
			if(!rawSocket.connected) throw "网络连接已经断开！";
			var msgData:ByteArray = new ByteArray();
			msg.writeExternal(msgData);
			rawSocket.writeBytes(msgData);
			rawSocket.flush();
		}
	}
}