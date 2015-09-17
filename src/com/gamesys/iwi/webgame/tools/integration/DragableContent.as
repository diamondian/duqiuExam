package com.gamesys.iwi.webgame.tools.integration
{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;

	public class DragableContent extends EventDispatcher
	{
		public static const FILE_ACCEPT : String = "fileAccept";

		public static const FILE_CANCELED : String = "fileCanceled";

		public static const FILE_READED : String = "fileReaded";

		protected var _currentFile : File;

		protected var _sourceFileURL : String

		private var _view : UIComponent;
		
		protected var _outputContent:String;

		public function DragableContent( view : UIComponent = null)
		{
			if(view)
			{
				_view = view;
				_view.addEventListener( NativeDragEvent.NATIVE_DRAG_ENTER, onDragIn );
				_view.addEventListener( NativeDragEvent.NATIVE_DRAG_DROP, onDrop );
				_view.addEventListener( NativeDragEvent.NATIVE_DRAG_EXIT, onExit );
			}
			
			XML.ignoreComments = false;
		}

		public function get outputContent():String
		{
			return _outputContent;
		}

		protected function onExit( event : NativeDragEvent ) : void
		{
			this.dispatchEvent( new Event( FILE_CANCELED ));
		}

		protected function isValidateFileFormat( extention : String ) : Boolean
		{
			return false;
		}

		protected function readSourceFile() : void
		{
			//------------
		}
		

		private function onDragIn( event : NativeDragEvent ) : void
		{
			var transferable : Clipboard = event.clipboard;
			const files : Array = event.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array;
			const firstFile : File = files[ 0 ] as File;

			if( transferable.hasFormat( ClipboardFormats.FILE_LIST_FORMAT ) && files.length == 1 )
			{
				if( isValidateFileFormat( firstFile.extension ))
				{
					NativeDragManager.acceptDragDrop( _view );
					this.dispatchEvent( new Event( FILE_ACCEPT ));
				}
				else
				{
					Alert.show( "File format doesnt match!" );
				}
			}
			else
			{
				Alert.show( "invalidate file format or more than 1 file draged in!" );
			}


		}

		private function onDrop( event : NativeDragEvent ) : void
		{
			var dropfiles : Array = event.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array;

			_currentFile = File( dropfiles[ 0 ]);
			_sourceFileURL = _currentFile.url;

			try
			{
				readSourceFile();
				this.dispatchEvent( new Event( FILE_READED ));
			}
			catch( error : Error )
			{
				Alert.show( "Some error occured while reading source file." );
			}
		}
	}
}