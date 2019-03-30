
CC = i686-w64-mingw32-gcc
CXX = i686-w64-mingw32-g++
AR = i686-w64-mingw32-ar
ASM = nasm
WINDRES = i686-w64-mingw32-windres
#CFLAGS += -O0 -g
CFLAGS_OPT = -O3 -march=ivybridge
# GIT_HASH = $(shell git rev-parse --short HEAD)
GIT_HASH = nothing
CUR_TIME = $(shell date +%s)
ASMFLAGS += -fwin32 -DWIN32 -Iexternal/libjpeg-turbo/simd -Iexternal/libjpeg-turbo/win
# CFLAGS += -gstabs -D_DEBUG -DENABLE_DEBUGGER 
CFLAGS += -gstabs
# CFLAGS += -flto
CFLAGS += -fno-delete-null-pointer-checks -Wall -Wno-unused-value -Wno-format -I. -Ivcproj -Iexternal/baseclasses -Imovie/win32 -Ivisual/gl -Iextension -Itjs2 -Ibase -Ibase/win32  -Imsg -Imsg/win32 -Isound -Isound/win32 -Iutils -Iutils/win32 -Ivisual -Ivisual/win32 -Ienviron/win32 -Ivisual/IA32 -Iplatform/win32 -Iexternal -Iexternal/zlib -Iexternal/lpng -Iexternal/libjpeg-turbo -Iexternal/libjpeg-turbo/vcproj -Iexternal/onig/src -Iexternal/onig -Iexternal/freetype/include -Iexternal/freetype/devel -Iexternal/freetype/src -Iexternal/freetype/src/gzip -Iexternal/jxrlib/jxrgluelib -Iexternal/jxrlib/image/sys -DGIT_HASH=L\"$(GIT_HASH)\" -DCUR_TIME=L\"$(CUR_TIME)\" -DNDEBUG -DNO_GZCOMPRESS -DWIN32 -D_WINDOWS -DHAVE_CONFIG_H -DPCRE_STATIC 
CFLAGS += -DFT2_BUILD_LIBRARY -DMINGW_HAS_SECURE_API -DUNICODE -D_UNICODE -DTVP_REPORT_HW_EXCEPTION -DTVP_LOG_TO_COMMANDLINE_CONSOLE -DNO_STRICT -DTJS_TEXT_OUT_CRLF -DTJS_JP_LOCALIZED -DTJS_DEBUG_DUMP_STRING -DCMAKE_INTDIR=\"Release\" -D_WINDOWS -DWIN32 -DWITH_SIMD
CXXFLAGS += $(CFLAGS) -fpermissive
LDFLAGS += -static -static-libstdc++ -static-libgcc -municode
LDLIBS += -lwinmm -lws2_32 -lcomctl32 -lgdi32 -lwinhttp -lpsapi -luser32 -lcomdlg32 -lole32 -lshell32 -ladvapi32  -loleaut32 -limm32 -lversion -lshlwapi -ldbghelp -luuid -lmpr

%.o: %.c
	@echo -e "\tCC  $<"
	$(CC) -c $(CFLAGS_OPT) $(CFLAGS) -o $@ $<

%.o: %.cpp
	@echo -e "\tCXX  $<"
	$(CXX) -c $(CFLAGS_OPT) $(CXXFLAGS) -o $@ $<

%.o: %.asm
	@echo -e "\ASM  $<"
	$(ASM) $(ASMFLAGS) $< -o$@ 

%.o: %.rc
	@echo -e "\tWINDRES  $<"
	$(WINDRES) --codepage=65001 $< $@

BASE_SOURCES += base/BinaryStream.cpp base/CharacterSet.cpp base/EventIntf.cpp base/PluginIntf.cpp base/ScriptMgnIntf.cpp base/StorageIntf.cpp base/SysInitIntf.cpp base/SystemIntf.cpp base/TextStream.cpp base/UtilStreams.cpp base/win32/EventImpl.cpp base/win32/FileSelector.cpp base/win32/FuncStubs.cpp base/win32/NativeEventQueue.cpp base/win32/PluginImpl.cpp base/win32/ScriptMgnImpl.cpp base/win32/StorageImpl.cpp base/win32/SusieArchive.cpp base/win32/SysInitImpl.cpp base/win32/SystemImpl.cpp base/XP3Archive.cpp 
ENVIRON_SOURCES += environ/win32/Application.cpp environ/win32/CompatibleNativeFuncs.cpp environ/win32/ConfigFormUnit.cpp environ/win32/DetectCPU.cpp environ/win32/EmergencyExit.cpp environ/win32/MouseCursor.cpp environ/win32/SystemControl.cpp environ/win32/TouchPoint.cpp environ/win32/TVPWindow.cpp environ/win32/VersionFormUnit.cpp environ/win32/WindowFormUnit.cpp environ/win32/WindowsUtil.cpp extension/Extension.cpp  
MOVIE_SOURCES += movie/win32/TVPVideoOverlay.cpp 
MSG_SOURCES += vcproj/tvpwin32.rc msg/MsgIntf.cpp msg/win32/MsgImpl.cpp msg/win32/MsgLoad.cpp msg/win32/ReadOptionDesc.cpp 
SOUND_SOURCES += sound/MathAlgorithms.cpp  sound/PhaseVocoderDSP.cpp sound/PhaseVocoderFilter.cpp sound/RealFFT.cpp sound/SoundBufferBaseIntf.cpp sound/WaveFormatConverter.cpp sound/WaveIntf.cpp sound/WaveLoopManager.cpp sound/WaveSegmentQueue.cpp sound/win32/SoundBufferBaseImpl.cpp sound/win32/tvpsnd.c sound/win32/WaveImpl.cpp  
TJS2_SOURCES += tjs2/tjs.cpp tjs2/tjs.tab.cpp tjs2/tjsArray.cpp tjs2/tjsBinarySerializer.cpp tjs2/tjsByteCodeLoader.cpp tjs2/tjsCompileControl.cpp tjs2/tjsConfig.cpp tjs2/tjsConstArrayData.cpp tjs2/tjsDate.cpp tjs2/tjsdate.tab.cpp tjs2/tjsDateParser.cpp tjs2/tjsDebug.cpp tjs2/tjsDictionary.cpp tjs2/tjsDisassemble.cpp tjs2/tjsError.cpp tjs2/tjsException.cpp tjs2/tjsGlobalStringMap.cpp tjs2/tjsInterCodeExec.cpp tjs2/tjsInterCodeGen.cpp tjs2/tjsInterface.cpp tjs2/tjsLex.cpp tjs2/tjsMath.cpp tjs2/tjsMessage.cpp tjs2/tjsMT19937ar-cok.cpp tjs2/tjsNamespace.cpp tjs2/tjsNative.cpp tjs2/tjsObject.cpp tjs2/tjsObjectExtendable.cpp tjs2/tjsOctPack.cpp tjs2/tjspp.tab.cpp tjs2/tjsRandomGenerator.cpp tjs2/tjsRegExp.cpp tjs2/tjsScriptBlock.cpp tjs2/tjsScriptCache.cpp tjs2/tjsString.cpp tjs2/tjsUtils.cpp tjs2/tjsVariant.cpp tjs2/tjsVariantString.cpp 
UTILS_SOURCES += utils/ClipboardIntf.cpp utils/cp932_uni.cpp utils/DebugIntf.cpp utils/md5.c utils/MiscUtility.cpp utils/Random.cpp utils/ThreadIntf.cpp utils/TickCount.cpp utils/TimerImpl.cpp utils/TimerIntf.cpp utils/uni_cp932.cpp utils/VelocityTracker.cpp utils/win32/ClipboardImpl.cpp utils/win32/ThreadImpl.cpp utils/win32/TVPTimer.cpp 
VISUAL_SOURCES += visual/BitmapIntf.cpp visual/BitmapLayerTreeOwner.cpp visual/CharacterData.cpp visual/ComplexRect.cpp visual/FontSystem.cpp visual/FreeType.cpp visual/FreeTypeFontRasterizer.cpp visual/gl/blend_function.cpp visual/gl/ResampleImage.cpp visual/gl/WeightFunctor.cpp visual/GraphicsLoaderIntf.cpp visual/GraphicsLoadThread.cpp visual/IA32/detect_cpu.cpp visual/ImageFunction.cpp visual/LayerBitmapImpl.cpp visual/LayerBitmapIntf.cpp visual/LayerIntf.cpp visual/LayerManager.cpp visual/LayerTreeOwnerImpl.cpp visual/LoadJPEG.cpp  visual/LoadPNG.cpp visual/LoadTLG.cpp visual/PrerenderedFont.cpp visual/RectItf.cpp visual/SaveTLG5.cpp visual/SaveTLG6.cpp visual/TransIntf.cpp visual/tvpgl.c visual/VideoOvlIntf.cpp visual/win32/BasicDrawDevice.cpp visual/win32/BitmapBitsAlloc.cpp visual/win32/BitmapInfomation.cpp visual/win32/DInputMgn.cpp visual/win32/DrawDevice.cpp visual/win32/GDIFontRasterizer.cpp visual/win32/GraphicsLoaderImpl.cpp visual/win32/LayerImpl.cpp visual/win32/NativeFreeTypeFace.cpp visual/win32/TVPScreen.cpp visual/win32/TVPSysFont.cpp visual/win32/VideoOvlImpl.cpp visual/win32/VSyncTimingThread.cpp visual/win32/WindowImpl.cpp visual/WindowIntf.cpp
LIBZ_SOURCES +=  external/zlib/adler32.c external/zlib/compress.c external/zlib/crc32.c external/zlib/deflate.c external/zlib/gzclose.c external/zlib/gzlib.c external/zlib/gzread.c external/zlib/gzwrite.c external/zlib/infback.c external/zlib/inffast.c external/zlib/inflate.c external/zlib/inftrees.c external/zlib/trees.c external/zlib/uncompr.c external/zlib/zutil.c
LIBPNG_SOURCES +=  external/lpng/png.c external/lpng/pngerror.c external/lpng/pngget.c external/lpng/pngmem.c external/lpng/pngpread.c external/lpng/pngread.c external/lpng/pngrio.c external/lpng/pngrtran.c external/lpng/pngrutil.c external/lpng/pngset.c external/lpng/pngtrans.c external/lpng/pngwio.c external/lpng/pngwrite.c external/lpng/pngwtran.c external/lpng/pngwutil.c
LIBONIG_SOURCES +=  external/onig/src/regerror.c external/onig/src/regparse.c external/onig/src/regext.c external/onig/src/regcomp.c external/onig/src/regexec.c external/onig/src/reggnu.c external/onig/src/regenc.c external/onig/src/regsyntax.c external/onig/src/regtrav.c external/onig/src/regversion.c external/onig/src/st.c external/onig/src/regposix.c external/onig/src/regposerr.c external/onig/src/onig_init.c external/onig/src/unicode.c external/onig/src/ascii.c external/onig/src/utf8.c external/onig/src/utf16_be.c external/onig/src/utf16_le.c external/onig/src/utf32_be.c external/onig/src/utf32_le.c external/onig/src/euc_jp.c external/onig/src/sjis.c external/onig/src/iso8859_1.c external/onig/src/iso8859_2.c external/onig/src/iso8859_3.c external/onig/src/iso8859_4.c external/onig/src/iso8859_5.c external/onig/src/iso8859_6.c external/onig/src/iso8859_7.c external/onig/src/iso8859_8.c external/onig/src/iso8859_9.c external/onig/src/iso8859_10.c external/onig/src/iso8859_11.c external/onig/src/iso8859_13.c external/onig/src/iso8859_14.c external/onig/src/iso8859_15.c external/onig/src/iso8859_16.c external/onig/src/euc_tw.c external/onig/src/euc_kr.c external/onig/src/big5.c external/onig/src/gb18030.c external/onig/src/koi8_r.c external/onig/src/cp1251.c external/onig/src/euc_jp_prop.c external/onig/src/sjis_prop.c external/onig/src/unicode_unfold_key.c external/onig/src/unicode_fold1_key.c external/onig/src/unicode_fold2_key.c external/onig/src/unicode_fold3_key.c
LIBJPEG_SOURCES +=  external/libjpeg-turbo/jcapimin.c external/libjpeg-turbo/jcapistd.c external/libjpeg-turbo/jccoefct.c external/libjpeg-turbo/jccolor.c external/libjpeg-turbo/jcdctmgr.c external/libjpeg-turbo/jchuff.c external/libjpeg-turbo/jcinit.c external/libjpeg-turbo/jcmainct.c external/libjpeg-turbo/jcmarker.c external/libjpeg-turbo/jcmaster.c external/libjpeg-turbo/jcomapi.c external/libjpeg-turbo/jcparam.c external/libjpeg-turbo/jcphuff.c external/libjpeg-turbo/jcprepct.c external/libjpeg-turbo/jcsample.c external/libjpeg-turbo/jctrans.c external/libjpeg-turbo/jdapimin.c external/libjpeg-turbo/jdapistd.c external/libjpeg-turbo/jdatadst.c external/libjpeg-turbo/jdatasrc.c external/libjpeg-turbo/jdcoefct.c external/libjpeg-turbo/jdcolor.c external/libjpeg-turbo/jddctmgr.c external/libjpeg-turbo/jdhuff.c external/libjpeg-turbo/jdinput.c external/libjpeg-turbo/jdmainct.c external/libjpeg-turbo/jdmarker.c external/libjpeg-turbo/jdmaster.c external/libjpeg-turbo/jdmerge.c external/libjpeg-turbo/jdphuff.c external/libjpeg-turbo/jdpostct.c external/libjpeg-turbo/jdsample.c external/libjpeg-turbo/jdtrans.c external/libjpeg-turbo/jerror.c external/libjpeg-turbo/jfdctflt.c external/libjpeg-turbo/jfdctfst.c external/libjpeg-turbo/jfdctint.c external/libjpeg-turbo/jidctflt.c external/libjpeg-turbo/jidctfst.c external/libjpeg-turbo/jidctint.c external/libjpeg-turbo/jidctred.c external/libjpeg-turbo/jquant1.c external/libjpeg-turbo/jquant2.c external/libjpeg-turbo/jutils.c external/libjpeg-turbo/jmemmgr.c external/libjpeg-turbo/jmemnobs.c external/libjpeg-turbo/jaricom.c external/libjpeg-turbo/jcarith.c external/libjpeg-turbo/jdarith.c external/libjpeg-turbo/simd/jsimd_i386.c external/libjpeg-turbo/turbojpeg.c external/libjpeg-turbo/transupp.c external/libjpeg-turbo/jdatadst-tj.c external/libjpeg-turbo/jdatasrc-tj.c external/libjpeg-turbo/simd/jccolor-mmx.asm external/libjpeg-turbo/simd/jccolor-sse2.asm external/libjpeg-turbo/simd/jcgray-mmx.asm external/libjpeg-turbo/simd/jcgray-sse2.asm external/libjpeg-turbo/simd/jchuff-sse2.asm external/libjpeg-turbo/simd/jcsample-mmx.asm external/libjpeg-turbo/simd/jcsample-sse2.asm external/libjpeg-turbo/simd/jdcolor-mmx.asm external/libjpeg-turbo/simd/jdcolor-sse2.asm external/libjpeg-turbo/simd/jdmerge-mmx.asm external/libjpeg-turbo/simd/jdmerge-sse2.asm external/libjpeg-turbo/simd/jdsample-mmx.asm external/libjpeg-turbo/simd/jdsample-sse2.asm external/libjpeg-turbo/simd/jfdctflt-3dn.asm external/libjpeg-turbo/simd/jfdctflt-sse.asm external/libjpeg-turbo/simd/jfdctfst-mmx.asm external/libjpeg-turbo/simd/jfdctfst-sse2.asm external/libjpeg-turbo/simd/jfdctint-mmx.asm external/libjpeg-turbo/simd/jfdctint-sse2.asm external/libjpeg-turbo/simd/jidctflt-3dn.asm external/libjpeg-turbo/simd/jidctflt-sse.asm external/libjpeg-turbo/simd/jidctflt-sse2.asm external/libjpeg-turbo/simd/jidctfst-mmx.asm external/libjpeg-turbo/simd/jidctfst-sse2.asm external/libjpeg-turbo/simd/jidctint-mmx.asm external/libjpeg-turbo/simd/jidctint-sse2.asm external/libjpeg-turbo/simd/jidctred-mmx.asm external/libjpeg-turbo/simd/jidctred-sse2.asm external/libjpeg-turbo/simd/jquant-3dn.asm external/libjpeg-turbo/simd/jquant-mmx.asm external/libjpeg-turbo/simd/jquant-sse.asm external/libjpeg-turbo/simd/jquantf-sse2.asm external/libjpeg-turbo/simd/jquanti-sse2.asm external/libjpeg-turbo/simd/jsimdcpu.asm
LIBFREETYPE_SOURCES +=  external/freetype/src/autofit/autofit.c external/freetype/src/bdf/bdf.c external/freetype/src/cff/cff.c external/freetype/src/base/ftbase.c external/freetype/src/base/ftbitmap.c external/freetype/src/cache/ftcache.c external/freetype/builds/windows/ftdebug.c external/freetype/src/base/ftfstype.c external/freetype/src/base/ftgasp.c external/freetype/src/base/ftglyph.c external/freetype/src/gzip/ftgzip.c external/freetype/src/base/ftinit.c external/freetype/src/lzw/ftlzw.c external/freetype/src/base/ftstroke.c external/freetype/src/base/ftsystem.c external/freetype/src/smooth/smooth.c external/freetype/src/base/ftbbox.c external/freetype/src/base/ftfntfmt.c external/freetype/src/base/ftmm.c external/freetype/src/base/ftpfr.c external/freetype/src/base/ftsynth.c external/freetype/src/base/fttype1.c external/freetype/src/base/ftwinfnt.c external/freetype/src/base/ftlcdfil.c external/freetype/src/base/ftgxval.c external/freetype/src/base/ftotval.c external/freetype/src/base/ftpatent.c external/freetype/src/pcf/pcf.c external/freetype/src/pfr/pfr.c external/freetype/src/psaux/psaux.c external/freetype/src/pshinter/pshinter.c external/freetype/src/psnames/psmodule.c external/freetype/src/raster/raster.c external/freetype/src/sfnt/sfnt.c external/freetype/src/truetype/truetype.c external/freetype/src/type1/type1.c external/freetype/src/cid/type1cid.c external/freetype/src/type42/type42.c external/freetype/src/winfonts/winfnt.c
SOURCES := $(BASE_SOURCES) $(ENVIRON_SOURCES) $(MOVIE_SOURCES) $(MSG_SOURCES) $(SOUND_SOURCES) $(TJS2_SOURCES) $(UTILS_SOURCES) $(VISUAL_SOURCES) $(LIBZ_SOURCES) $(LIBPNG_SOURCES) $(LIBONIG_SOURCES) $(LIBJPEG_SOURCES) $(LIBFREETYPE_SOURCES)
# BASECLASSES_SOURCES +=  external/baseclasses/amextra.cpp external/baseclasses/amfilter.cpp external/baseclasses/amvideo.cpp external/baseclasses/arithutil.cpp external/baseclasses/combase.cpp external/baseclasses/cprop.cpp external/baseclasses/ctlutil.cpp external/baseclasses/ddmm.cpp external/baseclasses/dllentry.cpp external/baseclasses/dllsetup.cpp external/baseclasses/mtype.cpp external/baseclasses/outputq.cpp external/baseclasses/perflog.cpp external/baseclasses/pstream.cpp external/baseclasses/pullpin.cpp external/baseclasses/refclock.cpp external/baseclasses/renbase.cpp external/baseclasses/schedule.cpp external/baseclasses/seekpt.cpp external/baseclasses/source.cpp external/baseclasses/strmctl.cpp external/baseclasses/sysclock.cpp external/baseclasses/transfrm.cpp external/baseclasses/transip.cpp external/baseclasses/videoctl.cpp external/baseclasses/vtrans.cpp external/baseclasses/winctrl.cpp external/baseclasses/winutil.cpp external/baseclasses/wxdebug.cpp external/baseclasses/wxlist.cpp external/baseclasses/wxutil.cpp
# DISABLED_SOURCES +=  movie/win32/asyncio.cpp movie/win32/asyncrdr.cpp movie/win32/BufferRenderer.cpp movie/win32/CDemuxOutputPin.cpp movie/win32/CDemuxSource.cpp movie/win32/CMediaSeekingProxy.cpp movie/win32/CVMRCustomAllocatorPresenter9.cpp movie/win32/CWMAllocator.cpp movie/win32/CWMBuffer.cpp movie/win32/CWMReader.cpp movie/win32/DShowException.cpp movie/win32/dslayerd.cpp movie/win32/dsmixer.cpp movie/win32/dsmovie.cpp movie/win32/dsoverlay.cpp movie/win32/IBufferRenderer_i.c movie/win32/IRendererBufferAccess_i.c movie/win32/IRendererBufferVideo_i.c movie/win32/krlmovie.cpp movie/win32/krmmovie.cpp movie/win32/krmovie.cpp movie/win32/MFPlayer.cpp movie/win32/PlayWindow.cpp sound/MathAlgorithms_SSE.cpp sound/RealFFT_SSE.cpp sound/WaveFormatConverter_SSE.cpp sound/xmmlib.cpp visual/gl/blend_function_avx2.cpp visual/gl/blend_function_sse2.cpp visual/gl/boxblur_sse2.cpp visual/gl/colorfill_sse2.cpp visual/gl/colormap_sse2.cpp visual/gl/pixelformat_sse2.cpp visual/gl/ResampleImageAVX2.cpp visual/gl/ResampleImageSSE2.cpp visual/gl/tlg_sse2.cpp visual/gl/univtrans_sse2.cpp visual/IA32/tvpgl_ia32_intf.c visual/gl/adjust_color_sse2.cpp visual/gl/x86simdutil.cpp visual/gl/x86simdutilAVX2.cpp visual/LoadJXR.cpp

OBJECTS := $(SOURCES:.c=.o)
OBJECTS := $(OBJECTS:.cpp=.o)
OBJECTS := $(OBJECTS:.asm=.o)
OBJECTS := $(OBJECTS:.rc=.o)

BINARY ?= tvpwin32.exe
ARCHIVE ?= tvpwin32.$(GIT_HASH).7z

all: $(BINARY)

archive: $(ARCHIVE)

clean:
	rm -f $(OBJECTS) $(BINARY) $(ARCHIVE)

$(ARCHIVE): $(BINARY)
	rm -f $(ARCHIVE)
	7z a $@ $^

$(BINARY): $(OBJECTS) 
	@echo -e "\tLNK $@"
	$(CXX) $(CFLAGS) $(LDFLAGS)  -o $@ $^  $(LDLIBS)
