package psw2d.render
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DCompareMode;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.Program3D;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import psw2d.Alcedo;
	import psw2d.core.Context2D;
	import psw2d.display.DisplayObject;
	import psw2d.display.Image;
	import psw2d.texture.Texture;
	
	public class ImageRender extends QuadRender
	{
		
		public function ImageRender(texture:Texture)
		{
			super(texture);
			_programNameCache = new Dictionary();
			_texture = texture;
			_texture && _texture.uploadData();
		}
		
		override protected function onContextCreated(e:Event):void
		{
			registerPrograms();
		}
		
		override public function addDisplay(display:DisplayObject, parentAlpha:Number=1.0, texture:Texture=null, 
											smoothing:String=null, modelViewMatrix:Matrix=null, 
											blendMode:String=null):DisplayObject
		{
			if(_numDisplays == 0)
			{
				_blendMode = blendMode;
				_smoothing = smoothing;
				_tinted = display.tined;
			}
			return super.addDisplay(display,parentAlpha,texture,smoothing,modelViewMatrix,blendMode);
		}
		
		override public function rebuildBuffer():void
		{
			var context:Context2D = Alcedo.context;
			super.rebuildBuffer();
			context.setVertexAndTextureForImage(_texture.base,_vertexBuffer);
		}
		
		
		override public function render(projectionMatrix:Matrix3D):void
		{
			var context:Context2D = Alcedo.context;
			context.setProjectionMatrix(projectionMatrix);
			context.setProgram(generateProgramName(_tinted,false));
			rebuildBuffer();
			context.drawTriangles(_indexBuffer,0,_quads.length * 2);
			context.clearBufferForImage();
		}
		
		override public function reset():void
		{
			super.reset();
			_smoothing = null;
			_tinted = false;
		}
		
		override public function canBatch(display:DisplayObject):Boolean
		{
			return getQualifiedClassName(display) == "psw2d.display.Image";
		}
		
		private static function registerPrograms():void
		{
			
			var vertexSrc:String;
			var fragmentSrc:String;
			
			
			var smoothingTypes:Array = [
				Texture.SMOOTHING_NONE,
				Texture.SMOOTING_BILINEAR,
				Texture.SMOOTHING_TRILINEAR
			];
			
			var formats:Array = [
				Context3DTextureFormat.BGRA,
				Context3DTextureFormat.COMPRESSED,
				"compressedAlpha" // use explicit string for compatibility
			];
			var vertexAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			
			
			for each(var tinted:Boolean in [true,false])
			{
				vertexSrc = tinted?
					"m44 op,va0,vc0 \n" +//坐标
					"mov v0,va1     \n" +//颜色
					"mov v1,va2 	\n"//材质
					:
					"m44 op,va0,vc0 \n" +
					"mov v1,va2     \n";//+//颜色
					
				
				vertexAssembler.assemble(Context3DProgramType.VERTEX,vertexSrc);
				
				fragmentSrc = tinted ?
					"tex ft0,v1,fs0 <???> 	\n" +
					"mul oc,ft0,v0			\n"
					:
					"tex oc,v1,fs0 <???>	\n";
				
				for each (var repeat:Boolean in [true, false])
				{
					for each (var mipmap:Boolean in [true, false])
					{
						for each (var smoothing:String in smoothingTypes)
						{
							for each (var format:String in formats)
							{
								var options:Array = ["2d", repeat ? "repeat" : "clamp"];
								
								if (format == Context3DTextureFormat.COMPRESSED)
									options.push("dxt1");
								else if (format == "compressedAlpha")
									options.push("dxt5");
								
								if (smoothing == Texture.SMOOTHING_NONE)
									options.push("nearest", mipmap ? "mipnearest" : "mipnone");
								else if (smoothing == Texture.SMOOTING_BILINEAR)
									options.push("linear", mipmap ? "mipnearest" : "mipnone");
								else
									options.push("linear", mipmap ? "miplinear" : "mipnone");
								
								fragmentAssembler.assemble(Context3DProgramType.FRAGMENT,
									fragmentSrc.replace("???", options.join()));
								Alcedo.context.registerProgram(
									generateProgramName(tinted, mipmap, repeat, format, smoothing),
									vertexAssembler.agalcode, fragmentAssembler.agalcode);
							}
						}
					}
				}
			}

		}
		/**
		 * 采用位标识来生成不同显示特性所对应的程序名称。
		 * 用一个二进制的数表示，从最低位开始，它们的标识含义如下：
		 * 	1/0							1/0						1/0						1/0					1/0		1/0		1/0
		 * 	format=="compressedAlpha"	format=="compressed"	smoothing=="trilinear"	smoothing=="none" 	repeat 	mipMap 	tinted
		 * @param tinted
		 * @param mipMap
		 * @param repeat
		 * @param format
		 * @param smoothing
		 * @return 
		 * 
		 */		
		private static var _programNameCache:Dictionary;
		private static function generateProgramName(tinted:Boolean, mipMap:Boolean=true, 
													repeat:Boolean=false, format:String="bgra",
													smoothing:String="bilinear"):String
		{
			var bitField:uint = 0;
			
			if (tinted) bitField |= 1;
			if (mipMap) bitField |= 1 << 1;
			if (repeat) bitField |= 1 << 2;
			
			if (smoothing == Texture.SMOOTHING_NONE)
				bitField |= 1 << 3;
			else if (smoothing == Texture.SMOOTHING_TRILINEAR)
				bitField |= 1 << 4;
			
			if (format == Texture.FORMAT_COMPRESSED)
				bitField |= 1 << 5;
			else if (format == "compressedAlpha")
				bitField |= 1 << 6;
			var name:String = _programNameCache[bitField];
			if(name==null)
			{
				name = "IR"+bitField.toString(16);
				_programNameCache[bitField] = name;
			}
			return name;
		}
	}
}