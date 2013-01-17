package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_equip_item_t implements IExternalizable
	{
		public var item_id:uint;
		public var category:uint;
		public var sell_price:uint;
		public var buy_price:uint;
		public var max_num:uint;
		public var trade_flag:uint;
		public var discard_flag:uint;
		public var accumulate:uint;
		public var equip_pos:uint;
		public var duration_time:uint;
		public var end_time:uint;
		public var strength:uint;
		public var magic:uint;
		public var physical:uint;
		public var genius:uint;
		public var agility:uint;
		public var hp:uint;
		public var mp:uint;
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
		public var durability:uint;
		
		public function xml_equip_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			item_id = input.readUnsignedInt();
			category = input.readUnsignedInt();
			sell_price = input.readUnsignedInt();
			buy_price = input.readUnsignedInt();
			max_num = input.readUnsignedInt();
			trade_flag = input.readUnsignedInt();
			discard_flag = input.readUnsignedInt();
			accumulate = input.readUnsignedInt();
			equip_pos = input.readUnsignedInt();
			duration_time = input.readUnsignedInt();
			end_time = input.readUnsignedInt();
			strength = input.readUnsignedInt();
			magic = input.readUnsignedShort();
			physical = input.readUnsignedShort();
			genius = input.readUnsignedShort();
			agility = input.readUnsignedShort();
			hp = input.readUnsignedInt();
			mp = input.readUnsignedInt();
			atk = input.readUnsignedInt();
			def = input.readUnsignedInt();
			magic_atk = input.readUnsignedInt();
			magic_def = input.readUnsignedInt();
			crit_atk = input.readUnsignedShort();
			crit_def = input.readUnsignedInt();
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
			durability = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(item_id);
			output.writeInt(category);
			output.writeInt(sell_price);
			output.writeInt(buy_price);
			output.writeInt(max_num);
			output.writeInt(trade_flag);
			output.writeInt(discard_flag);
			output.writeInt(accumulate);
			output.writeInt(equip_pos);
			output.writeInt(duration_time);
			output.writeInt(end_time);
			output.writeInt(strength);
			output.writeShort(magic);
			output.writeShort(physical);
			output.writeShort(genius);
			output.writeShort(agility);
			output.writeInt(hp);
			output.writeInt(mp);
			output.writeInt(atk);
			output.writeInt(def);
			output.writeInt(magic_atk);
			output.writeInt(magic_def);
			output.writeShort(crit_atk);
			output.writeInt(crit_def);
			output.writeShort(hit);
			output.writeShort(dodge);
			output.writeShort(earth_atk);
			output.writeShort(earth_def);
			output.writeShort(water_atk);
			output.writeShort(water_def);
			output.writeShort(wind_atk);
			output.writeShort(wind_def);
			output.writeShort(fire_atk);
			output.writeShort(fire_def);
			output.writeShort(durability);			
		}
	}
}