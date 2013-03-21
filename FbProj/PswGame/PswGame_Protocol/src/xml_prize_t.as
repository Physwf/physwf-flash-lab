package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_prize_t implements IExternalizable
	{
		public var prize:Vector.<xml_prize_prize_t>;
		
		public function xml_prize_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var prizeLen:uint =input.readUnsignedInt();
			prize= new Vector.<xml_prize_prize_t>();
			for(var i:int=0;i<prizeLen;++i)
			{
				var prize_item:xml_prize_prize_t = new xml_prize_prize_t()
				prize_item.readExternal(input);;
				prize.push(prize_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(prize.length);
			for(var j:int=0;j<prize.length;++j)
			{
				prize[j].writeExternal(output);
			}			
		}
	}
}