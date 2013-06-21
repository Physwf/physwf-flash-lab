package components.bitmap.data
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	public class Key implements IExternalizable
	{
		public var actionNames:Vector.<String>;
		//						actions|directions|frame num
		public var frames:Vector.<Vector.<uint>>;
		
		public function Key()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var numActions:uint = input.readUnsignedByte();
			actionNames = new Vector.<String>(numActions,true);
			for(var k:uint=0;k<numActions;++k)
			{
				var len:uint = input.readUnsignedByte();
				var name:String = input.readUTFBytes(len);
				actionNames[k]=name;
			}
			frames = new Vector.<Vector.<uint>>(8,true);
			for(var i:uint=0;i<numActions;++i)
			{
				var dir:uint = input.readUnsignedByte();
				var dirLen:uint = input.readUnsignedByte();
				frames[dir] = new Vector.<uint>(dirLen,true);
				for(var j:uint=0;j<dirLen;++j)
				{
					frames[dir][j] = input.readUnsignedByte();
				}
			}
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeByte(actionNames.length);
			for each(var name:String in actionNames)
			{
				var nameData:ByteArray = new ByteArray();
				nameData.writeUTFBytes(name);
				output.writeByte(nameData.length);
				output.writeBytes(nameData);
			}
			for(var i:uint=0;i<frames.length;++i)
			{
				if(frames[i])
				{
					output.writeByte(i);
					output.writeByte(frames[i].length);
					for each(var num:uint in frames[i])
					{
						output.writeByte(num);
					}
				}
			}
		}
	}
}