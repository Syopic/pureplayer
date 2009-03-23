package ua.com.syo.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import ua.com.syo.data.CurrentData;

	public class VideoArea {
		
		[Embed(source = "/../assets/library.swf" , symbol = "VideoAreaBg")]
		private var VideoAreaBg:Class;
		
		[Embed(source = "/../assets/library.swf" , symbol = "BufferingIcon")]
		private var BufferingIcon:Class;
		
		private var bufferingIcon:Sprite;
		
		private var bg:Sprite;
		private var video:Video;
		
		private var container:Sprite;
		
		private var connection:NetConnection;
		private var stream:NetStream;
		
		private var oldProgress:Number;
		
		private var isLoading:Boolean = false;
		private var isPlayed:Boolean = false;
		
		public function VideoArea(_container:Sprite)	{
			container = _container;
			bg = new VideoAreaBg();
			
			bufferingIcon = new BufferingIcon();
			//bufferingIcon.visible = false;
			
			container.addChild(bg);
			
			connection = new NetConnection();
            connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            connection.connect(null);
            //stream.play(CurrentData.instance.rootURL + CurrentData.instance.videoURL);
		}
		
		public function setSize(w:Number, h:Number):void {
			bg.width = video.width = w;
			bg.height = video.height = h;
			bufferingIcon.x = Math.round(w / 2 - bufferingIcon.width / 2);
			bufferingIcon.y = Math.round(h / 2 - bufferingIcon.height / 2);
		}
		
		//private var videoURL:String = "../assets/video.flv";
		//private var videoURL:String = "D:/Downloads/miniflvplayer/md.flv";
		//private var videoURL:String = "D:/Downloads/player2/player2/video.flv";
		//private var videoURL:String = "../assets/depeche.flv";
		private var videoURL:String = "http://video.mail.ru/corp/afisha/trailers/v-567.flv";
		
        private function netStatusHandler(event:NetStatusEvent):void {
            switch (event.info.code) {
                case "NetConnection.Connect.Success":
                    connectStream();
                    trace("connectStream");
                    break;
                case "NetStream.Play.StreamNotFound":
                    trace("Unable to locate video: " + videoURL);
                    break;
                    
            }
        }
        
        private function connectStream():void {
        	var customClient:Object = new Object();
			customClient.onMetaData = metaDataHandler;

        	
            stream = new NetStream(connection);
            stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
            
            video = new Video();
            video.attachNetStream(stream);
            video.smoothing = true;
            container.addChild(video);
            stream.client = customClient;
            
            container.addChild(bufferingIcon);
        }
        
        private function testListener(event:Event):void {
        	UIManager.instance.controlPanel.progressBar.setSliderPosition(stream.time, dur);
        	UIManager.instance.controlPanel.progressBar.setBufferPosition(stream.bytesLoaded, stream.bytesTotal);
        	UIManager.instance.controlPanel.scoreTextField.text = formatTime(stream.time) + " / " + formatTime(dur);
        	if (formatTime(stream.time) == formatTime(dur)
        		&& !UIManager.instance.controlPanel.progressBar.isMouseActive) {
        		UIManager.instance.endOfPlay();
        	}
        	if (stream.time == oldProgress && isPlayed) {
        		if (!bufferingIcon.visible) {
	        		bufferingIcon.visible = true;
	        		(bufferingIcon as MovieClip).gotoAndPlay(1);
        		}
        	} else {
        		bufferingIcon.visible = false;
        	}
        	oldProgress = stream.time;
        }
        
        private function formatTime(value:Number):String {
			value = Math.round(value);
			var result:String = (value % 60).toString();
	        if (result.length == 1)
	            result = Math.floor(value / 60).toString() + ":0" + result;
	        else 
	            result = Math.floor(value / 60).toString() + ":" + result;
	        return result;
		}
        

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }
        
        private function asyncErrorHandler(event:AsyncErrorEvent):void {
            trace(event.text);
        }
		
		private var dur:Number; 
		private function metaDataHandler(infoObject:Object):void {
		   	//video.height = Math.round(bg.width/infoObject.width)*infoObject.height; 
		    video.y = Math.round(bg.height/2 - video.height/2);
		    
		    dur = infoObject.duration;
		    
		    trace("metadata: duration=" + infoObject.duration + " width=" + infoObject.width + " height=" + infoObject.height + " framerate=" + infoObject.framerate);
		}
		
		public function seekStream(offset:Number):void {
			stream.seek(offset);
		}
		
		public function stop():void{
			stream.pause();
			isPlayed = false;
		}
		public function play():void{
			if (!isLoading) {
				stream.bufferTime = 5;
	            stream.play(CurrentData.instance.rootURL + CurrentData.instance.videoURL);
	            //stream.play(videoURL);
	            container.addEventListener(Event.ENTER_FRAME, testListener);
	            isLoading = true;
			}
			stream.resume();
			isPlayed = true;
		}
		
		public function setVolume(value:Number):void {
			var transform:SoundTransform = stream.soundTransform;
			transform.volume = value;
			stream.soundTransform = transform;
		}

		
	}
}