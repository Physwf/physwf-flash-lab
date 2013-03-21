package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_inflect_t implements IExternalizable
	{
		public var inflect:Vector.<xml_inflect_inflect_t>;
		
		public function xml_inflect_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var inflectLen:uint =input.readUnsignedInt();
			inflect= new Vector.<xml_inflect_inflect_t>();
			for(var i:int=0;i<inflectLen;++i)
			{
				var inflect_item:xml_inflect_inflect_t = new xml_inflect_inflect_t()
				inflect_item.readExternal(input);;
				inflect.push(inflect_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(inflect.length);
			for(var j:int=0;j<inflect.length;++j)
			{
				inflect[j].writeExternal(output);
			}			
		}
	}
}