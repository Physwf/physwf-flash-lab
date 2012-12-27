package com.physwf.components.ds.heap
{
	import com.physwf.components.interfaces.INumerical;
	
	public class MaxHeap implements IHeap
	{
		private var _size:int;
		private var _heapVec:Vector.<INumerical>;
		
		public function MaxHeap(size:int,fixed:Boolean=false)
		{
			_heapVec = new Vector.<INumerical>(size,fixed);
			_size=0;
		}
		
		public function Enqueue(item:INumerical):void
		{
			var lastIndex:int = _size;//最后一个元素的索引
			var parentIndex:int = (lastIndex-1)*.5;//最后一个元素的父亲的索引
			_size++;
			
			if(lastIndex==0) return;
			
			while(_heapVec[parentIndex].value<item.value)
			{
				_heapVec[lastIndex] = _heapVec[parentIndex];
				_heapVec[parentIndex] = item;
				lastIndex = parentIndex;
				parentIndex = (lastIndex-1)*.5;
				if(parentIndex<0) break;
			}
		}
		
		public function Dequeue():INumerical
		{
			if(_size == 0) return null;
			
			var max:INumerical = _heapVec[0];
			_size -- ;
			_heapVec[0] = _heapVec[_size];
			
			var parentIndex:int = 0;
			var childIndex:int = 2*parentIndex + 1;
			var temp:INumerical = _heapVec[parentIndex];
			
			while(childIndex<_size)
			{
				if(childIndex+1<_size && _heapVec[childIndex]<_heapVec[childIndex+1])
					childIndex ++;
				if(_heapVec[childIndex].value<=temp.value)
					break;
				_heapVec[parentIndex] = _heapVec[childIndex];
				parentIndex = childIndex;
				childIndex = 2*parentIndex+1;
			}
			_heapVec[parentIndex] = temp;
			return max;
		}
		
		public function hasItem(item:INumerical):Boolean
		{
			return (_heapVec.indexOf(item)>-1);
		}
		
		public function get max():INumerical
		{
			return _heapVec[0];
		}
		
		public function get size():int
		{
			return _size;
		}
	}
}