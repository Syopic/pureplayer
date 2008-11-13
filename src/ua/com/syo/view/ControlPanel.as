package ua.com.syo.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ua.com.syo.data.Globals;

	public class ControlPanel extends Sprite {
		
		[Embed(source = "/../assets/library.swf" , symbol = "PlayStopButton")]
		private var PlayStopButton:Class;
		
		[Embed(source = "/../assets/library.swf" , symbol = "EmbedButton")]
		private var EmbedButton:Class;
		
		[Embed(source = "/../assets/library.swf" , symbol = "FullscreenButton")]
		private var FullscreenButton:Class;
		
		[Embed(source = "/../assets/library.swf" , symbol = "VolumeButton")]
		private var VolumeButton:Class;
		
		private var playStopButton:MovieClip;
		private var embedButton:MovieClip;
		private var fullscreenButton:MovieClip;
		private var volumeButton:MovieClip;
		
		public function ControlPanel() {
			y = Globals.stageHeight - 40;
			
			playStopButton = new PlayStopButton();
			addChild(playStopButton);
			
			embedButton = new EmbedButton();
			addChild(embedButton);
			
			fullscreenButton = new FullscreenButton();
			addChild(fullscreenButton);
			
			volumeButton = new VolumeButton();
			addChild(volumeButton);
			
			enableControls();
			arrangeControls();
		}
		
		private function enableControls():void {
			playStopButton.gotoAndStop("play");
			initButtonListeners(playStopButton);
			initButtonListeners(embedButton);
			initButtonListeners(fullscreenButton);
			initButtonListeners(volumeButton);
		}
		
		private var leftIndent:Number;
		private var rightIndent:Number;
		
		public function arrangeControls():void {
			leftIndent = 5;
			rightIndent = Globals.stageWidth - 5;
			
			playStopButton.x = leftIndent;
			playStopButton.y = 5;
			
			leftIndent += playStopButton.width + 5; 
			
			embedButton.x = rightIndent - embedButton.width;
			embedButton.y = 5;
			
			rightIndent = embedButton.x - 5; 
			
			
			fullscreenButton.x = rightIndent - fullscreenButton.width;
			fullscreenButton.y = 5;
			
			rightIndent = fullscreenButton.x - 5; 
			
			volumeButton.x = rightIndent - volumeButton.width;
			volumeButton.y = 5;
			
			rightIndent = volumeButton.x - 5; 
		}
		
		private function initButtonListeners(b:MovieClip):void {
			b.buttonMode = true;
			MovieClip(b["tint"]).visible = false;
			b.addEventListener(MouseEvent.MOUSE_OVER, function():void {MovieClip(b["tint"]).visible = true;});
			b.addEventListener(MouseEvent.MOUSE_OUT, function():void {MovieClip(b["tint"]).visible = false;});
		}
		
		
	}
}