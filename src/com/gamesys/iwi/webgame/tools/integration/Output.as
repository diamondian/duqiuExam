package com.gamesys.iwi.webgame.tools.integration
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class Output
	{
		public function Output()
		{
		}
		
		public function write2File(content:String, des : File ,fileName:String = null,extension:String = null) : void
		{
			const target : File = des.isDirectory?new File( des.nativePath + "/" + fileName + "." +extension ):des;
			var fileStream : FileStream = new FileStream();
			fileStream.open( target, des.isDirectory?FileMode.WRITE:FileMode.UPDATE );
			fileStream.writeUTFBytes( content );
			fileStream.close();
		}
	}
}