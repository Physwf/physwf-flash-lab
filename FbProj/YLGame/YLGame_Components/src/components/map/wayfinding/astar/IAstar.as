package components.map.wayfinding.astar 
{
	

	/**
	 * 执行寻路动作的接口
	 * 具体实现BiHeapAStar 
	 * @author joe
	 * 
	 */
	public interface IAstar 
	{
		function analyze(navData:Vector.<uint>,row:uint,column:uint):void;
		/**
		 * 尝试在起点和终点之间寻到一条道路 
		 * @param sx
		 * @param sy
		 * @param ex
		 * @param ey
		 * @return 寻路是否成功
		 * 
		 */		
		function tryFindPath(sx:int,sy:int,ex:int,ey:int):Boolean;
		/**
		 *在 寻路成功之后 通过该方法可以获得该路径节点列表
		 * @return 起点和终点之间的路径节点列表
		 * 
		 */		
		function getPath():Vector.<Node>;
		/**
		 *  在 寻路成功之后 通过该方法可以获得该路径的线段列表
		 * @return 
		 * 
		 */		
		function getPathLine():Vector.<Line>;		
	} // end interface
} // end package