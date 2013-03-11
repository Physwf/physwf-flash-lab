package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class bag_item_t implements IExternalizable
	{
		public var item_id:uint;
		public var item_cnt:uint;
		public var grid:uint;
		
		public function bag_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			item_id = input.readUnsignedInt();
			item_cnt = input.readUnsignedInt();
			grid = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(item_id);
			output.writeUnsignedInt(item_cnt);
			output.writeShort(grid);			
		}
	}
}