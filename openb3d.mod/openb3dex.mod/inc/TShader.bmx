
' TShaderObject

' TProgramObject

' TShaderData

Rem
bbdoc: Material texture
End Rem
Type TMaterial Extends TTexture
	
	Function CreateObject:TMaterial( inst:Byte Ptr ) ' Create and map object from C++ instance
	
		If inst=Null Then Return Null
		Local obj:TMaterial=New TMaterial
		tex_map.Insert( String(Long(inst)),obj )
		obj.instance=inst
		Return obj
		
	End Function
	
	' Openb3d
	
	Function LoadMaterial:TMaterial( filename:String,flags:Int,frame_width:Int,frame_height:Int,first_frame:Int,frame_count:Int )
	
		Local cString:Byte Ptr=filename.ToCString()
		Local inst:Byte Ptr=LoadMaterial_( cString,flags,frame_width,frame_height,first_frame,frame_count )
		Local mat:TMaterial=CreateObject(inst)
		MemFree cString
		Return mat
		
	End Function
	
End Type

' TSampler

Rem
bbdoc: Shader
End Rem
Type TShader

	' wrapper
	Global shader_map:TMap=New TMap
	Field instance:Byte Ptr
	
	Function CreateObject:TShader( inst:Byte Ptr ) ' Create and map object from C++ instance
	
		If inst=Null Then Return Null
		Local obj:TShader=New TShader
		shader_map.Insert( String(Long(inst)),obj )
		obj.instance=inst
		Return obj
		
	End Function
	
	Function FreeObject( inst:Byte Ptr )
	
		shader_map.Remove( String(Long(inst)) )
		
	End Function
	
	Function GetObject:TShader( inst:Byte Ptr )
	
		Return TShader( shader_map.ValueForKey( String(Long(inst)) ) )
		
	End Function
	
	Function GetInstance:Byte Ptr( obj:TShader ) ' Get C++ instance from object
	
		If obj=Null Then Return Null ' Attempt to pass null object to function
		Return obj.instance
		
	End Function
	
	' Openb3d
	
	Function LoadShader:TShader( ShaderName:String,VshaderFileName:String,FshaderFileName:String )
	
		Local cString:Byte Ptr=ShaderName.ToCString()
		Local vcString:Byte Ptr=VshaderFileName.ToCString()
		Local fcString:Byte Ptr=FshaderFileName.ToCString()
		Local inst:Byte Ptr=LoadShader_( cString,vcString,fcString )
		Local material:TShader=CreateObject(inst)
		MemFree cString
		MemFree vcString
		MemFree fcString
		Return material
		
	End Function
	
	Function CreateShader:TShader( ShaderName:String,VshaderString:String,FshaderString:String )
	
		Local cString:Byte Ptr=ShaderName.ToCString()
		Local vcString:Byte Ptr=VshaderString.ToCString()
		Local fcString:Byte Ptr=FshaderString.ToCString()
		Local inst:Byte Ptr=CreateShader_( cString,vcString,fcString )
		Local material:TShader=CreateObject(inst)
		MemFree cString
		MemFree vcString
		MemFree fcString
		Return material
		
	End Function
	
	Method ShadeSurface( surf:TSurface )
	
		ShadeSurface_( TSurface.GetInstance(surf),GetInstance(Self) )
		
	End Method
	
	Method ShadeMesh( mesh:TMesh )
	
		ShadeMesh_( TMesh.GetInstance(mesh),GetInstance(Self) )
		
	End Method
	
	Method ShadeEntity( ent:TEntity )
	
		ShadeEntity_( TEntity.GetInstance(ent),GetInstance(Self) )
		
	End Method
	
	Method ShaderTexture:TTexture( tex:TTexture,name:String,index:Int=0 )
	
		Local cString:Byte Ptr=name.ToCString()
		Local inst:Byte Ptr=ShaderTexture_( GetInstance(Self),TTexture.GetInstance(tex),cString,index )
		MemFree cString
		Local tex2:TTexture=TTexture.GetObject(inst)
		If tex2=Null And inst<>Null Then tex2=TTexture.CreateObject(inst)
		Return tex2
		
	End Method
	
	Method SetFloat( name:String,v1:Float )
	
		Local cString:Byte Ptr=name.ToCString()
		SetFloat_( GetInstance(Self),cString,v1 )
		MemFree cString
		
	End Method
	
	Method SetFloat2( name:String,v1:Float,v2:Float )
	
		Local cString:Byte Ptr=name.ToCString()
		SetFloat2_( GetInstance(Self),cString,v1,v2 )
		MemFree cString
		
	End Method
	
	Method SetFloat3( name:String,v1:Float,v2:Float,v3:Float )
	
		Local cString:Byte Ptr=name.ToCString()
		SetFloat3_( GetInstance(Self),cString,v1,v2,v3 )
		MemFree cString
		
	End Method
	
	Method SetFloat4( name:String,v1:Float,v2:Float,v3:Float,v4:Float )
	
		Local cString:Byte Ptr=name.ToCString()
		SetFloat4_( GetInstance(Self),cString,v1,v2,v3,v4 )
		MemFree cString
		
	End Method
	
	Method UseFloat( name:String,v1:Float Var )
	
		Local cString:Byte Ptr=name.ToCString()
		UseFloat_( GetInstance(Self),cString,Varptr(v1) )
		MemFree cString
		
	End Method
	
	Method UseFloat2( name:String,v1:Float Var,v2:Float Var )
	
		Local cString:Byte Ptr=name.ToCString()
		UseFloat2_( GetInstance(Self),cString,Varptr(v1),Varptr(v2) )
		MemFree cString
		
	End Method
	
	Method UseFloat3( name:String,v1:Float Var,v2:Float Var,v3:Float Var )
	
		Local cString:Byte Ptr=name.ToCString()
		UseFloat3_( GetInstance(Self),cString,Varptr(v1),Varptr(v2),Varptr(v3) )
		MemFree cString
		
	End Method
	
	Method UseFloat4( name:String,v1:Float Var,v2:Float Var,v3:Float Var,v4:Float Var )
	
		Local cString:Byte Ptr=name.ToCString()
		UseFloat4_( GetInstance(Self),cString,Varptr(v1),Varptr(v2),Varptr(v3),Varptr(v4) )
		MemFree cString
		
	End Method
	
	Method SetInteger( name:String,v1:Int )
	
		Local cString:Byte Ptr=name.ToCString()
		SetInteger_( GetInstance(Self),cString,v1 )
		MemFree cString
		
	End Method
	
	Method SetInteger2( name:String,v1:Int,v2:Int )
	
		Local cString:Byte Ptr=name.ToCString()
		SetInteger2_( GetInstance(Self),cString,v1,v2 )
		MemFree cString
		
	End Method
	
	Method SetInteger3( name:String,v1:Int,v2:Int,v3:Int )
	
		Local cString:Byte Ptr=name.ToCString()
		SetInteger3_( GetInstance(Self),cString,v1,v2,v3 )
		MemFree cString
		
	End Method
	
	Method SetInteger4( name:String,v1:Int,v2:Int,v3:Int,v4:Int )
	
		Local cString:Byte Ptr=name.ToCString()
		SetInteger4_( GetInstance(Self),cString,v1,v2,v3,v4 )
		MemFree cString
		
	End Method
	
	Method UseInteger( name:String,v1:Int Var )
	
		Local cString:Byte Ptr=name.ToCString()
		UseInteger_( GetInstance(Self),cString,Varptr(v1) )
		MemFree cString
		
	End Method
	
	Method UseInteger2( name:String,v1:Int Var,v2:Int Var )
	
		Local cString:Byte Ptr=name.ToCString()
		UseInteger2_( GetInstance(Self),cString,Varptr(v1),Varptr(v2) )
		MemFree cString
		
	End Method
	
	Method UseInteger3( name:String,v1:Int Var,v2:Int Var,v3:Int Var )
	
		Local cString:Byte Ptr=name.ToCString()
		UseInteger3_( GetInstance(Self),cString,Varptr(v1),Varptr(v2),Varptr(v3) )
		MemFree cString
		
	End Method
	
	Method UseInteger4( name:String,v1:Int Var,v2:Int Var,v3:Int Var,v4:Int Var )
	
		Local cString:Byte Ptr=name.ToCString()
		UseInteger4_( GetInstance(Self),cString,Varptr(v1),Varptr(v2),Varptr(v3),Varptr(v4) )
		MemFree cString
		
	End Method
	
	Method UseSurface( name:String,surf:TSurface,vbo:Int )
	
		Local cString:Byte Ptr=name.ToCString()
		UseSurface_( GetInstance(Self),cString,TSurface.GetInstance(surf),vbo )
		MemFree cString
		
	End Method
	
	Method UseMatrix( name:String,Mode:Int )
	
		Local cString:Byte Ptr=name.ToCString()
		UseMatrix_( GetInstance(Self),cString,Mode )
		MemFree cString
		
	End Method
	
	Method ShaderMaterial( tex:TMaterial,name:String,index:Int=0 )
	
		Local cString:Byte Ptr=name.ToCString()
		ShaderMaterial_( GetInstance(Self),TMaterial.GetInstance(tex),cString,index )
		MemFree cString
		
	End Method
	
	Method AmbientShader()
	
		AmbientShader_( GetInstance(Self) )
		
	End Method
	
	Method FreeShader() ' Spinduluz
	
		FreeShader_( GetInstance(Self) )
		FreeObject( GetInstance(Self) )
		
	End Method
	
End Type
