package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class mail_info_t implements IExternalizable
	{
		public var mail_head:mail_head_t;
		public var mail_body:mail_body_t;
		
		public function mail_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			mail_head= new mail_head_t();
			mail_head.readExternal(input)
			mail_body= new mail_body_t();
			mail_body.readExternal(input)			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			mail_head.writeExternal(output)
			mail_body.writeExternal(output)			
		}
	}
}