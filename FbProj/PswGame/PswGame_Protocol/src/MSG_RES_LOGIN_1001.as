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
		public var magic:uint;
		public var physique:uint;
		public var spell:uint;
		public var mind:uint;
		public var additions:uint;
		public var hp:uint;
		public var mp:uint;
		public var energy:uint;
		public var hp_max:uint;
		public var mp_max:uint;
		public var atk:uint;
		public var def:uint;
		public var magic_atk:uint;
		public var magic_def:uint;
		public var crit_atk:uint;
		public var crit_def:uint;
		public var hit:uint;
		public var dodge:uint;
		public var earth_atk:uint;
		public var earth_def:uint;
		public var water_atk:uint;
		public var water_def:uint;
		public var wind_atk:uint;
		public var wind_def:uint;
		public var fire_atk:uint;
		public var fire_def:uint;
		
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
			magic = input.readUnsignedShort();
			physique = input.readUnsignedShort();
			spell = input.readUnsignedShort();
			mind = input.readUnsignedShort();
			additions = input.readUnsignedShort();
			hp = input.readUnsignedInt();
			mp = input.readUnsignedInt();
			energy = input.readUnsignedInt();
			hp_max = input.readUnsignedInt();
			mp_max = input.readUnsignedInt();
			atk = input.readUnsignedInt();
			def = input.readUnsignedInt();
			magic_atk = input.readUnsignedInt();
			magic_def = input.readUnsignedInt();
			crit_atk = input.readUnsignedShort();
			crit_def = input.readUnsignedShort();
			hit = input.readUnsignedShort();
			dodge = input.readUnsignedShort();
			earth_atk = input.readUnsignedShort();
			earth_def = input.readUnsignedShort();
			water_atk = input.readUnsignedShort();
			water_def = input.readUnsignedShort();
			wind_atk = input.readUnsignedShort();
			wind_def = input.readUnsignedShort();
			fire_atk = input.readUnsignedShort();
			fire_def = input.readUnsignedShort();			
		}
	}
}