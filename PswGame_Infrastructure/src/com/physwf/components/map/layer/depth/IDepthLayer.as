package com.physwf.components.map.layer.depth 
{
	import com.physwf.components.interfaces.IView;
	
	import flash.display.DisplayObject;

	public interface IDepthLayer extends IView
	{

		function addView(view:IView):IView;
		function removeView(view:IView):IView;
		function updateElementDepth(view:IView):void;
		function updateAllElementsDepth():void;

	} // end interface
} // end package