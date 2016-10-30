
Rem
bbdoc: Stencil
End Rem
Type TStencil

	Global stencil_map:TMap=New TMap
	Field instance:Byte Ptr
	
	Function CreateObject:TStencil( inst:Byte Ptr ) ' Create and map object from C++ instance
	
		If inst=Null Then Return Null
		Local obj:TStencil=New TStencil
		stencil_map.Insert( String(Long(inst)),obj )
		obj.instance=inst
		Return obj
		
	End Function
	
	Function FreeObject( inst:Byte Ptr )
	
		stencil_map.Remove( String(Long(inst)) )
		
	End Function
	
	Function GetObject:TStencil( inst:Byte Ptr )
	
		Return TStencil( stencil_map.ValueForKey( String(Long(inst)) ) )
		
	End Function
	
	Function GetInstance:Byte Ptr( obj:TStencil ) ' Get C++ instance from object
	
		If obj=Null Then Return Null ' Attempt to pass null object to function
		Return obj.instance
		
	End Function
	
	' Openb3d
	
	Function CreateStencil:TStencil()
	
		Local inst:Byte Ptr=CreateStencil_()
		Return CreateObject(inst)
		
	End Function
	
	Method StencilAlpha( a:Float )
	
		StencilAlpha_( GetInstance(Self),a )
		
	End Method
	
	Method StencilClsColor( r:Float,g:Float,b:Float )
	
		StencilClsColor_( GetInstance(Self),r,g,b )
		
	End Method
	
	Method StencilClsMode( cls_color:Int,cls_zbuffer:Int )
	
		StencilClsMode_( GetInstance(Self),cls_color,cls_zbuffer )
		
	End Method
	
	Method StencilMesh( mesh:TMesh,Mode:Int=1 )
	
		StencilMesh_( GetInstance(Self),TMesh.GetInstance(mesh),Mode )
		
	End Method
	
	Method StencilMode( m:Int,o:Int=1 )
	
		StencilMode_( GetInstance(Self),m,o )
		
	End Method
	
	Function UseStencil( sten:TStencil ) ' as function so Null can be passed
	
		UseStencil_( GetInstance(sten) )
		
	End Function
	
	Method FreeStencil() ' Spinduluz
	
		FreeStencil_( GetInstance(Self) )
		FreeObject( GetInstance(Self) )
		
	End Method
	
End Type
