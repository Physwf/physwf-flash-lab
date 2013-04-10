package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class score_index_item_t implements IExternalizable
	{
		public var index:uint;
		public var score_item:score_item_t;
		
		public function score_index_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			index = input.readUnsignedInt();
			score_item= new score_item_t();
			score_item.readExternal(input)			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(index);
			score_item.writeExternal(output)			
		}
	}
}