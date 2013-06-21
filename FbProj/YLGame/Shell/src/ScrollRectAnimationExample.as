/**
 * Copyright leichtgewicht ( http://wonderfl.net/user/leichtgewicht )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/gLTR
 */

/**
 * Modified code from Lee Brimelow posted here : https://plus.google.com/110495278155587072613/posts/U8oXcET3TE9
 *
 * Performance example of using .scrollRect to draw a animation.
 */
package {
	import flash.display.StageQuality;
	import flash.utils.describeType;
	import flash.display.LoaderInfo;
	import flash.display.Bitmap;
	import flash.system.LoaderContext;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Security;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.BitmapData;
	
	
	[SWF(frameRate=60)]
	public class ScrollRectAnimationExample extends Sprite
	{
		// Holds all current blit sprites
		private var animations:Vector.<ScrollRectAnimation> = new Vector.<ScrollRectAnimation>();
		private var numAnimations:int = 0;
		
		public function ScrollRectAnimationExample()
		{
//			Security.loadPolicyFile("http://assets.wonderfl.net/crossdomain.xml");
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.MEDIUM;
			
			// WonderFl Specific loading
			var imageLoader: Loader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, init );
			imageLoader.load(  new URLRequest( "aa1e38cac5ca15481f555e095be7e4f0c86ac3fa.png" ), new LoaderContext(true) );
		}
		
		private function init(e:Event):void
		{
			// Initializes the sprite sheet frames
			SnakeData.init(Bitmap( LoaderInfo(e.target).content ).bitmapData);
			
			// You gotta track that shit
//			addChild(new Stats());
			
			// Start with 50, good to compare
			addAnimations(10);
			
			// When you click the stage you get 10 more
			stage.addEventListener(MouseEvent.CLICK, onClick);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			// Create another 10 more
			addAnimations(10);
		}
		
		protected function addAnimations(amount:int):void
		{
			for(var i:int=0; i<amount; ++i)
			{
				var s:ScrollRectAnimation = new ScrollRectAnimation(SnakeData.sheet, SnakeData.rects, SnakeData.maxSize);;
				s.x = Math.random() * stage.stageWidth;
				s.y = Math.random() * stage.stageHeight;
				addChildAt(s,0);
				animations.push(s);
			}
			numAnimations = animations.length;
		}
		
		protected function loop(event:Event):void
		{
			// Loop through snakes and render them
			for(var i:int=0; i<numAnimations; ++i)
			{
				var ani:ScrollRectAnimation = animations[i];
				ani.rotation += 2.0;
				ani.render();
			}
		}
	}
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.geom.Point;


/* This class is generated from the JSON that was exported from Texture 
Packer. It contains the rects for all the frames that are in the sprite 
sheet. They are stored in a static vector. */                

class SnakeData {
	
	public static const maxSize:Rectangle = new Rectangle();
	public static const rects:Vector.<Rectangle> = new Vector.<Rectangle>(20);
	{
		rects[0] = new Rectangle(0,0,106,62);
		rects[1] = new Rectangle(106,0,104,62);
		rects[2] = new Rectangle(210,0,104,64);
		rects[3] = new Rectangle(314,0,102,64);
		rects[4] = new Rectangle(0,64,100,64);
		rects[5] = new Rectangle(100,64,100,64);
		rects[6] = new Rectangle(200,64,100,64);
		rects[7] = new Rectangle(300,64,100,64);
		rects[8] = new Rectangle(400,64,98,66);
		rects[9] = new Rectangle(0,130,100,64);
		rects[10] = new Rectangle(100,130,100,66);
		rects[11] = new Rectangle(200,130,100,66);
		rects[12] = new Rectangle(300,130,100,66);
		rects[13] = new Rectangle(400,130,100,66);
		rects[14] = new Rectangle(0,196,102,64);
		rects[15] = new Rectangle(102,196,102,64);
		rects[16] = new Rectangle(204,196,104,64);
		rects[17] = new Rectangle(308,196,106,64);
		rects[18] = new Rectangle(0,260,106,62);
		rects[19] = new Rectangle(106,260,106,64);
	}
	public static var sheet:BitmapData;
	
	public static function init(data:BitmapData):void
	{
		sheet = data;
		var rect: Rectangle;
		var i: int;
		for( i = 0; i<rects.length; ++i){
			rect = rects[i];
			if( rect.width > maxSize.width ) {
				maxSize.width = rect.width;
			}
			if( rect.height > maxSize.height ) {
				maxSize.height = rect.height;
			}
		}
	}
}

class ScrollRectAnimation extends Sprite
{
	// Main Bitmap
	private var bm:Bitmap;
	private var bmContainer:Sprite;
	
	// The rects of all of the frames
	public var framesRects:Vector.<Rectangle>;
	
	// Keeps track on current frame
	private var frame:uint = 0;
	private var frames:uint;
	
	public function ScrollRectAnimation(sheet:BitmapData, framesRects:Vector.<Rectangle>, size:Rectangle)
	{
		this.framesRects = framesRects;
		
		frame = Math.random()*frames;
		frames = framesRects.length;
		
		// Setup main bitmap
		bm = new Bitmap(sheet);
		bm.smoothing = true;
		
		mouseChildren = false;
		mouseEnabled = false;
		
		bmContainer = new Sprite();
		bmContainer.x -= size.width * 0.5;
		bmContainer.y -= size.height * 0.5;
		bmContainer.addChild(bm);
		
		addChild(bmContainer);
	}
	
	public function render():void {
		// Determine what frame to show next
		( frame == frames-1) ? frame = 0 : ++frame;
		
		bmContainer.scrollRect = framesRects[frame];
	}
}

