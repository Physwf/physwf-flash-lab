package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_attr_t implements IExternalizable
	{
		public var attribute:Vector.<xml_attr_attr_t>;
		
		public function xml_attr_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var attributeLen:uint =input.readUnsignedInt();
			attribute= new Vector.<xml_attr_attr_t>();
			for(var i:int=0;i<attributeLen;++i)
			{
				var attribute_item:xml_attr_attr_t = new xml_attr_attr_t()
				attribute_item.readExternal(input);;
				attribute.push(attribute_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(attribute.length);
			for(var j:int=0;j<attribute.length;++j)
			{
				attribute[j].writeExternal(output);
			}			
		}
	}
}