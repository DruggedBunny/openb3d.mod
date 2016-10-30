
Rem
bbdoc: Hardware info
about: Contains @{Function GetInfo()} And @{DisplayInfo(LogFile:Int=False)}.
End Rem
Type THardwareInfo ' by klepto2

	' added
	Global ScreenWidth  : Int = DesktopWidth()
	Global ScreenHeight : Int = DesktopHeight()
	Global ScreenDepth  : Int = DesktopDepth()
	Global ScreenHertz  : Int = DesktopHertz()

	Global Vendor     : String
	Global Renderer   : String
	Global OGLVersion : String

	Global Extensions      : String
	Global GLTCSupport     : Int ' OpenGL's TextureCompression - GL 1.1
	Global S3TCSupport     : Int ' S3's TextureCompression, aka DXTC - GL 1.1
	Global AnIsoSupport    : Int ' An-Istropic Filtering, for mipmaps - GL 1.2
	Global MultiTexSupport : Int ' MultiTexturing - GL 1.2
	Global TexBlendSupport : Int ' TextureBlend, texture combine env - GL 1.1
	Global CubemapSupport  : Int ' CubeMapping - GL 1.2
	Global DepthmapSupport : Int ' DepthTexturing - GL 1.1
	Global VBOSupport      : Int ' Vertex Buffer Objects - GL 1.4
	Global VPSupport       : Int ' VertexProgram (ARBvp1.0) - GL 1.3
	Global FPSupport       : Int ' FragmentProgram (ARBfp1.0) - GL 1.3
	Global ShaderSupport   : Int ' glSlang Shader Program - GL 1.4
	Global VSSupport       : Int ' glSlang VertexShader - GL 1.4
	Global FSSupport       : Int ' glSlang FragmentShader - GL 1.4
	Global SLSupport       : Int ' OpenGL Shading Language 1.00 - GL 1.5
	Global FBOSupport      : Int ' Framebuffer objects - GL 1.5
	Global DepthStencil    : Int ' Packed depth-stencil buffer - GL 2.0
	Global MaxTextures : Int
	Global MaxTexSize  : Int
	Global MaxLights   : Int
	
	' Minib3d
	
	Function GetInfo()
		Local Extensions:String

		' Get HardwareInfo
		Vendor     = String.FromCString(Byte Ptr(glGetString(GL_VENDOR)))
		Renderer   = String.FromCString(Byte Ptr(glGetString(GL_RENDERER))) 
		OGLVersion = String.FromCString(Byte Ptr(glGetString(GL_VERSION)))

		' Get Extensions
		Extensions = String.FromCString(Byte Ptr(glGetString(GL_EXTENSIONS)))
		THardwareInfo.Extensions = Extensions
		
		' Check for Extensions
		THardwareInfo.GLTCSupport     = Extensions.Find("GL_ARB_texture_compression") > -1
		THardwareInfo.S3TCSupport     = Extensions.Find("GL_EXT_texture_compression_s3tc") > -1
		THardwareInfo.AnIsoSupport    = Extensions.Find("GL_EXT_texture_filter_anisotropic") > -1
		THardwareInfo.MultiTexSupport = Extensions.Find("GL_ARB_multitexture") > -1
		THardwareInfo.TexBlendSupport = Extensions.Find("GL_EXT_texture_env_combine") > -1
		THardwareInfo.CubemapSupport  = Extensions.Find("GL_ARB_texture_cube_map") > -1
		THardwareInfo.DepthmapSupport = Extensions.Find("GL_ARB_depth_texture") > -1
		THardwareInfo.VBOSupport      = Extensions.Find("GL_ARB_vertex_buffer_object") > -1
		THardwareInfo.VPSupport       = Extensions.Find("GL_ARB_vertex_program") > -1
		THardwareInfo.FPSupport       = Extensions.Find("GL_ARB_fragment_program") > -1
		THardwareInfo.ShaderSupport   = Extensions.Find("GL_ARB_shader_objects") > -1
		THardwareInfo.VSSupport       = Extensions.Find("GL_ARB_vertex_shader") > -1
		THardwareInfo.FSSupport       = Extensions.Find("GL_ARB_fragment_shader") > -1
		THardwareInfo.SLSupport       = Extensions.Find("GL_ARB_shading_language_100") > - 1
		THardwareInfo.FBOSupport      = Extensions.Find("GL_EXT_framebuffer_object") > - 1
		THardwareInfo.DepthStencil    = Extensions.Find("GL_EXT_packed_depth_stencil") > -1
		
		If THardwareInfo.VSSupport = False Or THardwareInfo.FSSupport = False Then
			THardwareInfo.ShaderSupport = False
		EndIf
		If Not THardwareInfo.TexBlendSupport ' SMALLFIXES use the ARB version that works the same
			THardwareInfo.TexBlendSupport = Extensions.Find("GL_ARB_texture_env_combine") > -1
		EndIf

		' Get some numerics
		glGetIntegerv(GL_MAX_TEXTURE_UNITS, Varptr(THardwareInfo.MaxTextures))
		glGetIntegerv(GL_MAX_TEXTURE_SIZE, Varptr(THardwareInfo.MaxTexSize))
		glGetIntegerv(GL_MAX_LIGHTS, Varptr(THardwareInfo.MaxLights))
	End Function

	Function DisplayInfo(LogFile:Int=False)
		Local position:Int, Space:Int, stream:TStream

		If LogFile Then
			stream = WriteStream("HardwareInfo.txt") 
			stream.WriteLine("Hardwareinfo:")
			stream.WriteLine("")
			
			' Display Desktopinfo
			stream.WriteLine("Width:  "+ScreenWidth)
			stream.WriteLine("Height: "+ScreenHeight)
			stream.WriteLine("Depth:  "+ScreenDepth)
			stream.WriteLine("Hertz:  "+ScreenHertz)
			stream.WriteLine("")
			
			' Display Driverinfo
			stream.WriteLine("Vendor:         "+Vendor)
			stream.WriteLine("Renderer:       "+Renderer)
			stream.WriteLine("OpenGL-Version: "+OGLVersion)
			stream.WriteLine("")

			' Display Hardwareranges
			stream.WriteLine("Max Texture Units: "+MaxTextures)
			stream.WriteLine("Max Texture Size:  "+MaxTexSize)
			stream.WriteLine("Max Lights:        "+MaxLights)
			stream.WriteLine("")

			' Display OpenGL-Extensions
			stream.WriteLine("OpenGL Extensions:")
			While position < Extensions.length
				Space = Extensions.Find(" ", position)
				If Space = -1 Then Exit
				stream.WriteLine(Extensions[position..Space])
				position = Space+1
			Wend

			stream.WriteLine("")
			stream.WriteLine("- Ready -")
			stream.Close()
		Else
			Print("Hardwareinfo:")
			Print("")
			
			' Display Desktopinfo
			Print("Width:  "+ScreenWidth)
			Print("Height: "+ScreenHeight)
			Print("Depth:  "+ScreenDepth)
			Print("Hertz:  "+ScreenHertz)
			Print("")
			
			' Display Driverinfo
			Print("Vendor:         "+Vendor)
			Print("Renderer:       "+Renderer)
			Print("OpenGL-Version: "+OGLVersion)
			Print("")

			' Display Hardwareranges
			Print("Max Texture Units: "+MaxTextures)
			Print("Max Texture Size:  "+MaxTexSize)
			Print("Max Lights:        "+MaxLights)
			Print("")

			' Display OpenGL-Extensions
			Print("OpenGL Extensions:")
			While position < Extensions.length
				Space = Extensions.Find(" ", position)
				If Space = -1 Then Exit
				Print(Extensions[position..Space])
				position = Space+1
			Wend

			Print("")
			Print("- Ready -")
		EndIf
	End Function
	
End Type
