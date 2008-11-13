package ua.com.syo.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class ProgressBar extends Sprite{
		
		[Embed(source = "/../assets/library.swf" , symbol = "PlayedBar")]
		private var PlayedBar:Class;
		
		private var progressBarMc:MovieClip;
		private var barMc:MovieClip;
		private var sliderMc:MovieClip;
		private var bufferMc:MovieClip;
		
		public function ProgressBar() {
			progressBarMc = new PlayedBar();
			addChild(progressBarMc);
			barMc = progressBarMc["bar"];
			bufferMc = progressBarMc["bufferBar"];
			
		}
		
		public function setWidth(value:Number):void {
			barMc.width = value;
			bufferMc.width = value/2;
		}

	}
}