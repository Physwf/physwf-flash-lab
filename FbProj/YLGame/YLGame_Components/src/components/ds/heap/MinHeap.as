package components.ds.heap
{
	import components.interfaces.INumerical;
	
	import flash.utils.Dictionary;
	
	public class MinHeap implements IHeap
	{
		/**
		 * i结点的父结点下标就为(i – 1) / 2。它的左右子结点下标分别为2 * i + 1和2 * i + 2
		 */
		private var heapVec:Vector.<INumerical>;
		private var heapSize:uint =0;
		private var itemFlag:Dictionary;//用来检查某元素是否在堆中
		
		public function MinHeap(size:uint)
		{
			//			heapVec = new Vector.<INumerical>(size,true);
			heapVec = new Vector.<INumerical>();
			heapSize = 0;
			itemFlag = new Dictionary();
		}
		
		/**
		 * 入列 
		 * @param item
		 * 
		 */		
		public function Enqueue(item:INumerical):void
		{
			heapVec[heapSize] = item;
			var lastIndex:uint = heapSize;//最后一个元素的索引
			var parentIndex:int =( lastIndex - 1) * .5;
			heapSize++;
			
			if(lastIndex==0) return;//第一个元素
			
			while(heapVec[parentIndex].value > item.value)
			{
				heapVec[lastIndex] = heapVec[parentIndex]
				heapVec[parentIndex] = item;
				lastIndex = parentIndex;
				parentIndex = ( lastIndex - 1) * .5;
				if(parentIndex<0) break;//说明已经到头
			}
			itemFlag[item] = true;
		}
		
		/**
		 * 出列 
		 * @return 
		 * 
		 */		
		public function Dequeue():INumerical
		{
			if(!heapSize) return null;
			var $min:INumerical = heapVec[0];
			heapSize--;
			heapVec[0] = heapVec[heapSize];//将堆尾移到堆顶
			
			var parentIndex:int =0;
			var childIndex:int;
			var temp:INumerical;
			temp=heapVec[0];
			childIndex=2*parentIndex+1;
			while(childIndex<heapSize)
			{
				if(childIndex+1<heapSize && heapVec[childIndex+1].value<heapVec[childIndex].value)
					childIndex++;
				if(heapVec[childIndex].value>=temp.value)
					break;
				heapVec[parentIndex] = heapVec[childIndex];
				parentIndex=childIndex;
				childIndex=2*parentIndex+1;
			}
			heapVec[parentIndex] = temp;
			delete itemFlag[$min];
			return $min;
		}
		
		/**
		 *最小项 
		 * @return 
		 * 
		 */		
		public function get min():INumerical
		{
			if(!heapVec.length)
				throw "空堆！";
			return heapVec[0];
		}
		
		public function hasItem(item:INumerical):Boolean
		{
			return itemFlag[item];
		}
		
		public function get size():int
		{
			return heapSize;
		}
		
		public function toString():String
		{
			return heapVec.toString();
		}
	}
}