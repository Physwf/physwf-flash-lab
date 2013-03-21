package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_buff_t implements IExternalizable
	{
		public var buff:Vector.<xml_buff_buff_t>;
		
		public function xml_buff_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var buffLen:uint =input.readUnsignedInt();
			buff= new Vector.<xml_buff_buff_t>();
			for(var i:int=0;i<buffLen;++i)
			{
				var buff_item:xml_buff_buff_t = new xml_buff_buff_t()
				buff_item.readExternal(input);;
				buff.push(buff_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(buff.length);
			for(var j:int=0;j<buff.length;++j)
			{
				buff[j].writeExternal(output);
			}			
		}
	}
}