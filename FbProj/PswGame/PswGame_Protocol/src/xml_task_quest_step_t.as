package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_task_quest_step_t implements IExternalizable
	{
		public var step_id:uint;
		public var type:uint;
		public var condition:uint;
		public var num:uint;
		public var pre:Vector.<uint>;
		public var isand:uint;
		
		public function xml_task_quest_step_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			step_id = input.readUnsignedShort();
			type = input.readUnsignedByte();
			condition = input.readUnsignedInt();
			num = input.readUnsignedShort();
			var preLen:uint =input.readUnsignedInt();
			pre= new Vector.<uint>();
			for(var i:int=0;i<preLen;++i)
			{
				var pre_item:uint = input.readUnsignedShort();;
				pre.push(pre_item);
			}
			isand = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(step_id);
			output.writeByte(type);
			output.writeUnsignedInt(condition);
			output.writeShort(num);
			output.writeUnsignedInt(pre.length);
			for(var j:int=0;j<pre.length;++j)
			{
				output.writeShort(pre[j]);
			}
			output.writeByte(isand);			
		}
	}
}