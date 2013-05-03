package com.physwf.components.rpc.msg
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	/**
	 * 	uint16_t	magic;//是否压缩
		uint32_t	len; len:包体长度
		uint32_t 	op; cmd
		uint32_t 	param; id
		uint32_t	seq; 序列号 
		uint32_t	ret;  S->C, 错误码 
	 * @author Physwf
	 */	
	public class MsgBase implements IExternalizable
	{
		public static const HEAD_LENGTH:int = 22;
		public static var UID:uint;
		private var compressed:uint;//是否压缩
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
			body.endian = Endian.LITTLE_ENDIAN;
			writeBody(body);
			var head:ByteArray = new ByteArray();
			head.endian = Endian.LITTLE_ENDIAN;
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
			output.writeShort(0);//是否压缩
			output.writeUnsignedInt(HEAD_LENGTH + body.length);//包体长度
			output.writeUnsignedInt(msgid);
			output.writeUnsignedInt(userID);
			output.writeUnsignedInt(0);//序列号
			output.writeUnsignedInt(0);//错误码
			body.position = 0;
			//trace("req:命令号->"+msgid,"用户id->"+userID,"包长->"+body.length);
		}
		
		public function readExternal(input:IDataInput):void
		{
			readHead(input);
			readBody(input);
		}
		
		private function readHead(input:IDataInput):void
		{
			compressed = input.readUnsignedShort();
			length = input.readUnsignedInt();
			msgid = input.readUnsignedInt();
			userID = input.readUnsignedInt();
			seqIndex = input.readUnsignedInt();
			statusCode = input.readUnsignedInt();
			//trace("res:命令号->"+msgid,"用户id->"+userID,"包长->"+length,"序列->"+seqIndex,"状态码->"+statusCode)
		}
		
		protected function readBody(input:IDataInput):void
		{
			throw "抽象方法，由子类实现！";
		}
	}
}