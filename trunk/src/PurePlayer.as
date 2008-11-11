package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import ua.com.syo.controller.Controller;
	import ua.com.syo.view.UIManager;
	
	[SWF(width = "400" , height = "340" , frameRate = "25", backgroundColor = "#000000" )]
	
	public class PurePlayer extends Sprite {
		
		
		
		public function PurePlayer() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Controller.instance.init(root.stage.stageWidth, root.stage.stageHeight);
			addChild(UIManager.instance);
		}
	}
}
