package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class grid_list_t implements IExternalizable
	{
		public var comm_grids:Vector.<bag_grid_t>;
		public var material_grids:Vector.<bag_grid_t>;
		public var task_grids:Vector.<bag_grid_t>;
		
		public function grid_list_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var comm_gridsLen:uint =input.readUnsignedInt();
			comm_grids= new Vector.<bag_grid_t>();
			for(var i:int=0;i<comm_gridsLen;++i)
			{
				var comm_grids_item:bag_grid_t = new bag_grid_t()
				comm_grids_item.readExternal(input);;
				comm_grids.push(comm_grids_item);
			}
			var material_gridsLen:uint =input.readUnsignedInt();
			material_grids= new Vector.<bag_grid_t>();
			for(var k:int=0;k<material_gridsLen;++k)
			{
				var material_grids_item:bag_grid_t = new bag_grid_t()
				material_grids_item.readExternal(input);;
				material_grids.push(material_grids_item);
			}
			var task_gridsLen:uint =input.readUnsignedInt();
			task_grids= new Vector.<bag_grid_t>();
			for(var q:int=0;q<task_gridsLen;++q)
			{
				var task_grids_item:bag_grid_t = new bag_grid_t()
				task_grids_item.readExternal(input);;
				task_grids.push(task_grids_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(comm_grids.length);
			for(var j:int=0;j<comm_grids.length;++j)
			{
				comm_grids[j].writeExternal(output);
			}
			output.writeUnsignedInt(material_grids.length);
			for(var p:int=0;p<material_grids.length;++p)
			{
				material_grids[p].writeExternal(output);
			}
			output.writeUnsignedInt(task_grids.length);
			for(var r:int=0;r<task_grids.length;++r)
			{
				task_grids[r].writeExternal(output);
			}			
		}
	}
}