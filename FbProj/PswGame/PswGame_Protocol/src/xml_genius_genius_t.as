package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_genius_genius_t implements IExternalizable
	{
		public var genius_id:uint;
		public var role_type:uint;
		public var user_lv:uint;
		public var genius_lv:uint;
		public var genius_exp:uint;
		public var genius_money:uint;
		public var skill_vec:Vector.<uint>;
		public var phy_atk:uint;
		public var solar_atk:uint;
		public var phy_def:uint;
		public var solar_def:uint;
		public var hit:uint;
		public var dodge:uint;
		public var hp_max:uint;
		public var mp_max:uint;
		public var crit:uint;
		
		public function xml_genius_genius_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			genius_id = input.readUnsignedShort();
			role_type = input.readUnsignedByte();
			user_lv = input.readUnsignedByte();
			genius_lv = input.readUnsignedByte();
			genius_exp = input.readUnsignedInt();
			genius_money = input.readUnsignedInt();
			var skill_vecLen:uint =input.readUnsignedInt();
			skill_vec= new Vector.<uint>();
			for(var i:int=0;i<skill_vecLen;++i)
			{
				var skill_vec_item:uint = input.readUnsignedShort();;
				skill_vec.push(skill_vec_item);
			}
			phy_atk = input.readUnsignedByte();
			solar_atk = input.readUnsignedByte();
			phy_def = input.readUnsignedByte();
			solar_def = input.readUnsignedByte();
			hit = input.readUnsignedByte();
			dodge = input.readUnsignedByte();
			hp_max = input.readUnsignedInt();
			mp_max = input.readUnsignedInt();
			crit = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(genius_id);
			output.writeByte(role_type);
			output.writeByte(user_lv);
			output.writeByte(genius_lv);
			output.writeUnsignedInt(genius_exp);
			output.writeUnsignedInt(genius_money);
			output.writeUnsignedInt(skill_vec.length);
			for(var j:int=0;j<skill_vec.length;++j)
			{
				output.writeShort(skill_vec[j]);
			}
			output.writeByte(phy_atk);
			output.writeByte(solar_atk);
			output.writeByte(phy_def);
			output.writeByte(solar_def);
			output.writeByte(hit);
			output.writeByte(dodge);
			output.writeUnsignedInt(hp_max);
			output.writeUnsignedInt(mp_max);
			output.writeByte(crit);			
		}
	}
}