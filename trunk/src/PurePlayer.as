package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.System;
	
	import ua.com.syo.controller.Controller;
	import ua.com.syo.data.Globals;
	import ua.com.syo.view.UIManager;
	
	[SWF(width = "720" , height = "480" , frameRate = "25", backgroundColor = "#000000" )]
	
	public class PurePlayer extends Sprite {
		
		public function PurePlayer() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			Globals.stageWidth = root.stage.stageWidth;
			Globals.stageHeight = root.stage.stageHeight;
			
			stage.addEventListener(Event.RESIZE, function():void {
				Globals.stageWidth = stage.stageWidth;
				Globals.stageHeight = stage.stageHeight;
				UIManager.instance.controlPanel.arrangeControls();
				UIManager.instance.videoArea.setSize(Globals.stageWidth, Globals.stageHeight - 40);
			});
			
			Controller.instance.init();
			addChild(UIManager.instance);
		}
	}
}
