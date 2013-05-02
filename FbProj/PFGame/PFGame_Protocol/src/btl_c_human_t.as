package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class btl_c_human_t implements IExternalizable
	{
		public var sn:uint;
		public var id:uint;
		public var anger:uint;
		public var skills:Vector.<uint>;
		
		public function btl_c_human_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			sn = input.readUnsignedInt();
			id = input.readUnsignedInt();
			anger = input.readUnsignedInt();
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
			output.writeUnsignedInt(anger);
			output.writeUnsignedInt(skills.length);
			for(var i:uint=0;i<skills.length;i++)
			{
				output.writeUnsignedInt(skills[i]);
			}			
		}
	}
}