package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import ua.com.syo.controller.Controller;
	import ua.com.syo.data.Globals;
	import ua.com.syo.view.UIManager;
	
	[SWF(width = "320" , height = "280" , frameRate = "25", backgroundColor = "#000000" )]
	
	public class PurePlayer extends Sprite {
		
		public function PurePlayer() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			Globals.stageWidth = root.stage.stageWidth;
			Globals.stageHeight = root.stage.stageHeight;
			
			addEventListener(Event.RESIZE, function():void {
				Globals.stageWidth = root.stage.stageWidth;
				Globals.stageHeight = root.stage.stageHeight;
				UIManager.instance.controlPanel.arrangeControls();
			});
			
			Controller.instance.init();
			addChild(UIManager.instance);
		}
	}
}
