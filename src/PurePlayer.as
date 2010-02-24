package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	
	import ua.com.syo.controller.Controller;
	import ua.com.syo.data.Globals;
	import ua.com.syo.view.UIManager;
	
	[SWF(width = "520" , height = "380" , frameRate = "25", backgroundColor = "#000000" )]
	
	public class PurePlayer extends Sprite {
		
		public function PurePlayer() {
			
			Globals.setFlashVars(loaderInfo.parameters);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			Globals.stageWidth = root.stage.stageWidth;
			Globals.stageHeight = root.stage.stageHeight;
			
			stage.addEventListener(Event.RESIZE, function():void {
				Globals.stageWidth = stage.stageWidth;
				Globals.stageHeight = stage.stageHeight;
				UIManager.instance.controlPanel.arrangeControls();
				UIManager.instance.videoArea.setSize(Globals.stageWidth, Globals.stageHeight - Globals.controlBarHeight);
				UIManager.instance.startImage.setSize(Globals.stageWidth, Globals.stageHeight - Globals.controlBarHeight);
			});
			
			
			Controller.instance.init();
			addChild(UIManager.instance);
			
			var tf:TextField = new TextField();
			tf.textColor=0xffffff;
			//tf.text=loaderInfo.parameters["playlist"];
			//addChild(tf);
		}
	}
}
