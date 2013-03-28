package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_map_monster_dialog_t implements IExternalizable
	{
		public var type:uint;
		public var content:String;
		public var content_data:ByteArray
		public var triggerTime:uint;
		public var isLoop:uint;
		public var cycleInterval:uint;
		
		public function xml_map_monster_dialog_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			type = input.readUnsignedByte();
			var contentLen:uint =input.readUnsignedInt();
			content=input.readUTFBytes(contentLen);
			triggerTime = input.readUnsignedInt();
			isLoop = input.readUnsignedInt();
			cycleInterval = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeByte(type);
			output.writeUnsignedInt(content.length);
			output.writeUTFBytes(content);
			output.writeUnsignedInt(triggerTime);
			output.writeUnsignedInt(isLoop);
			output.writeUnsignedInt(cycleInterval);			
		}
	}
}