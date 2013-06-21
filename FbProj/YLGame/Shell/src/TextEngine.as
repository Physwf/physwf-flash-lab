package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.engine.ContentElement;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.GraphicElement;
	import flash.text.engine.GroupElement;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	
	public class TextEngine extends Sprite
	{
		public function TextEngine()
		{
			//绘制一个红色矩形来作为我们的图片
			
			var shape:Shape = new Shape();
			
			shape.graphics.beginFill(0xff0000);
			
			shape.graphics.drawRect(0, 0, 100, 100);
			
			shape.graphics.endFill();
			
			//建立一个图像元素，并将我们的 shape作为其显示的内容，同时也可以成为一个Loader
			
			var graphicEle:GraphicElement = new GraphicElement(shape, shape.width, shape.height);
			graphicEle.elementFormat = new ElementFormat(new FontDescription("Arial"));
			
			//建立一个文本元素
			
			var format:ElementFormat = new ElementFormat(new FontDescription("Arial"));
			
			format.fontSize = 12;
			
			var textEle:TextElement = new TextElement("Hello World!", format);
			
			//把所有刚刚建立的元素丢到一个 Vector里面，并且组合成一个组元素
			
			var eleVector:Vector.<ContentElement> = new Vector.<ContentElement>();
			
			eleVector.push(textEle,graphicEle);
			
			var groupEle:GroupElement = new GroupElement(eleVector);
			
			//建立一个文本块，用于装载图像元素并 输出行
			
			var textBlock:TextBlock = new TextBlock();
			
			textBlock.content = groupEle;
			
			var textLine:TextLine = textBlock.createTextLine(null, 300);
			
			textLine.x = 100;
			
			textLine.y = 100;
			
			addChild(textLine);
		}
	}
}