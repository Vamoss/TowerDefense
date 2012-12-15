package core{
	import flash.utils.Timer;

	public class Level
	{
		
		//setting vars to step in for turns and special blocks
		public static const S:String = 'START';
		public static const F:String = 'FINISH';
		public static const U:String = 'UP';
		public static const R:String = 'RIGHT';
		public static const D:String = 'DOWN';
		public static const L:String = 'LEFT';
		
		public var startDir:String;//the direction the enemies go when they enter
		public var finDir:String;//the direction the enemies go when they exit
		public var startCoord:int;//the coordinates of the beginning of the road
		public var lvlArray:Array;//this array will hold the formatting of the roads
		
		public var currentEnemy:int;//the current enemy that we're creating from the array
		public var enemyTime:int;//how many frames have elapsed since the last enemy was created
		public var enemyLimit:int;//how many frames are allowed before another enemy is created
		public var enemyArray:Array;//this array will tell the function when to create an enemy
		public var enemiesLeft:int;//how many enemies are left on the field
		
		private var timer:Timer;
		
		//the names of these variables explain what they do
		public var currentLvl:int;
		
		public function Level()
		{
			timer = new Timer(1000);
		}
		
		public function start():void
		{
			currentLvl = 1;
		
			lvlArray = [
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,R,1,1,D,0,0,R,1,1,D,0,0,R,1,1,D,0,0,
				0,0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,
				0,0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,
				S,D,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,R,1,F,
				0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0,0,0,
				0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0,0,0,
				0,R,1,1,U,0,0,R,1,1,U,0,0,R,1,1,U,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			];
			
			enemyArray = [
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],//1's will just represent an enemy to be created
				[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2],//another row means another level
				[3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3],
				[100],
				[5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5],
				[250,250,250]
			];
			
			
			currentEnemy = 0;
			enemyTime = 0;
			enemyLimit = 12;
			
			timer.reset();
			timer.start();
		}
		
		public function stop():void
		{
			timer.stop();	
		}
		
		public function get timeElapsed():String
		{	
			var minutes:uint = timer.currentCount/60;
			var seconds:uint = timer.currentCount - (minutes * 60);
			var minuteString:String = (minutes < 10 ? "0":"") + minutes;
			var secondString:String = (seconds < 10 ? "0":"") + seconds;
			return minuteString + ":" + secondString;
		}
	}
}
