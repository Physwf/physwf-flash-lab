package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_genius_t implements IExternalizable
	{
		public var genius:Vector.<xml_genius_genius_t>;
		
		public function xml_genius_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var geniusLen:uint =input.readUnsignedInt();
			genius= new Vector.<xml_genius_genius_t>();
			for(var i:int=0;i<geniusLen;++i)
			{
				var genius_item:xml_genius_genius_t = new xml_genius_genius_t()
				genius_item.readExternal(input);;
				genius.push(genius_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(genius.length);
			for(var j:int=0;j<genius.length;++j)
			{
				genius[j].writeExternal(output);
			}			
		}
	}
}