package display.screen{	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;

	public class Win extends Screen{				private var label:TextField;				public function Win(root:TowerDefense){						super(root);						graphics.beginFill(0xFFFFFF);			graphics.drawRect(0,0,9000,9000);			graphics.endFill();						label = new TextField();			label.x = 80;			label.y = 150;			label.width = 390;			addChild(label);		}				override protected function beginClass(e:Event):void		{			super.beginClass(e);						label.text = "Congratulations! You ve beaten the game! Time: "+_root.level.timeElapsed;		}	}}