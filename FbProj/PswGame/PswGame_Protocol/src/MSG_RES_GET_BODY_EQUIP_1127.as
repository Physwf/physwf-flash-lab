package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_BODY_EQUIP_1127 extends MsgBase
	{
		public var user_id:uint;
		public var role_tm:uint;
		public var body_equip:Vector.<uint>;
		
		public function MSG_RES_GET_BODY_EQUIP_1127(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_id = input.readUnsignedInt();
			role_tm = input.readUnsignedInt();
			body_equip= new Vector.<uint>();
			for(var i:int=0;i<16;++i)
			{
				var body_equip_item:uint = input.readUnsignedShort();
				body_equip.push(body_equip_item)
			}
			
		}
	}
}