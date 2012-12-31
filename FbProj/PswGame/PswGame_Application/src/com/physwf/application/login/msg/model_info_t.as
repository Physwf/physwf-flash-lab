package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class model_info_t implements IExternalizable
	{
		public var resource_id:uint;
		
		public function model_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			resource_id = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(resource_id);			
		}
	}
}