package com.physwf.components.map.layer.landform
{
	import com.physwf.components.interfaces.IView;
	import com.physwf.components.map.tile.ITileRender;

	public interface ILandformLayer extends IView
	{
		function get tileController():ITileRender
	}
}