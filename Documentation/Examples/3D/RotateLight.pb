﻿;
; ------------------------------------------------------------
;
;   PureBasic - RotateLight
;
;    (c) Fantaisie Software
;
; ------------------------------------------------------------
;

IncludeFile #PB_Compiler_Home + "examples/3d/Screen3DRequester.pb"

Define.f x, y, z, Distance = 1500

If InitEngine3D()
  
  Add3DArchive(#PB_Compiler_Home + "examples/3d/Data/Textures", #PB_3DArchive_FileSystem)
  Add3DArchive(#PB_Compiler_Home + "examples/3d/Data/Scripts" , #PB_3DArchive_FileSystem)
  Parse3DScripts()
   
  InitSprite()
  InitKeyboard()
  InitMouse()
  
  If Screen3DRequester()
    
    KeyboardMode(#PB_Keyboard_International)
    
    ; Ground
    CreateMaterial(0, LoadTexture(0, "Dirt.jpg"))
    CreatePlane(0, 1000, 1000, 50, 50, 1, 1)
    CreateEntity (0, MeshID(0), MaterialID(0))
   
    ; Light
    AmbientColor(0)
    CreateLight(0, RGB(255, 255, 255), 0, 400, 0, #PB_Light_Spot)
    SpotLightRange(0, 1, 30, 3)
    LightDirection(0, 0.2, -1, 0.5)

    
    ; spot
    CreateSphere(1, 20, 50, 50)
    GetScriptMaterial(1, "Color/Yellow")
    SetMaterialColor(1, #PB_Material_SelfIlluminationColor, RGB(185, 155, 65))
    CreateEntity(1, MeshID(1), MaterialID(1), LightX(0), LightY(0), LightZ(0))
      
    ; Camera
    ;
    CreateCamera(0, 0, 0, 100, 100)
    MoveCamera(0, 0, 900, 1000, #PB_Absolute)
    CameraLookAt(0, 0, 0, 0)
    CameraBackColor(0, RGB(0, 0, 30))
    
    Repeat
      Screen3DEvents()
 
      ExamineKeyboard()
      
      RotateLight(0, 0, 1, 0, #PB_Relative)
      
      x = LightX(0) + LightDirectionX(0) * Distance
      y = LightY(0) + LightDirectionY(0) * Distance
      z = LightZ(0) + LightDirectionZ(0) * Distance
      CreateLine3D(10, LightX(0), LightY(0), LightZ(0), RGB(0, 255, 0), x, y, z, RGB(0, 255, 0))
      
      RenderWorld()
      FlipBuffers()
    Until KeyboardPushed(#PB_Key_Escape) Or Quit = 1
  EndIf
  
Else
  MessageRequester("Error", "The 3D Engine can't be initialized", 0)
EndIf