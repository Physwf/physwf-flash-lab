package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_map_item_monster_t implements IExternalizable
	{
		public var id:uint;
		public var x:uint;
		public var y:uint;
		public var partolType:uint;
		public var partolRange:uint;
		public var refreshInterval:uint;
		public var face:uint;
		public var pursuitRange:uint;
		public var dialog:Vector.<xml_map_monster_dialog_t>;
		
		public function xml_map_item_monster_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			x = input.readUnsignedShort();
			y = input.readUnsignedShort();
			partolType = input.readUnsignedInt();
			partolRange = input.readUnsignedInt();
			refreshInterval = input.readUnsignedInt();
			face = input.readUnsignedInt();
			pursuitRange = input.readUnsignedInt();
			var dialogLen:uint =input.readUnsignedInt();
			dialog= new Vector.<xml_map_monster_dialog_t>();
			for(var i:int=0;i<dialogLen;++i)
			{
				var dialog_item:xml_map_monster_dialog_t = new xml_map_monster_dialog_t()
				dialog_item.readExternal(input);;
				dialog.push(dialog_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(id);
			output.writeShort(x);
			output.writeShort(y);
			output.writeUnsignedInt(partolType);
			output.writeUnsignedInt(partolRange);
			output.writeUnsignedInt(refreshInterval);
			output.writeUnsignedInt(face);
			output.writeUnsignedInt(pursuitRange);
			output.writeUnsignedInt(dialog.length);
			for(var j:int=0;j<dialog.length;++j)
			{
				dialog[j].writeExternal(output);
			}			
		}
	}
}