package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class btl_action_eff_t implements IExternalizable
	{
		public var eff_target:uint;
		public var type:uint;
		public var values:Vector.<uint>;
		
		public function btl_action_eff_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			eff_target = input.readUnsignedInt();
			type = input.readUnsignedByte();
			values= new Vector.<uint>();
			for(var i:uint=0;i<2;i++)
			{
				var values_item:uint = input.readUnsignedInt();
				values.push(values_item)
			}
			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(eff_target);
			output.writeByte(type);
						for(var i:uint=0;i<2;i++)
			{
				output.writeUnsignedInt(values[i])
			}
			
		}
	}
}