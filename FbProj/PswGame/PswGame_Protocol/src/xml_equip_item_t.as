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
		public var quality:uint;
		public var user_lv:uint;
		public var sell_price:uint;
		public var buy_price:uint;
		public var max_num:uint;
		public var tradeable:uint;
		public var distory:uint;
		public var accumulate:uint;
		public var equip_pos:uint;
		public var duration_time:uint;
		public var end_time:uint;
		public var strength:uint;
		public var magic:uint;
		public var physique:uint;
		public var spell:uint;
		public var mind:uint;
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
			category = input.readUnsignedShort();
			quality = input.readUnsignedShort();
			user_lv = input.readUnsignedShort();
			sell_price = input.readUnsignedInt();
			buy_price = input.readUnsignedInt();
			max_num = input.readUnsignedShort();
			tradeable = input.readUnsignedShort();
			distory = input.readUnsignedShort();
			accumulate = input.readUnsignedShort();
			equip_pos = input.readUnsignedShort();
			duration_time = input.readUnsignedInt();
			end_time = input.readUnsignedInt();
			strength = input.readUnsignedShort();
			magic = input.readUnsignedShort();
			physique = input.readUnsignedShort();
			spell = input.readUnsignedShort();
			mind = input.readUnsignedShort();
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
			durability = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(item_id);
			output.writeShort(category);
			output.writeShort(quality);
			output.writeShort(user_lv);
			output.writeUnsignedInt(sell_price);
			output.writeUnsignedInt(buy_price);
			output.writeShort(max_num);
			output.writeShort(tradeable);
			output.writeShort(distory);
			output.writeShort(accumulate);
			output.writeShort(equip_pos);
			output.writeUnsignedInt(duration_time);
			output.writeUnsignedInt(end_time);
			output.writeShort(strength);
			output.writeShort(magic);
			output.writeShort(physique);
			output.writeShort(spell);
			output.writeShort(mind);
			output.writeUnsignedInt(atk);
			output.writeUnsignedInt(def);
			output.writeUnsignedInt(magic_atk);
			output.writeUnsignedInt(magic_def);
			output.writeShort(crit_atk);
			output.writeShort(crit_def);
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