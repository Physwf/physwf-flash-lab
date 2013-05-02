package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class btl_pet_t implements IExternalizable
	{
		public var id:uint;
		public var proto:uint;
		public var lv:uint;
		public var cur_hp:uint;
		public var max_hp:uint;
		public var cur_mp:uint;
		public var max_mp:uint;
		public var magic_attack:uint;
		public var phy_attack:uint;
		public var magic_defence:uint;
		public var phy_defence:uint;
		public var hit:uint;
		public var dodge:uint;
		public var crit:uint;
		public var speed:uint;
		public var skills:Vector.<uint>;
		
		public function btl_pet_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			proto = input.readUnsignedInt();
			lv = input.readUnsignedInt();
			cur_hp = input.readUnsignedInt();
			max_hp = input.readUnsignedInt();
			cur_mp = input.readUnsignedInt();
			max_mp = input.readUnsignedInt();
			magic_attack = input.readUnsignedInt();
			phy_attack = input.readUnsignedInt();
			magic_defence = input.readUnsignedInt();
			phy_defence = input.readUnsignedInt();
			hit = input.readUnsignedInt();
			dodge = input.readUnsignedInt();
			crit = input.readUnsignedInt();
			speed = input.readUnsignedInt();
			var skillsLen:uint =input.readUnsignedInt();
			skills= new Vector.<uint>();
			for(var i:uint=0;i<skillsLen;i++)
			{
				var skills_item:uint = input.readUnsignedInt();;
				skills.push(skills_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(id);
			output.writeUnsignedInt(proto);
			output.writeUnsignedInt(lv);
			output.writeUnsignedInt(cur_hp);
			output.writeUnsignedInt(max_hp);
			output.writeUnsignedInt(cur_mp);
			output.writeUnsignedInt(max_mp);
			output.writeUnsignedInt(magic_attack);
			output.writeUnsignedInt(phy_attack);
			output.writeUnsignedInt(magic_defence);
			output.writeUnsignedInt(phy_defence);
			output.writeUnsignedInt(hit);
			output.writeUnsignedInt(dodge);
			output.writeUnsignedInt(crit);
			output.writeUnsignedInt(speed);
			output.writeUnsignedInt(skills.length);
			for(var i:uint=0;i<skills.length;i++)
			{
				output.writeUnsignedInt(skills[i]);
			}			
		}
	}
}