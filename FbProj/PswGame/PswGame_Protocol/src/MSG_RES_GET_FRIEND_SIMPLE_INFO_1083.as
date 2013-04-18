package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_FRIEND_SIMPLE_INFO_1083 extends MsgBase
	{
		public var user_id:uint;
		public var role_tm:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var level:uint;
		public var prof:uint;
		public var sex:uint;
		public var equips:Vector.<uint>;
		
		public function MSG_RES_GET_FRIEND_SIMPLE_INFO_1083(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_id = input.readUnsignedInt();
			role_tm = input.readUnsignedInt();
			nick = input.readUTFBytes(16);
			level = input.readUnsignedShort();
			prof = input.readUnsignedByte();
			sex = input.readUnsignedByte();
			equips= new Vector.<uint>();
			for(var i:int=0;i<16;++i)
			{
				var equips_item:uint = input.readUnsignedShort();
				equips.push(equips_item)
			}
			
		}
	}
}