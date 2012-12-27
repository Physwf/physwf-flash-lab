package psw2d.render
{
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import psw2d.display.BlendMode;
	import psw2d.display.DisplayObject;
	import psw2d.display.Image;
	import psw2d.display.Quad;
	import psw2d.display.SimpleImagePlayer;
	import psw2d.texture.Texture;

	public class RenderMaster
	{
		private var _renderMap:Dictionary;
		
		private var _renders:Vector.<RenderBase>;
		private var _currentRenderID:int;
		
		private var _projectionMatrix:Matrix;
		private var _projectionMatrix3D:Matrix3D;
		
		private var _modelMatrix:Matrix;
		
		private var _matrixStack:Vector.<Matrix>;
		private var _matrixStackSize:int;
		
		private var _blendMode:String;
		private var _blendModeStack:Vector.<String>;
		
		private var _drawCount:int;
		
		private var _helperMatrix:Matrix;
		
		public function RenderMaster()
		{
			_renders = new <RenderBase>[];
			_currentRenderID = -1;
			_modelMatrix = new Matrix();
			_matrixStack = new <Matrix>[];
			
			_blendMode = BlendMode.AUTO;
			_blendModeStack = new <String>[];
			
			_matrixStackSize = 0;
			_drawCount = 0;
			
			_projectionMatrix = new Matrix();
			
			_helperMatrix = new Matrix();
			
			mapRenders();
		}
		
		private function mapRenders():void
		{
			_renderMap = new Dictionary();
			_renderMap[Quad] = QuadRender;
			_renderMap[Image] = ImageRender;
			_renderMap[SimpleImagePlayer] = ImageRender;
		}
		
		public function pushMatrix():void
		{
			if(_matrixStack.length<_matrixStackSize+1)
				_matrixStack.push(new Matrix());
			
			_matrixStack[_matrixStackSize++].copyFrom(_modelMatrix);
		}
		
		public function transformMatrix(object:DisplayObject):void
		{
			transformMatrixFormObject(_modelMatrix,object);
		}
		
		public function transformMatrixFormObject(matrix:Matrix,object:DisplayObject):void
		{
			_helperMatrix.copyFrom(object.transformationMatrix);
			_helperMatrix.concat(matrix);
			matrix.copyFrom(_helperMatrix);
		}
		
		public function popMatrix():void
		{
			_modelMatrix.copyFrom(_matrixStack[--_matrixStackSize]);
		}
		
		public function pushBlendMode():void
		{
			_blendModeStack.push(_blendMode);
		}
		
		public function popBlendMode():void
		{
			_blendMode = _blendModeStack.pop();
		}
		
		public function setOrthographicProjection(sW:Number,sH:Number):void
		{
			_projectionMatrix.setTo(2.0/sW, 0, 0, -2.0/sH, -1.0, 1.0);
			_projectionMatrix3D = new Matrix3D(Vector.<Number>(
				[
					2/sW, 0,  0, 0,
					0, -2/sH, 0, 0,
					0,  0,    0, 0,
					-1, 1,    0, 1
				])); 
		}
		
		public function nextFrame():void
		{
			_currentRenderID = 0;
			_drawCount=0;
		}
		
		public function bacthDisplay(display:DisplayObject,parentAlpha:Number,texture:Texture=null,smooting:String=null):void
		{
			var render:RenderBase = matchRender(display,texture);
			if(render.isStateChange(parentAlpha,texture,smooting,_blendMode,display.tined))
			{
				finishRender(display,texture);
			}
			_renders[_currentRenderID].addDisplay(display,parentAlpha,texture,smooting,_modelMatrix,_blendMode);
		}

		public function finishRender(display:DisplayObject,texture:Texture=null):void
		{
			var curRender:RenderBase = _renders[_currentRenderID];
			if(curRender.numDisplays > 0)
			{
				curRender.render(_projectionMatrix3D);
				curRender.reset();
				
				++ _currentRenderID;
				++ _drawCount;
				
				if(_renders.length <= _currentRenderID)
				{
					if(display == null) return;
					var type:Class = getDefinitionByName(getQualifiedClassName(display)) as Class;
					_renders.push(new _renderMap[type](texture) as RenderBase); 
				}
			}
		}
		
		public function get blendMode():String
		{
			return _blendMode;
		}

		public function set blendMode(value:String):void
		{
			if(value != BlendMode.AUTO) _blendMode = value;
		}

		private function matchRender(display:DisplayObject,texture:Texture=null):RenderBase
		{
			var type:Class = getDefinitionByName(getQualifiedClassName(display)) as Class;
			if(_currentRenderID<0)
			{
				_currentRenderID ++;
				_renders.push(new _renderMap[type](texture) as RenderBase);
			}
			return _renders[_currentRenderID];
		}
	}
}