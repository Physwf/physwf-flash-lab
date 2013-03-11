package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class msg_list_t implements IExternalizable
	{
		public var msg_list:Vector.<msg_t>;
		
		public function msg_list_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var msg_listLen:uint =input.readUnsignedInt();
			msg_list= new Vector.<msg_t>();
			for(var i:int=0;i<msg_listLen;++i)
			{
				var msg_list_item:msg_t = new msg_t()
				msg_list_item.readExternal(input);;
				msg_list.push(msg_list_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(msg_list.length);
			for(var j:int=0;j<msg_list.length;++j)
			{
				msg_list[j].writeExternal(output);
			}			
		}
	}
}