package psw2d.render
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display3D.Context3DProgramType;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.utils.getQualifiedClassName;
	
	import psw2d.Alcedo;
	import psw2d.core.Context2D;
	import psw2d.display.DisplayObject;
	import psw2d.display.Quad;
	import psw2d.texture.Texture;
	import psw2d.utlis.QuadVertex;

	public class QuadRender extends RenderBase
	{
		protected var _quads:Vector.<Quad>;
		
		protected var _vertexBuffer:VertexBuffer3D;
		protected var _indexBuffer:IndexBuffer3D;
		protected var _vertexData:QuadVertex;
		
		public function QuadRender(texture:Texture)
		{
			super();
			_quads = new Vector.<Quad>();
		}
		
		override protected function onContextCreated(e:Event):void
		{
			registerPrograms();
		}
		
		override public function addDisplay(display:DisplayObject,parentAlpha:Number=1.0,texture:Texture=null,
											smoothing:String=null,modelViewMatrix:Matrix=null,
											blendMode:String=null):DisplayObject
		{
			_quads.push(display as Quad);
			_tinted = display.tined;
			_numDisplays ++;
			return display;
		}
		
		
		public function rebuildBuffer():void
		{
			var numQuads:uint = _quads.length;
			if(!numQuads) return;
			var context:Context2D = Alcedo.context;
			var vertexData:Vector.<Number>=new Vector.<Number>();
			var indexData:Vector.<uint>=new Vector.<uint>();
			_vertexData = new QuadVertex();
			for(var i:int=0;i<numQuads;++i)
			{
				_quads[i].vertexData.copyTo(_vertexData)
				_vertexData.transformVertex(_quads[i].transformationMatrix);
				vertexData = vertexData.concat(_vertexData.rawData);
				indexData.push(i*4+0,i*4+1,i*4+2,i*4+2,i*4+3,i*4+0);
			}
			if(!_vertexBuffer)
			{
				_vertexBuffer = context.createVertexBuffer(numQuads);
			}
			if(!_indexBuffer)
			{
				_indexBuffer = context.createIndexBuffer(numQuads);
			}
			_vertexBuffer.uploadFromVector(vertexData,0,numQuads*4);
			_indexBuffer.uploadFromVector(indexData,0,indexData.length);
			
			context.setAlphaBlend(null);
			context.setPosForVertex(_vertexBuffer);
			if(_tinted)
				context.setColorForVertex(_vertexBuffer);
		}
		
		override public function render(projectionMatrix:Matrix3D):void
		{
			var context:Context2D = Alcedo.context;
			context.setProjectionMatrix(projectionMatrix);
			context.setProgram(QUAD_PROGRAM_NAME);
			rebuildBuffer();
			context.drawTriangles(_indexBuffer,0,_quads.length * 2);
			context.clearBufferForQuad();
		}
		
		override public function reset():void
		{
			_quads = new Vector.<Quad>();
			_numDisplays = 0;
		}
		
		override public function canBatch(display:DisplayObject):Boolean
		{
			return getQualifiedClassName(display) == "psw2d.display.Quad";
		}
		
		public static const QUAD_PROGRAM_NAME:String = "QR";//名称应该尽量短小，但又不易导致冲突。
		private static function registerPrograms():void
		{
			var target:Alcedo = Alcedo.instance;
			
			var vertexSrc:String = "m44 op,va0,vc0 \n" +
				"mov v0,va1";
			var fragmentSrc:String = "mov oc,v0";
			
			var vertexAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			vertexAssembler.assemble(Context3DProgramType.VERTEX,vertexSrc);
			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT,fragmentSrc);
			
			Alcedo.context.registerProgram(QUAD_PROGRAM_NAME,vertexAssembler.agalcode,fragmentAssembler.agalcode);
		}
	}
}