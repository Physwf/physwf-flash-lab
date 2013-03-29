package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_skill_v implements IExternalizable
	{
		public var skill_vec:Vector.<stru_skill_t>;
		
		public function stru_skill_v()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var skill_vecLen:uint =input.readUnsignedInt();
			skill_vec= new Vector.<stru_skill_t>();
			for(var i:int=0;i<skill_vecLen;++i)
			{
				var skill_vec_item:stru_skill_t = new stru_skill_t()
				skill_vec_item.readExternal(input);;
				skill_vec.push(skill_vec_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(skill_vec.length);
			for(var j:int=0;j<skill_vec.length;++j)
			{
				skill_vec[j].writeExternal(output);
			}			
		}
	}
}