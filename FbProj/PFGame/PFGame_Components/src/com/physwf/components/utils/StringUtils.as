package com.physwf.components.utils
{
	public class StringUtils
	{
		public function StringUtils()
		{
		}
		
		public static function trim(str:String):String
		{
			while(str.charAt(0) == " ")
			{
				str = str.slice(1);
			}
			
			while(str.charAt(str.length-1) == " ")
			{
				str = str.slice(0,str.length-1);
			}	
			return str;
		}
	}
}