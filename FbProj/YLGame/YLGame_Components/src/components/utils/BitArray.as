package components.utils
{
	import flash.utils.ByteArray;
	
	public class BitArray extends ByteArray
	{
		public function BitArray()
		{
			
		}
		
		public function setBit(index:uint):void
		{
			this[index>>3] |= ( 1 << (index & 0x7));
		}
		
		public function unsetBit(index:uint):void
		{
			this[index >> 3] &= 0xFF ^ (1 << (index & 0x7));
		}
		
		public function getBit(index:uint):Boolean
		{
			return ((this[index >> 3] & (1 << (index & 0x7))) != 0);
		}
	}
}