package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_sprite_t implements IExternalizable
	{
		public var user:db_user_id;
		public var nick:String;
		public var nick_data:ByteArray
		public var role_sex:uint;
		public var prof:uint;
		public var level:uint;
		public var flag:uint;
		public var money:uint;
		public var pet_grid:uint;
		public var exp:uint;
		public var strength:uint;
		public var solar:uint;
		public var physique:uint;
		public var spirit:uint;
		public var agility:uint;
		public var additions:uint;
		public var hp:uint;
		public var mp:uint;
		public var energy:uint;
		public var vigour:uint;
		public var current_title:uint;
		public var items:Vector.<bag_item_t>;
		public var equips:Vector.<stru_equip_t>;
		public var pets:Vector.<stru_pet_base_t>;
		public var tasks:Vector.<stru_task_t>;
		public var skills:Vector.<stru_skill_t>;
		public var ssid_vec:Vector.<key_value_t>;
		
		public function stru_sprite_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			user= new db_user_id();
			user.readExternal(input)
			nick = input.readUTFBytes(16);
			role_sex = input.readUnsignedByte();
			prof = input.readUnsignedByte();
			level = input.readUnsignedShort();
			flag = input.readUnsignedInt();
			money = input.readUnsignedInt();
			pet_grid = input.readUnsignedShort();
			exp = input.readUnsignedInt();
			strength = input.readUnsignedShort();
			solar = input.readUnsignedShort();
			physique = input.readUnsignedShort();
			spirit = input.readUnsignedShort();
			agility = input.readUnsignedShort();
			additions = input.readUnsignedShort();
			hp = input.readUnsignedInt();
			mp = input.readUnsignedInt();
			energy = input.readUnsignedShort();
			vigour = input.readUnsignedShort();
			current_title = input.readUnsignedInt();
			var itemsLen:uint =input.readUnsignedInt();
			items= new Vector.<bag_item_t>();
			for(var i:int=0;i<itemsLen;++i)
			{
				var items_item:bag_item_t = new bag_item_t()
				items_item.readExternal(input);;
				items.push(items_item);
			}
			var equipsLen:uint =input.readUnsignedInt();
			equips= new Vector.<stru_equip_t>();
			for(var k:int=0;k<equipsLen;++k)
			{
				var equips_item:stru_equip_t = new stru_equip_t()
				equips_item.readExternal(input);;
				equips.push(equips_item);
			}
			var petsLen:uint =input.readUnsignedInt();
			pets= new Vector.<stru_pet_base_t>();
			for(var q:int=0;q<petsLen;++q)
			{
				var pets_item:stru_pet_base_t = new stru_pet_base_t()
				pets_item.readExternal(input);;
				pets.push(pets_item);
			}
			var tasksLen:uint =input.readUnsignedInt();
			tasks= new Vector.<stru_task_t>();
			for(var x:int=0;x<tasksLen;++x)
			{
				var tasks_item:stru_task_t = new stru_task_t()
				tasks_item.readExternal(input);;
				tasks.push(tasks_item);
			}
			var skillsLen:uint =input.readUnsignedInt();
			skills= new Vector.<stru_skill_t>();
			for(var z:int=0;z<skillsLen;++z)
			{
				var skills_item:stru_skill_t = new stru_skill_t()
				skills_item.readExternal(input);;
				skills.push(skills_item);
			}
			var ssid_vecLen:uint =input.readUnsignedInt();
			ssid_vec= new Vector.<key_value_t>();
			for(var v:int=0;v<ssid_vecLen;++v)
			{
				var ssid_vec_item:key_value_t = new key_value_t()
				ssid_vec_item.readExternal(input);;
				ssid_vec.push(ssid_vec_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			user.writeExternal(output)
			if(nick_data)
			{
				output.writeBytes(nick_data)
			}
			else
			{
				var nickData:ByteArray = new ByteArray();
				nickData.writeUTFBytes(nick)
				nickData.length = 16;
				output.writeBytes(nickData)
			}
			output.writeByte(role_sex);
			output.writeByte(prof);
			output.writeShort(level);
			output.writeUnsignedInt(flag);
			output.writeUnsignedInt(money);
			output.writeShort(pet_grid);
			output.writeUnsignedInt(exp);
			output.writeShort(strength);
			output.writeShort(solar);
			output.writeShort(physique);
			output.writeShort(spirit);
			output.writeShort(agility);
			output.writeShort(additions);
			output.writeUnsignedInt(hp);
			output.writeUnsignedInt(mp);
			output.writeShort(energy);
			output.writeShort(vigour);
			output.writeUnsignedInt(current_title);
			output.writeUnsignedInt(items.length);
			for(var j:int=0;j<items.length;++j)
			{
				items[j].writeExternal(output);
			}
			output.writeUnsignedInt(equips.length);
			for(var p:int=0;p<equips.length;++p)
			{
				equips[p].writeExternal(output);
			}
			output.writeUnsignedInt(pets.length);
			for(var r:int=0;r<pets.length;++r)
			{
				pets[r].writeExternal(output);
			}
			output.writeUnsignedInt(tasks.length);
			for(var y:int=0;y<tasks.length;++y)
			{
				tasks[y].writeExternal(output);
			}
			output.writeUnsignedInt(skills.length);
			for(var u:int=0;u<skills.length;++u)
			{
				skills[u].writeExternal(output);
			}
			output.writeUnsignedInt(ssid_vec.length);
			for(var w:int=0;w<ssid_vec.length;++w)
			{
				ssid_vec[w].writeExternal(output);
			}			
		}
	}
}