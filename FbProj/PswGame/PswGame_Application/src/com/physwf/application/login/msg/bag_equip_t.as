package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class bag_equip_t implements IExternalizable
	{
		public var equip:stru_equip_t;
		public var grid:uint;
		
		public function bag_equip_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			equip= new stru_equip_t();
			equip.readExternal(input)
			grid = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			equip.writeExternal(output)
			output.writeShort(grid);			
		}
	}
}