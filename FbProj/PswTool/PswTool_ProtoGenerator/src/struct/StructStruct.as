package struct
{
	public class StructStruct
	{
		public var template:String;
		public static var packageName:String;
		public var name:String;
		public var fields:Vector.<FieldStruct>;
		
		public function StructStruct(rawData:XML)
		{
			name = rawData.@name;
			fields = new <FieldStruct>[];
			for(var i:int=0;i<rawData.field.length();++i)
			{
				fields.push(new FieldStruct(rawData.field[i]));
			}
		}
		
		public function getDefinitioin():String
		{
			var nameReg:RegExp = new RegExp("{className}","g");
			template = template.replace(nameReg,name);
			template = template.replace("{package}",packageName);
			checkEmpty();
			MethodStruct.refreshFlag();
			for(var i:int=0;i<fields.length;++i)
			{
				template = template.replace("{filed}",fields[i].getDeclaration() + (i+1<fields.length?"\n\t\t{filed}":"\n\t\t"));
				template = template.replace("{read}",fields[i].method.getRead()+(i+1<fields.length?"\n\t\t\t{read}":"\t\t\t"));
			}
			MethodStruct.refreshFlag();
			for(i=0;i<fields.length;++i)
			{
				
				template = template.replace("{write}",fields[i].method.getWrite()+(i+1<fields.length?"\n\t\t\t{write}":"\t\t\t"));
			}
			return template;
		}
		
		private function checkEmpty():void
		{
			if(fields.length == 0)
			{
				template = template.replace("{filed}","");
				template = template.replace("{read}","");
				template = template.replace("{write}","");
			}
		}
	}
}