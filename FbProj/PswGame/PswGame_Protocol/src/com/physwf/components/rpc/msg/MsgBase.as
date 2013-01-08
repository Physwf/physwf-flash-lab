package com.physwf.components.rpc.msg
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	public class MsgBase implements IExternalizable
	{
		public static const HEAD_LENGTH:int = 18;
		public static var UID:uint;
		private var length:uint;
		public var msgid:uint;
		public var userID:uint;
		public var seqIndex:uint;
		public var statusCode:uint;
		
		public function MsgBase(mid:uint)
		{
			msgid = mid;
			userID = UID;
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			var body:ByteArray = new ByteArray();
			writeBody(body);
			var head:ByteArray = new ByteArray();
			writeHead(head,body);
			output.writeBytes(head);
			output.writeBytes(body);
		}
		
		protected function writeBody(output:IDataOutput):void
		{
			throw "抽象方法，由子类实现！";
		}
		
		private function writeHead(output:IDataOutput,body:ByteArray):void
		{
			output.writeUnsignedInt(HEAD_LENGTH + body.length);
			output.writeShort(msgid);
			output.writeUnsignedInt(userID);
			output.writeInt(0);
			var sum:uint = 0;
			body.position = 0;
			for(var i:int = 0; i < body.length; i++)
			{
				sum += body.readUnsignedByte();
			}
			sum %= 100000;
			output.writeInt(sum);
		}
		
		public function readExternal(input:IDataInput):void
		{
			readHead(input);
			readBody(input);
		}
		
		private function readHead(input:IDataInput):void
		{
			length = input.readUnsignedInt();
			msgid = input.readUnsignedShort();
			userID = input.readUnsignedInt();
			seqIndex = input.readUnsignedInt();
			statusCode = input.readUnsignedInt();
			trace("response:包长->"+length,"命令号->"+msgid,"用户id->"+userID,"序列->"+seqIndex,"状态码->"+statusCode)
		}
		
		protected function readBody(input:IDataInput):void
		{
			throw "抽象方法，由子类实现！";
		}
	}
}