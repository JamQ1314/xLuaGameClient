echo off
setlocal enabledelayedexpansion 

set LuaDir=..\TempLua
set ProjectLuaDir=..\..\Assets\LuaScripts\Net\Protobuf
set ProtocDir=.\TempProtoc

set Protogen=..\ProtoToCS\ProtoGen\protogen.exe
set CSharpDir=..\TempCSharp

cd	%ProtocDir%
for /R %%f in (*.proto) do ( 
	set "FILE_FULLNAME=%%~nxf"
    echo Compile Proto: !FILE_FULLNAME!
	echo ---------------------------------------------------
	set "csname=%%~nf.cs"
	"..\protoc-gen-lua-master\protoc.exe" --lua_out=%ProjectLuaDir% --plugin=protoc-gen-lua="..\protoc-gen-lua-master\plugin\build.bat" !FILE_FULLNAME!
	%Protogen% -i:!FILE_FULLNAME! -o:!CSharpDir!\!csname!
)

pause