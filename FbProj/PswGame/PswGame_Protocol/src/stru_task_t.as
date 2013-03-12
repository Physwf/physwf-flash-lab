package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_task_t implements IExternalizable
	{
		public var task_id:uint;
		public var flag:uint;
		public var steps:Vector.<stru_task_step_t>;
		
		public function stru_task_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			task_id = input.readUnsignedShort();
			flag = input.readUnsignedByte();
			var stepsLen:uint =input.readUnsignedInt();
			steps= new Vector.<stru_task_step_t>();
			for(var i:int=0;i<stepsLen;++i)
			{
				var steps_item:stru_task_step_t = new stru_task_step_t()
				steps_item.readExternal(input);;
				steps.push(steps_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(task_id);
			output.writeByte(flag);
			output.writeUnsignedInt(steps.length);
			for(var j:int=0;j<steps.length;++j)
			{
				steps[j].writeExternal(output);
			}			
		}
	}
}