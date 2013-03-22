package com.physwf.config.struct
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	public class cfg_npc implements IExternalizable
	{
		public var npc_id:uint;
		public var npc_name:String;
		public var res_id:uint;
		public var width:uint;
		public var height:uint;
		
		
		public function cfg_npc()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			npc_id = input.readUnsignedInt();
			var npc_nameLen:uint = input.readUnsignedShort();
			npc_name = input.readUTFBytes(npc_nameLen);
			res_id = input.readUnsignedShort();
			width = input.readUnsignedShort();
			height = input.readUnsignedShort();
			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(npc_id);
			var npc_nameData:ByteArray = new ByteArray();
			npc_nameData.writeUTFBytes(npc_name);
			output.writeShort(npc_nameData.length);
			output.writeBytes(npc_nameData);
			output.writeShort(res_id);
			output.writeShort(width);
			output.writeShort(height);
			
		}
		
	}
}