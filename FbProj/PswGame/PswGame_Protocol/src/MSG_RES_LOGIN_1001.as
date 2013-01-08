package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_LOGIN_1001 extends MsgBase
	{
		public var nick:String;
		public var nick_data:ByteArray
		public var prof:uint;
		public var level:uint;
		public var exp:uint;
		public var map_id:uint;
		public var map_x:uint;
		public var map_y:uint;
		public var resource_id:uint;
		public var strength:uint;
		public var intelligence:uint;
		public var physical:uint;
		public var magic:uint;
		public var speed:uint;
		public var additions:uint;
		public var hp:uint;
		public var mp:uint;
		public var energy:uint;
		public var hp_max:uint;
		public var mp_max:uint;
		public var attack:uint;
		public var mattack:uint;
		public var defense:uint;
		public var mdefense:uint;
		public var hit:uint;
		public var avoid:uint;
		public var multi_attack:uint;
		public var multi_avoid:uint;
		
		public function MSG_RES_LOGIN_1001(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			nick = input.readUTFBytes(16);
			prof = input.readUnsignedInt();
			level = input.readUnsignedShort();
			exp = input.readUnsignedInt();
			map_id = input.readUnsignedInt();
			map_x = input.readUnsignedInt();
			map_y = input.readUnsignedInt();
			resource_id = input.readUnsignedInt();
			strength = input.readUnsignedShort();
			intelligence = input.readUnsignedShort();
			physical = input.readUnsignedShort();
			magic = input.readUnsignedShort();
			speed = input.readUnsignedShort();
			additions = input.readUnsignedShort();
			hp = input.readUnsignedInt();
			mp = input.readUnsignedInt();
			energy = input.readUnsignedInt();
			hp_max = input.readUnsignedInt();
			mp_max = input.readUnsignedInt();
			attack = input.readUnsignedInt();
			mattack = input.readUnsignedInt();
			defense = input.readUnsignedInt();
			mdefense = input.readUnsignedInt();
			hit = input.readUnsignedShort();
			avoid = input.readUnsignedShort();
			multi_attack = input.readUnsignedShort();
			multi_avoid = input.readUnsignedShort();			
		}
	}
}