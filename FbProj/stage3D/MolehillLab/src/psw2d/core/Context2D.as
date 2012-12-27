package psw2d.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.geom.Matrix3D;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import psw2d.texture.BitmapTexture;
	import psw2d.texture.Texture;
	import psw2d.utlis.QuadVertex;
	
	public class Context2D
	{
		[Event(name="context2DCreated",type="psw2d.events.Event")]
		
		private var _context3D:Context3D;
		private var _programs:Dictionary;
		private var _renderTarget:psw2d.texture.Texture;
		
		public function Context2D(context3D:Context3D)
		{
			_programs = new Dictionary();
			_context3D = context3D;
		}
		/**
		 * 设置正交投影 ，参数一般为舞台的宽高
		 * @param sW
		 * @param sH
		 * 
		 */		
		public function setOrthographicProjection(sW:Number,sH:Number):void
		{
			var pm:Matrix3D = new Matrix3D(Vector.<Number>(
				[
					2/sW, 0,  0, 0,
					0, -2/sH, 0, 0,
					0,  0,    0, 0,
					-1, 1,    0, 1
				]));
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,pm,true);
		}
		/**
		 * 
		 * @param matrix3d
		 * 
		 */		
		public function setProjectionMatrix(matrix3d:Matrix3D):void
		{
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,matrix3d,true);
		}
		/**
		 * 设置alpha混合模式 ，以后会扩充成为通用设置混合模式的接口
		 * @param blendMode 
		 * 
		 */		
		public function setAlphaBlend(blendMode:String):void
		{
			_context3D.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
		}
		/**
		 * 创建并上传顶点缓冲 
		 * @param numQuads
		 * @param vertexData
		 * @return 
		 * 
		 */		
		public function createVertexBuffer(numQuads:uint):VertexBuffer3D
		{
			var vBuffer:VertexBuffer3D = _context3D.createVertexBuffer(numQuads * 4 ,QuadVertex.ELEMENTS_PER_VERTEX);
			return vBuffer;
		}
		/**
		 * 创建并上传索引缓冲 
		 * @param numQuads
		 * @param indexData
		 * @return 
		 * 
		 */		
		public function createIndexBuffer(numQuads:uint):IndexBuffer3D
		{
			var iBuffer:IndexBuffer3D = _context3D.createIndexBuffer(numQuads * 6);
			return iBuffer;
		}
		/**
		 * 设置着色器程序 
		 * @param programName
		 * 
		 */		
		public function setProgram(programName:String):void
		{
			var program:Program3D = getProgram(programName);
			_context3D.setProgram(program);
		}
		/**
		 * 为Quad对象设置顶点缓冲 
		 * @param vertexBuffer
		 * 
		 */		
		public function setPosForVertex(vertexBuffer:VertexBuffer3D):void
		{
			_context3D.setVertexBufferAt(0,vertexBuffer,QuadVertex.POSSION_OFFSET,Context3DVertexBufferFormat.FLOAT_2);
		}
		/**
		 * 
		 * @param vertexBuffer
		 * 
		 */		
		public function setColorForVertex(vertexBuffer:VertexBuffer3D):void
		{
			_context3D.setVertexBufferAt(1,vertexBuffer,QuadVertex.COLOR_OFFSET,Context3DVertexBufferFormat.FLOAT_4);
		}
		/**
		 * 为Image对象设置顶点缓冲和材质 
		 * @param texture 原生的材质对象
		 * @param vertexBuffer 顶点缓冲
		 * 
		 */		
		public function setVertexAndTextureForImage(texture:flash.display3D.textures.Texture,vertexBuffer:VertexBuffer3D):void
		{
			_context3D.setTextureAt(0,texture);
			_context3D.setVertexBufferAt(2,vertexBuffer,QuadVertex.TEX_COORDS_OFFSET,Context3DVertexBufferFormat.FLOAT_2);
		}
		/**
		 * 对原生的绘制三角形API的封装 
		 * @param indexBuffer
		 * @param startIndex
		 * @param count
		 * 
		 */		
		public function drawTriangles(indexBuffer:IndexBuffer3D,startIndex:uint=0,count:int=-1):void
		{
			_context3D.drawTriangles(indexBuffer,startIndex,count);
		}
		/**
		 * 
		 * 
		 */		
		public function clear(r:Number=0,g:Number=0,b:Number=0,a:Number=1):void
		{
			_context3D.clear(r,g,b,a);
		}
		/**
		 * 
		 * 
		 */		
		public function present():void
		{
			_context3D.present();
		}
		
		/**
		 * 清理为绘制Quad对象使用过得缓冲 
		 * 
		 */		
		public function clearBufferForQuad():void
		{
			_context3D.setVertexBufferAt(0,null);
			_context3D.setVertexBufferAt(1,null);
		}
		/**
		 * 清理为绘制Image对象使用过得缓冲 
		 * 
		 */		
		public function clearBufferForImage():void
		{
			_context3D.setTextureAt(0,null);
			_context3D.setVertexBufferAt(0,null);
			_context3D.setVertexBufferAt(1,null);
			_context3D.setVertexBufferAt(2,null);
		}
		/**
		 * 创建材质对象 
		 * @param data 材质的数据，可以是位图,位图数据,或者位图数据的ByteArray数据，后面扩展增加ATF。
		 * @param mipMapping 是否mipMapping
		 * @return 
		 * 
		 */		
		public function createBitmapTexture(data:*,mipMapping:Boolean):BitmapTexture
		{
			var base:flash.display3D.textures.Texture;
			var ret:BitmapTexture;
			
			if(data is BitmapData || data is Bitmap)
			{
				base = _context3D.createTexture( data.width,data.height,Context3DTextureFormat.BGRA,false);
				ret = new BitmapTexture(base,data,mipMapping);
			}
			return ret;
		}
		/**
		 * 设定渲染目标 
		 * @param texture
		 * 
		 */		
		public function set renderTarget(texture:psw2d.texture.Texture):void
		{
			_renderTarget = texture;
			
			if(texture)
			{
				_context3D.setRenderToTexture(texture.base);
			}
			else
			{
				_context3D.setRenderToBackBuffer();
			}
		}
		/**
		 * 获取渲染目标 
		 * @return 
		 * 
		 */		
		public function get renderTarget():psw2d.texture.Texture
		{
			return _renderTarget;
		}
		/**
		 * 注册一个着色器程序 。应该将经常用到的着色器程序缓存到这里，要注意不要有重复的命名。
		 * @param name
		 * @param vertexProgram
		 * @param fragmentProgram
		 * 
		 */		
		public function registerProgram(name:String,vertexProgram:ByteArray,fragmentProgram:ByteArray):void
		{
			if(_programs[name]) throw "已经有同名的Program3D对象存在！";
			var program:Program3D = _context3D.createProgram();
			program.upload(vertexProgram,fragmentProgram);
			_programs[name] = program;
		}
		/**
		 * 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getProgram(name:String):Program3D
		{
			return _programs[name] as Program3D;
		}
	}
}