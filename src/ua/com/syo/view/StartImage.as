package ua.com.syo.view {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class StartImage extends Sprite {
		
		[Embed(source = "/../assets/library.swf" , symbol = "BigPlayButton")]
		private var BigPlayButton:Class;

		private var img:Bitmap;
		private var bigPlayButton:MovieClip;

		public function StartImage(_img:Bitmap) {
			img = _img;
			addChild(img);
			bigPlayButton = new BigPlayButton();
			var tint:MovieClip = bigPlayButton["tint"];
			bigPlayButton.alpha = 0.5;
			tint.visible = false;
			bigPlayButton.buttonMode = true;
			
			bigPlayButton.addEventListener(MouseEvent.MOUSE_OVER, function():void {tint.visible = true; bigPlayButton.alpha = 1;});
			bigPlayButton.addEventListener(MouseEvent.MOUSE_OUT, function():void {tint.visible = false; bigPlayButton.alpha = 0.5;});
			bigPlayButton.addEventListener(MouseEvent.CLICK, function():void {dispatchEvent(new MouseEvent(MouseEvent.CLICK));});
			
			addChild(bigPlayButton);
		}
		
		public function setSize(w:Number, h:Number):void {
			img.width = w;
			img.height = h;
			bigPlayButton.x = w / 2 - bigPlayButton.width / 2;
			bigPlayButton.y = h / 2 - bigPlayButton.height / 2;
		}
		
	}
}