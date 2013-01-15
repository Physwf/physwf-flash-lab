package test {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	
	public class TranditionGlowFilter extends Sprite {
		private var bgColor:uint = 0xFFCC00;
		private var size:uint    = 80;
		private var offset:uint  = 100;
		
		public function TranditionGlowFilter() {
			draw();
			var filter:BitmapFilter = getBitmapFilter();
			var myFilters:Array = new Array();
			myFilters.push(filter);
			filters = myFilters;
		}
		
		private function getBitmapFilter():BitmapFilter {
			var color:Number = 0x33CCFF;
			var alpha:Number = 1;
			var blurX:Number = 15;
			var blurY:Number = 35;
			var strength:Number = 2;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			
			return new GlowFilter(color,
				alpha,
				blurX,
				blurY,
				strength,
				quality,
				inner,
				knockout);
		}
		
		private function draw():void {
			graphics.beginFill(bgColor);
//			graphics.drawRect(offset, offset, size, size);
			graphics.drawCircle(offset,offset, size);
			graphics.endFill();
		}
	}
}