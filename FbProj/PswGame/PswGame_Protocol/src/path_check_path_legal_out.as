package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class path_check_path_legal_out implements IExternalizable
	{
		public var result:uint;
		
		public function path_check_path_legal_out()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			result = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(result);			
		}
	}
}