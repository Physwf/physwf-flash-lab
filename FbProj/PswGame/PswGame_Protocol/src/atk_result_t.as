package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class atk_result_t implements IExternalizable
	{
		public var src_type:uint;
		public var src_id:uint;
		public var direction:uint;
		public var skill_id:uint;
		public var objs:Vector.<btl_obj_t>;
		
		public function atk_result_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			src_type = input.readUnsignedByte();
			src_id = input.readUnsignedInt();
			direction = input.readUnsignedByte();
			skill_id = input.readUnsignedShort();
			var objsLen:uint =input.readUnsignedInt();
			objs= new Vector.<btl_obj_t>();
			for(var i:int=0;i<objsLen;++i)
			{
				var objs_item:btl_obj_t = new btl_obj_t()
				objs_item.readExternal(input);;
				objs.push(objs_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeByte(src_type);
			output.writeUnsignedInt(src_id);
			output.writeByte(direction);
			output.writeShort(skill_id);
			output.writeUnsignedInt(objs.length);
			for(var j:int=0;j<objs.length;++j)
			{
				objs[j].writeExternal(output);
			}			
		}
	}
}