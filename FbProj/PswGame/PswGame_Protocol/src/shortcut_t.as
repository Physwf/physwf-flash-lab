package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class shortcut_t implements IExternalizable
	{
		public var shortcuts:Vector.<uint>;
		
		public function shortcut_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			shortcuts= new Vector.<uint>();
			for(var i:int=0;i<10;++i)
			{
				var shortcuts_item:uint = input.readUnsignedInt();
				shortcuts.push(shortcuts_item)
			}
			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			for(var j:int=0;j<10;++j)
			{
				output.writeUnsignedInt(shortcuts[j])
			}
			
		}
	}
}