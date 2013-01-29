package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class session_login_flag_t implements IExternalizable
	{
		public var login_flag:uint;
		
		public function session_login_flag_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			login_flag = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(login_flag);			
		}
	}
}