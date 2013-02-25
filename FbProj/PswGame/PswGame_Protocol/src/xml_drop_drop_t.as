package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_drop_drop_t implements IExternalizable
	{
		public var drop_id:uint;
		public var max_drop:uint;
		public var group:Vector.<xml_drop_drop_group_t>;
		
		public function xml_drop_drop_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			drop_id = input.readUnsignedInt();
			max_drop = input.readUnsignedShort();
			var groupLen:uint =input.readUnsignedInt();
			group= new Vector.<xml_drop_drop_group_t>();
			for(var i:int=0;i<groupLen;++i)
			{
				var group_item:xml_drop_drop_group_t = new xml_drop_drop_group_t()
				group_item.readExternal(input);;
				group.push(group_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(drop_id);
			output.writeShort(max_drop);
			output.writeUnsignedInt(group.length);
			for(var j:int=0;j<group.length;++j)
			{
				group[j].writeExternal(output);
			}			
		}
	}
}