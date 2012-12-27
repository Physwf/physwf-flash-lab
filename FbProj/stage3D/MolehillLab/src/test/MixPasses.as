package test
{
	/**
	 * Copyright bongiovi015 ( http://wonderfl.net/user/bongiovi015 )
	 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
	 * Downloaded from: http://wonderfl.net/c/2nDz
	 */

	import com.bit101.components.HSlider;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
//	[SWF(width="465", height="465", frameRate="60", backgroundColor="0")]
	
	public class MixPasses extends Sprite 
	{
		public var loaderImage : Loader = new Loader;
		public var W : int = 465;
		public var H : int = 465;
		private var _bmpd:BitmapData;
		private var context:Context3D;
		private var _passDisplacement:PassDisplacement;
		private var _seed:int = Math.random() * 0xFFFF;
		private var _offsets:Array = [new Point, new Point];
		private var _bmpdPerlin:BitmapData;
		private var vbuffer:VertexBuffer3D;
		private var ibuffer:IndexBuffer3D;
		private var _sliderSize:HSlider;
		private var _passGrayscale:PassGrayscale;
		
		private var _texture:Texture;
		
		public function MixPasses() 
		{
			loaderImage.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoaded);
			loaderImage.load(new URLRequest("http://www.bongiovi.tw/wonderfl/rock.jpg"), new LoaderContext(true));
		}
		
		
		private function imgLoaded(e:Event) : void 
		{
			_bmpd = getBitampData(Bitmap(loaderImage.content), 512, 512);
			stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, _onContext);
			stage.stage3Ds[0].requestContext3D();
		}
		
		private function _onContext(e:Event) : void 
		{
			context = stage.stage3Ds[0].context3D;
			context.configureBackBuffer(W, H, 1, false);
			context.enableErrorChecking = true;
			
			_initShader();
			_initBuffer();
			_initTexture();
			_sliderSize = new HSlider(this, 5, 5);
			_sliderSize.value = 50;
			
			addEventListener(Event.ENTER_FRAME, _loop);
		}
		
		
		private function _initTexture() : void {
			_texture = createTexture(context, _bmpd);
			context.setTextureAt(0, _texture);
			_bmpdPerlin = new BitmapData(_bmpd.width, _bmpd.height, false, 0);
		}
		
		
		private function _loop(e:Event):void 
		{
			_bmpdPerlin.perlinNoise(_bmpd.width, _bmpd.height, 2, _seed, false, true, 3, false, _offsets);
			_offsets[0].x += .5;
			_offsets[1].y += .5;
			
			var texturePerlin:Texture = createTexture(context, _bmpdPerlin);
			context.setTextureAt(0, _texture);
			context.setTextureAt(1, texturePerlin);
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, Vector.<Number>([-.5, -.5, _sliderSize.value/100, 0]) );
			_passDisplacement.render(ibuffer);
			
			context.setTextureAt(0, _passDisplacement.getTexture());
			context.setTextureAt(1, null);
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, Vector.<Number>([3, 0, 0, 0]) );
			_passGrayscale.render(ibuffer);
			context.present();
		}
		
		
		private function _initBuffer() : void 
		{
			vbuffer = context.createVertexBuffer(4, 5);
			ibuffer = context.createIndexBuffer(6);
			
			var imageSize:Number = 1;
			var vbuf:Vector.<Number> = Vector.<Number>([
				-imageSize,  imageSize, 0,         0, 0,
				imageSize,  imageSize, 0,        1, 0,
				imageSize,  -imageSize, 0,        1, 1,
				-imageSize,  -imageSize, 0,        0, 1
			]);
			
			vbuffer.uploadFromVector(vbuf, 0, 4);
			ibuffer.uploadFromVector(Vector.<uint>([0, 1, 2, 0, 2, 3]), 0, 6);
			
			context.setVertexBufferAt(0, vbuffer, 0, "float3");
			context.setVertexBufferAt(1, vbuffer, 3, "float2");
		}
		
		private function _initShader() : void 
		{
			_passDisplacement = new PassDisplacement(context, false, true, 512, 512);
			_passDisplacement.assemble();
			_passGrayscale = new PassGrayscale(context, true, false);
			_passGrayscale.assemble();
		}
		
		
		public static function createTexture(context:Context3D, source:BitmapData):Texture 
		{
			var w:Number, h:Number, level:int=0;
			w = source.width, h = source.height;
			var texture:Texture = context.createTexture(w, h, Context3DTextureFormat.BGRA, true);
			var bmpd:BitmapData;
			var mtx:Matrix = new Matrix;
			while(w&&h) {
				bmpd = new BitmapData(w, h, true, 0);
				bmpd.draw(source, mtx, null, null, null, true);
				texture.uploadFromBitmapData(bmpd, level);
				w >>= 1;
				h >>= 1;
				mtx.scale(.5, .5);
				level++;
			}
			bmpd.dispose();
			return texture;
		}
		
		
		public function getBitampData(bmp:Bitmap, targetWidth:Number, targetHeight:Number) : BitmapData 
		{
			var mtx:Matrix = new Matrix();
			mtx.scale(targetWidth/bmp.width, targetHeight/bmp.height);
			var bmpd:BitmapData = new BitmapData(targetWidth, targetHeight, false, 0);
			bmpd.draw(bmp, mtx, null, null, null, true);
			return bmpd;
		}
		
	}
	
}


import com.adobe.utils.AGALMiniAssembler;

import flash.display3D.Context3D;
import flash.display3D.Context3DProgramType;
import flash.display3D.Context3DTextureFormat;
import flash.display3D.IndexBuffer3D;
import flash.display3D.Program3D;
import flash.display3D.textures.Texture;
import flash.utils.ByteArray;

class Pass {
	protected static const agal:AGALMiniAssembler = new AGALMiniAssembler();
	protected var _shaderVertex:String;
	protected var _shaderFragment:String;
	protected var _program:Program3D;
	protected var _context:Context3D;
	protected var _isRenderBackToBuffer:Boolean;
	protected var _isRenderToTexture:Boolean;
	protected var _texture:Texture;
	
	
	public function Pass(context:Context3D, isRenderBackToBuffer:Boolean, isRenderToTexture:Boolean, width:Number=1, height:Number=1) {
		_context = context;
		_isRenderBackToBuffer = isRenderBackToBuffer;
		_isRenderToTexture = isRenderToTexture;
		if(_isRenderToTexture) _texture = _context.createTexture(width, height, Context3DTextureFormat.BGRA, true);
	}
	
	
	public function assemble() : void {
		var vertexShader:ByteArray = agal.assemble(Context3DProgramType.VERTEX, _shaderVertex);
		var fragmentShader:ByteArray = agal.assemble(Context3DProgramType.FRAGMENT, _shaderFragment);
		_program = _context.createProgram();
		_program.upload(vertexShader, fragmentShader);
	}
	
	
	public function render(iBuffer:IndexBuffer3D) : void {
		if(_isRenderBackToBuffer)     _context.setRenderToBackBuffer();
		else    _context.setRenderToTexture(_texture, false, 1);
		
		_context.clear(0, 0, 0, 0);
		_context.setProgram(_program);
		_context.drawTriangles(iBuffer);
	}
	
	public function getTexture() : Texture {    return _texture;    }
	
}


import flash.display3D.Context3D;

class PassDisplacement extends Pass {
	public function PassDisplacement(context:Context3D, isRenderBackToBuffer:Boolean, isRenderToTexture:Boolean, width:Number=1, height:Number=1) {
		super(context, isRenderBackToBuffer, isRenderToTexture, width, height);
		
		_shaderVertex = "" +
			"mov op, va0\n" +
			"mov v0, va1\n";
		
		
		_shaderFragment = "" +
			"tex ft0, v0, fs1, <2d,clamp,linear,miplinear>\n" +            //     map perlin(fs1) to ft0
			"add ft1, ft0, fc0\n" +                                //     displacement ( x-.5, y-.5)
			"mul ft1, ft1, fc0.z\n" +                            //     multiply by the size
			"add ft2, v0, ft1\n" +                                //     add to coordinate
			"tex oc, ft2, fs0, <2d,clamp,linear,miplinear>\n";            //    map to outpur color
	}
}


import flash.display3D.Context3D;

class PassGrayscale extends Pass {
	public function PassGrayscale(context:Context3D, isRenderBackToBuffer:Boolean, isRenderToTexture:Boolean, width:Number=1, height:Number=1) {
		super(context, isRenderBackToBuffer, isRenderToTexture, width, height);
		
		_shaderVertex = "" +
			"mov op, va0\n" +
			"mov v0, va1\n";
		
		_shaderFragment = "" +
			"tex ft0, v0, fs0 <2d,linear,clamp>\n" +
			"add ft1.x, ft0.x, ft0.y\n" +
			"add ft1.x, ft1.x, ft0.z\n" +
			"div ft1.x, ft1.x, fc0.x\n" +
			"mov ft0.xyz, ft1.xxx\n" +
			"mov oc ft0\n";        
	}
}
