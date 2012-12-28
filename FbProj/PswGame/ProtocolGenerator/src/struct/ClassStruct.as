package struct
{
	public class ClassStruct
	{
		public var name:String;
		public var fields:Vector.<FieldStruct>;
		
		public function ClassStruct(rawData:XML)
		{
			name = rawData.@name;
			fields = new <FieldStruct>[];
			for(var i:int=0;i<rawData.field.length();++i)
			{
				fields.push(new FieldStruct(rawData.field[i]));
			}
		}
	}
}