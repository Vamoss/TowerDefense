package core{

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
		
		//the names of these variables explain what they do
		public var currentLvl:int;
		
		public function Level()
		{
			
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
			
		}
	}
}
