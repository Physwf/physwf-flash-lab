package file
{
	public interface IClientFile
	{
		function readExcel(sheet:Array):void;
		function write(name:String,struct:String):void;
	}
}