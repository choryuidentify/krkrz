
#ifndef __FILE_CTRL_H__
#define __FILE_CTRL_H__

#include <shlwapi.h>
#include <winnetwk.h>
#include <string>

inline std::wstring IncludeTrailingBackslash( const std::wstring& path ) {
	if( path[path.length()-1] != L'\\' ) {
		return std::wstring(path+L"\\");
	}
	return std::wstring(path);
}
inline std::wstring ExcludeTrailingBackslash( const std::wstring& path ) {
	if( path[path.length()-1] == L'\\' ) {
		return std::wstring(path.c_str(),path.length()-1);
	}
	return std::wstring(path);
}

inline std::wstring ExtractFileDir( const std::wstring& path ) {
	wchar_t drive[_MAX_DRIVE];
	wchar_t dir[_MAX_DIR];
	_wsplitpath_s(path.c_str(), drive, _MAX_DRIVE, dir,_MAX_DIR, NULL, 0, NULL, 0 );
	std::wstring dirstr = std::wstring( dir );
	if( dirstr[dirstr.length()-1] != L'\\' ) {
		return std::wstring( drive ) + dirstr;
	} else {
		return std::wstring( drive ) + dirstr.substr(0,dirstr.length()-1);
	}
}
inline std::wstring ExtractFilePath( const std::wstring& path ) {
	wchar_t drive[_MAX_DRIVE];
	wchar_t dir[_MAX_DIR];
	_wsplitpath_s(path.c_str(), drive, _MAX_DRIVE, dir,_MAX_DIR, NULL, 0, NULL, 0 );
	return std::wstring( drive ) + std::wstring( dir );
}

inline bool DirectoryExists( const std::wstring& path ) {
	return (0!=::PathIsDirectory(path.c_str()));
}
inline bool FileExists( const std::wstring& path ) {
	return ( (0!=::PathFileExists(path.c_str())) && (0==::PathIsDirectory(path.c_str())) );
}
inline std::wstring ChangeFileExt( const std::wstring& path, const std::wstring& ext ) {
	wchar_t drive[_MAX_DRIVE];
	wchar_t dir[_MAX_DIR];
	wchar_t fname[_MAX_FNAME];
	_wsplitpath_s( path.c_str(), drive, _MAX_DRIVE, dir, _MAX_DIR, fname, _MAX_FNAME, NULL, 0 );
	return std::wstring( drive ) + std::wstring( dir ) + std::wstring( fname ) + ext;
}
inline std::wstring ExtractFileName( const std::wstring& path ) {
	wchar_t fname[_MAX_FNAME];
	wchar_t ext[_MAX_EXT];
	_wsplitpath_s( path.c_str(), NULL, 0, NULL, 0, fname, _MAX_FNAME, ext, _MAX_EXT );
	return std::wstring( fname ) + std::wstring( ext );
}
inline std::wstring ExpandUNCFileName( const std::wstring& path ) {
	std::wstring result;
	DWORD InfoSize = 0;
	if( ERROR_MORE_DATA == WNetGetUniversalName( path.c_str(), UNIVERSAL_NAME_INFO_LEVEL, NULL, &InfoSize) ) {
		UNIVERSAL_NAME_INFO* pInfo = reinterpret_cast<UNIVERSAL_NAME_INFO*>( ::GlobalAlloc(GMEM_FIXED, InfoSize) );
		DWORD ret = ::WNetGetUniversalName( path.c_str(), UNIVERSAL_NAME_INFO_LEVEL, pInfo, &InfoSize);
		if( NO_ERROR == ret ) {
			result = std::wstring(pInfo->lpUniversalName);
		}
		::GlobalFree(pInfo);
	} else {
		wchar_t fullpath[_MAX_PATH];
		result = std::wstring( _wfullpath( fullpath, path.c_str(), _MAX_PATH ) );
	}
	return result;
}

#endif // __FILE_CTRL_H__
