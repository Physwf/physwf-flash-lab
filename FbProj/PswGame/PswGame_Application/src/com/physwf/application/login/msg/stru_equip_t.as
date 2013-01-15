package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_equip_t implements IExternalizable
	{
		public var gettime:uint;
		public var equip_id:uint;
		public var hp:uint;
		public var mp:uint;
		public var attack:uint;
		public var mattack:uint;
		public var defense:uint;
		public var mdefense:uint;
		public var hit:uint;
		public var avoid:uint;
		public var multi_atk:uint;
		public var multi_atk_avoid:uint;
		
		public function stru_equip_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			gettime = input.readUnsignedInt();
			equip_id = input.readUnsignedInt();
			hp = input.readUnsignedInt();
			mp = input.readUnsignedInt();
			attack = input.readUnsignedInt();
			mattack = input.readUnsignedInt();
			defense = input.readUnsignedInt();
			mdefense = input.readUnsignedInt();
			hit = input.readUnsignedShort();
			avoid = input.readUnsignedShort();
			multi_atk = input.readUnsignedShort();
			multi_atk_avoid = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(gettime);
			output.writeInt(equip_id);
			output.writeInt(hp);
			output.writeInt(mp);
			output.writeInt(attack);
			output.writeInt(mattack);
			output.writeInt(defense);
			output.writeInt(mdefense);
			output.writeShort(hit);
			output.writeShort(avoid);
			output.writeShort(multi_atk);
			output.writeShort(multi_atk_avoid);			
		}
	}
}