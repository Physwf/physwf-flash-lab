package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class path_node_t implements IExternalizable
	{
		public var x:uint;
		public var y:uint;
		public var cost:uint;
		
		public function path_node_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			x = input.readUnsignedShort();
			y = input.readUnsignedShort();
			cost = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(x);
			output.writeShort(y);
			output.writeUnsignedInt(cost);			
		}
	}
}