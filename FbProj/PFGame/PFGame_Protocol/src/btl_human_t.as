package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class btl_human_t implements IExternalizable
	{
		public var id:uint;
		public var skills:Vector.<uint>;
		
		public function btl_human_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
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
			output.writeUnsignedInt(skills.length);
			for(var i:uint=0;i<skills.length;i++)
			{
				output.writeUnsignedInt(skills[i]);
			}			
		}
	}
}