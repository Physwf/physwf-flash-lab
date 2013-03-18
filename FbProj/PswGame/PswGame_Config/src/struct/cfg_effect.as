package struct
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	public class cfg_effect implements IExternalizable
	{
		public var id:uint;
		public var res_id:uint;
		public var name:String;
		public var dir_flag:uint;
		public var layer:uint;
		public var start_time:uint;
		public var duration:uint;
		public var repeat:uint;
		public var offset_X:uint;
		public var offset_Y:uint;
		public var type:uint;
		
		
		public function cfg_effect()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			res_id = input.readUnsignedInt();
			var nameLen:uint = input.readUnsignedShort();
			name = input.readUTFBytes(nameLen);
			dir_flag = input.readUnsignedInt();
			layer = input.readUnsignedInt();
			start_time = input.readUnsignedInt();
			duration = input.readUnsignedInt();
			repeat = input.readUnsignedInt();
			offset_X = input.readUnsignedInt();
			offset_Y = input.readUnsignedInt();
			type = input.readUnsignedInt();
			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(id);
			output.writeUnsignedInt(res_id);
			var nameData:ByteArray = new ByteArray();
			nameData.writeUTFBytes(name);
			output.writeShort(nameData.length);
			output.writeBytes(nameData);
			output.writeUnsignedInt(dir_flag);
			output.writeUnsignedInt(layer);
			output.writeUnsignedInt(start_time);
			output.writeUnsignedInt(duration);
			output.writeUnsignedInt(repeat);
			output.writeUnsignedInt(offset_X);
			output.writeUnsignedInt(offset_Y);
			output.writeUnsignedInt(type);
			
		}
		
	}
}