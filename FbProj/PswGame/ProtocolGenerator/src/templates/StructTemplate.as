package templates
{
	public class StructTemplate
	{
		public var definition:String;
		
		public var className:String;
		
		public static var serverType:String;
		
		public var fileds:Vector.<FiledTemplate>;
		
		public function StructTemplate(rawData:XML)
		{
//			className = "S_"+serverType+"_"+rawData.@name;
			className = rawData.@name;
			fileds = new <FiledTemplate>[];
			for(var i:int=0;i<rawData.field.length();++i)
			{
				fileds.push(new FiledTemplate(rawData.field[i]));
			}
		}
		
		public function getDefinition():void
		{
			var nameReg:RegExp = new RegExp("{className}","g");
			definition = definition.replace(nameReg,className);
			for(var i:int=0;i<fileds.length;++i)
			{
				fileds[i].getFiled();
				fileds[i].getMethod("r");
				fileds[i].getMethod("w");
				definition = definition.replace("{filed}",fileds[i].filed_declaration + (i+1<fileds.length?"\n\t\t{filed}":"\n\t\t"));
				definition = definition.replace("{read}",fileds[i].read_method+(i+1<fileds.length?"\n\t\t\t{read}":"\n\t\t\t"));
				definition = definition.replace("{write}",fileds[i].write_method+(i+1<fileds.length?"\n\t\t\t{write}":"\n\t\t\t"));
			}
		}
	}
}