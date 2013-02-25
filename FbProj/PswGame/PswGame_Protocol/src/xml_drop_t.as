package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_drop_t implements IExternalizable
	{
		public var drop:Vector.<xml_drop_drop_t>;
		
		public function xml_drop_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var dropLen:uint =input.readUnsignedInt();
			drop= new Vector.<xml_drop_drop_t>();
			for(var i:int=0;i<dropLen;++i)
			{
				var drop_item:xml_drop_drop_t = new xml_drop_drop_t()
				drop_item.readExternal(input);;
				drop.push(drop_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(drop.length);
			for(var j:int=0;j<drop.length;++j)
			{
				drop[j].writeExternal(output);
			}			
		}
	}
}