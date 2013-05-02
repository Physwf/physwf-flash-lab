package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class btl_c_pet_t implements IExternalizable
	{
		public var sn:uint;
		public var id:uint;
		public var proto:uint;
		public var cur_hp:uint;
		public var max_hp:uint;
		public var cur_mp:uint;
		public var max_mp:uint;
		public var skills:Vector.<uint>;
		
		public function btl_c_pet_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			sn = input.readUnsignedInt();
			id = input.readUnsignedInt();
			proto = input.readUnsignedInt();
			cur_hp = input.readUnsignedInt();
			max_hp = input.readUnsignedInt();
			cur_mp = input.readUnsignedInt();
			max_mp = input.readUnsignedInt();
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
			output.writeUnsignedInt(sn);
			output.writeUnsignedInt(id);
			output.writeUnsignedInt(proto);
			output.writeUnsignedInt(cur_hp);
			output.writeUnsignedInt(max_hp);
			output.writeUnsignedInt(cur_mp);
			output.writeUnsignedInt(max_mp);
			output.writeUnsignedInt(skills.length);
			for(var i:uint=0;i<skills.length;i++)
			{
				output.writeUnsignedInt(skills[i]);
			}			
		}
	}
}