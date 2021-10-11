unit ScreenShot;
(******************************************************************************
 ******************************************************************************
 ***                                                                        ***
 ***   Screenshot Unit (exposes 4-7 functions and 1 object)                 ***
 ***   Version [1.11e]                              {Last mod 2004-02-22}   ***
 ***                                                                        ***
 ******************************************************************************
 ******************************************************************************

                                 _\\|//_
                                (` * * ')
 ______________________________ooO_(_)_Ooo_____________________________________
 ******************************************************************************
 ******************************************************************************
 ***                                                                        ***
 ***                Copyright (c) 1995 - 2003 by -=Assarbad=-               ***
 ***                   Portions Copyright Microsoft Corp.                   ***
 ***                                                                        ***
 ***   CONTACT TO THE AUTHOR(S):                                            ***
 ***    ____________________________________                                ***
 ***   |                                    |                               ***
 ***   | -=Assarbad=- aka Oliver            |                               ***
 ***   |____________________________________|                               ***
 ***   |                                    |                               ***
 ***   | Assarbad@gmx.info|.net|.com|.de    |                               ***
 ***   | ICQ: 281645                        |                               ***
 ***   | AIM: nixlosheute                   |                               ***
 ***   |      nixahnungnicht                |                               ***
 ***   | MSN: Assarbad@ePost.de             |                               ***
 ***   | YIM: sherlock_holmes_and_dr_watson |                               ***
 ***   |____________________________________|                               ***
 ***             ___                                                        ***
 ***            /   |                     ||              ||                ***
 ***           / _  |   ________ ___  ____||__    ___   __||                ***
 ***          / /_\ |  / __/ __//   |/  _/|   \  /   | /   |                ***
 ***         / ___  |__\\__\\  / /\ || |  | /\ \/ /\ |/ /\ | DOT NET        ***
 ***        /_/   \_/___/___/ /_____\|_|  |____/_____\\__/\|                ***
 ***       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~        ***
 ***              [http://assarbad.net | http://assarbad.org]               ***
 ***                                                                        ***
 ***   Notes:                                                               ***
 ***   - my first name is Oliver, you may well use this in your e-mails     ***
 ***   - for questions and/or proposals drop me a mail or instant message   ***
 ***                                                                        ***
 ***~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~***
 ***              May the source be with you, stranger ... ;)               ***
 ***    Snizhok, eto ne tolko fruktovij kefir, snizhok, eto stil zhizn.     ***
 ***                     Vsem Privet iz Germanij                            ***
 ***                                                                        ***
 *** Greets from -=Assarbad=- fly to YOU =)                                 ***
 *** Special greets fly 2 Nico, Casper, SA, Pizza, Navarion, Eugen, Zhenja, ***
 *** Xandros, Melkij, Strelok etc pp.                                       ***
 ***                                                                        ***
 *** Thanks to:                                                             ***
 *** W.A. Mozart, Vivaldi, Beethoven, Poeata Magica, Kurtzweyl, Manowar,    ***
 *** Blind Guardian, Weltenbrand, In Extremo, Wolfsheim, Carl Orff, Zemfira ***
 *** ... most of my work was done with their music in the background ;)     ***
 ***                                                                        ***
 ******************************************************************************
 ******************************************************************************

 LEGAL STUFF:
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Copyright (c) 1995-2003, -=Assarbad=- ["copyright holder(s)"]
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
 3. The name(s) of the copyright holder(s) may not be used to endorse or
    promote products derived from this software without specific prior written
    permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                             .oooO     Oooo.
 ____________________________(   )_____(   )___________________________________
                              \ (       ) /
                               \_)     (_/

 ******************************************************************************)

(******************************************************************************
  Version History:
  ----------------

  v.1.11e [2004-02-22]
  - Changes the PathForFiles property into a function
  v.1.11d [2004-02-17 - 2004-02-19]
  - Added TimeSaveWindow() and TimeSaveDesktop() methods.
  v.1.11c [2003-05-03]
  - Fixed another flaw in the PngSupport.pas that caused color distortion.
  v.1.11b [2003-04-22]
  - Fixed small flaw in the PngSupport.pas that caused color distortion at the
    left border of the PNG image.
  v.1.11a [2003-04-21]
  - Fixed a small bug that did not allow to save BMPs if "PNGSAVESUPPORT" was
    defined, but no LibPng DLL existed.
  v.1.11 [2003-04-21]
  - Added support for saving to PNG! It is optional and can be turned of
    completely by undefining "PNGSAVESUPPORT".
  - You can override the default behavior (which is to save to PNG, if the resp.
    flag is defined) by setting "TScreenShot.BmpEnforced".
  - Should be definitely compatible with Delphi 4. Delphi 3 is only partially
    supported!!!
  - Valid library name included are "libpng.dll" and "lpng.dll".
  v.1.10 [2003-04-20]
  - Now defining an object "TScreenShot" that exposes most of the functionality
    the implemented functions contain and can provide ;)
  - "AUTOLOAD" Determines wether an instance of the "TScreenShot" object is
    created when the unit loads ...
  v.1.01 [2003-04-17]
  - Reordered the "ScreenShotThis()" function and publishing 2 more functions.
  v.1.0 [2002-10-14]
  - Initial release. This is roughly speaking a conversion of big parts of an
    example from the August 2002 PSDK. Since writing BMP is very tricky (mostly
    because of the bit depth below 16), this was the easiest to do.
 ******************************************************************************)

interface
{$INCLUDE CompilerSwitches.Pas}
uses
  Windows;

{$DEFINE AUTOLOAD}

type
  TScreenShot = class
  private
    FDIB: THandle;
    FCompress: Boolean;
    FScreenRect: TRect;
    FDC: HDC;
    FAppWnd: HWND;
    FAutohideApp: Boolean;
    FAutoSaveMask: string;
    FInternalCounter: Word;
    FVerbose: Boolean;
    FPathForFiles: string;
{$IFDEF PNGSAVESUPPORT}
    FPngSupported: Boolean;
    FBmpEnforced: Boolean;
    FDIBisBMP: Boolean;
    FExtension: TPoint;
    FWait: Integer;
    procedure SetBmpEnforced(b: Boolean);
{$ENDIF}
    procedure SetRLECompression(b: Boolean);
    procedure SetAutohide(b: Boolean);
    procedure SetAppWnd(wnd: HWND);
    procedure HideApp(hwnd: HWND); // hwnd holds the handle to the window to capture!!! (not the app window!)
    procedure RestoreApp(hwnd: HWND); // ergo ...
    procedure SetVerbose(b: Boolean);
  public
    property UseRLE: Boolean read FCompress write SetRLECompression;
    property AppWnd: HWND read FAppWnd write SetAppWnd;
    property AutohideApp: Boolean read FAutohideApp write SetAutohide;
    property AutoSaveMask: string read FAutoSaveMask; // May be changed to readwrite lateron ;)
    property Verbose: Boolean read FVerbose write SetVerbose;
    property Wait: Integer read FWait write FWait default 200; // ms to wait after the application window is hidden
{$IFDEF PNGSAVESUPPORT}
    property BmpEnforced: Boolean read FBmpEnforced write SetBmpEnforced;
{$ENDIF}
    constructor Create; overload;
    constructor Create(wnd: HWND); overload; // wnd is the Window of the application (for autohide feature)
    destructor Destroy;
    function Window(hwnd: HWND): Boolean; // captures the contents of a window
    function Desktop: Boolean; // ... same but for desktop
    procedure Free; // ... free all data (including the DIB)
    function Save(fname: string): Boolean; // Save under the given file name - free picture manually!!!
    function SaveAs: Boolean; // Show the windows standard dialog for saving a file ...
    function SaveAndFree(fname: string): Boolean; // Same as Save, but includes freeing the picture
    function SaveAsAndFree: Boolean; // Will provide the SaveAs-Dialog
    function AutoSaveWindow(hwnd: HWND): Boolean; // Saves window contents to a sequentially numbered file
    function AutoSaveDesktop: Boolean; // ... same for desktop
    function TimeSaveWindow(hwnd: HWND): Boolean; // Saves window contents to a file named after current time
    function TimeSaveDesktop: Boolean; // ... same for desktop
    procedure ResetInternalCounter;
    function PathForFiles(s: string):Boolean;
  end;

var
  SShot: TScreenShot;

//------------------------------------------------------------------------------
// PUBLIC FUNCTIONS
//------------------------------------------------------------------------------
function ScreenShotThisInit(hwnd: HWND; noCompress: Boolean): THandle;
function ScreenShotThisFinit(DIB: THandle; fname: string): Boolean;
function ScreenShotThis(hwnd: HWND; fname: string; noCompress: Boolean): Boolean;
procedure ProcessMessages(hwnd: HWND);
{$IFDEF PNGSAVESUPPORT}
function InitPnglib(libname: string): Boolean;
procedure DeInitPngLib;
function SavehBmp2PngFile(Filename: string; hBmp: hBitmap; dx, dy: Integer; Alpha: COLORREF): Boolean;
{$ENDIF}
//------------------------------------------------------------------------------
implementation
uses
  Commdlg;

{$INCLUDE FormatString.pas}

const
  display = 'DISPLAY';
  bmp_defmask = 'Screenshot%4.4d.bmp';
  png_defmask = 'Screenshot%4.4d.png';
  bmp_ext = 'bmp';
  bmp_filterstring = 'Bitmap files'#0'*.' + bmp_ext + #0#0;
  png_ext = 'png';
  png_filterstring = 'PNG files'#0'*.' + png_ext + #0#0;

procedure ProcessMessages(hwnd: HWND);
var
  msg: TMsg;
begin
  while PeekMessage(msg, 0, 0, 0, PM_REMOVE) do
    if not IsDialogMessage(hwnd, msg) then
    begin
      TranslateMessage(msg);
      DispatchMessage(msg);
    end;
end;

//------------------------------------------------------------------------------
// FORWARD DECLARATIONS (NEEDED!)
//------------------------------------------------------------------------------
function CopyScreenToDIB(const Rect: TRect): THandle; forward;
function CopyWindowToBitmap(Wnd: HWND; fPrintArea: DWORD): HBITMAP; forward;
function CopyScreenToBitmap(Rect: TRect): HBITMAP; forward;
function ReadDIBFile(hFile: THandle): THandle; forward;

const
  PALVERSION = $300;
//* Print Area selection */
  PW_WINDOW = 1;
  PW_CLIENT = 2;

//------------------------------------------------------------------------------
// DIB MACROS
//------------------------------------------------------------------------------
const
// Dib Header Marker - used in writing DIBs to files
  DIB_HEADER_MARKER = (ord('M') shl 8) or ord('B');

// WIDTHBYTES performs DWORD-aligning of DIB scanlines.  The "bits"
// parameter is the bit count for the scanline (biWidth * biBitCount),
// and this macro returns the number of DWORD-aligned bytes needed
// to hold those bits.

function WIDTHBYTES(bits: Integer): Integer;
begin
  result := (((bits) + 31) div 32 * 4)
end;

function IS_WIN30_DIB(lpbi: PChar): BOOL;
begin
  result := PDWORD(lpbi)^ = sizeof(BITMAPINFOHEADER);
end;

function RECTWIDTH(Rect: TRect): Integer;
begin
  result := Rect.right - Rect.left;
end;

function RECTHEIGHT(Rect: TRect): Integer;
begin
  result := Rect.bottom - Rect.top;
end;

(*************************************************************************
 *
 * DIBNumColors()
 *
 * Parameter:
 *
 * PChar lpDIB      - pointer to packed-DIB memory block
 *
 * Return Value:
 *
 * WORD             - number of colors in the color table
 *
 * Description:
 *
 * This function calculates the number of colors in the DIB's color table
 * by finding the bits per pixel for the DIB (whether Win3.0 or OS/2-style
 * DIB). If bits per pixel is 1: colors=2, if 4: colors=16, if 8: colors=256,
 * if 24, no colors in color table.
 *
 ************************************************************************)

function DIBNumColors(lpDIB: PChar): DWORD;
var
  wBitCount: WORD; // DIB bit count
  dwClrUsed: DWORD;
begin
  result := 0;
  if Assigned(lpDIB) then
  begin
// If this is a Windows-style DIB, the number of colors in the
// color table can be less than the number of bits per pixel
// allows for (i.e. lpbi->biClrUsed can be set to some value).
// If this is the case, return the appropriate value.
    if (IS_WIN30_DIB(lpDIB)) then
    begin
      dwClrUsed := PBITMAPINFOHEADER(lpDIB)^.biClrUsed;
      if (dwClrUsed) <> 0 then
      begin
        result := dwClrUsed;
        exit;
      end;
    end;
// Calculate the number of colors in the color table based on
// the number of bits per pixel for the DIB.
    case IS_WIN30_DIB(lpDIB) of
      TRUE: wBitCount := PBITMAPINFOHEADER(lpDIB)^.biBitCount;
    else wBitCount := PBITMAPCOREHEADER(lpDIB)^.bcBitCount;
    end;
// return number of colors based on bits per pixel
    case wBitCount of
      1:
        result := 2;
      4:
        result := 16;
      8:
        result := 256;
    else
      result := 0;
    end;
  end;
end;

(*************************************************************************
 *
 * PaletteSize()
 *
 * Parameter:
 *
 * PChar lpDIB      - pointer to packed-DIB memory block
 *
 * Return Value:
 *
 * WORD             - size of the color palette of the DIB
 *
 * Description:
 *
 * This function gets the size required to store the DIB's palette by
 * multiplying the number of colors by the size of an RGBQUAD (for a
 * Windows 3.0-style DIB) or by the size of an RGBTRIPLE (for an OS/2-
 * style DIB).
 *
 ************************************************************************)

function PaletteSize(lpDIB: PChar): DWORD;
begin
  result := 0;
  if assigned(lpDIB) then
  begin
// calculate the size required by the palette
    case IS_WIN30_DIB(lpDIB) of
      TRUE:
        result := DIBNumColors(lpDIB) * sizeof(RGBQUAD);
    else
      result := DIBNumColors(lpDIB) * sizeof(RGBTRIPLE);
    end;
  end;
end;

(*************************************************************************
 *
 * CreateDIB()
 *
 * Parameters:
 *
 * DWORD dwWidth    - Width for new bitmap, in pixels
 * DWORD dwHeight   - Height for new bitmap
 * WORD  wBitCount  - Bit Count for new DIB (1, 4, 8, or 24)
 *
 * Return Value:
 *
 * HDIB             - Handle to new DIB
 *
 * Description:
 *
 * This function allocates memory for and initializes a new DIB by
 * filling in the BITMAPINFOHEADER, allocating memory for the color
 * table, and allocating memory for the bitmap bits.  As with all
 * HDIBs, the header, colortable and bits are all in one contiguous
 * memory block.  This function is similar to the CreateBitmap()
 * Windows API.
 *
 * The colortable and bitmap bits are left uninitialized (zeroed) in the
 * returned HDIB.
 *
 *
 ************************************************************************)

function CreateDIB(dwWidth: DWORD; dwHeight: DWORD; wBitCount: DWORD): THandle;
var
  bi: BITMAPINFOHEADER; // bitmap header
  lpbi: PBITMAPINFOHEADER; // pointer to BITMAPINFOHEADER
  dwLen: DWORD; // size of memory block
  DIB: THandle;
  dwBytesPerLine: DWORD; // Number of bytes per scanline

begin
// Make sure bits per pixel is valid
  if (wBitCount <= 1) then
    wBitCount := 1
  else if (wBitCount <= 4) then
    wBitCount := 4
  else if (wBitCount <= 8) then
    wBitCount := 8
  else if (wBitCount <= 24) then
    wBitCount := 24
  else if (wBitCount <= 32) then
    wBitCount := 32
  else
    wBitCount := 4; // set default value to 4 if parameter is bogus
// initialize BITMAPINFOHEADER
  bi.biSize := sizeof(BITMAPINFOHEADER);
  bi.biWidth := dwWidth; // fill in width from parameter
  bi.biHeight := dwHeight; // fill in height from parameter
  bi.biPlanes := 1; // must be 1
  bi.biBitCount := wBitCount; // from parameter
  bi.biCompression := BI_RGB;
  bi.biSizeImage := 0; // 0's here mean "default"
  bi.biXPelsPerMeter := 0;
  bi.biYPelsPerMeter := 0;
  bi.biClrUsed := 0;
  bi.biClrImportant := 0;
// calculate size of memory block required to store the DIB.  This
// block should be big enough to hold the BITMAPINFOHEADER, the color
// table, and the bits
  dwBytesPerLine := WIDTHBYTES(wBitCount * dwWidth);
  dwLen := bi.biSize + PaletteSize(PChar(@bi)) + (dwBytesPerLine * dwHeight);
// alloc memory block to store our bitmap
  DIB := GlobalAlloc(GHND, dwLen);
// major bummer if we couldn't get memory block
  if DIB = 0 then
  begin
    result := 0;
    exit;
  end;
// lock memory and get pointer to it
  lpbi := GlobalLock(DIB);
// use our bitmap info structure to fill in first part of
// our DIB with the BITMAPINFOHEADER
  CopyMemory(lpbi, @bi, sizeof(bi));
// Since we don't know what the colortable and bits should contain,
// just leave these blank.  Unlock the DIB and return the HDIB.
  GlobalUnlock(DIB);
// return handle to the DIB
  result := DIB;
end;

(*************************************************************************
 *
 * FindDIBBits()
 *
 * Parameter:
 *
 * PChar lpDIB      - pointer to packed-DIB memory block
 *
 * Return Value:
 *
 * PChar            - pointer to the DIB bits
 *
 * Description:
 *
 * This function calculates the address of the DIB's bits and returns a
 * pointer to the DIB bits.
 *
 ************************************************************************)

function FindDIBBits(lpDIB: PChar): PChar;
begin
  case Assigned(lpDIB) of
    TRUE:
      result := lpDIB + PDWORD(lpDIB)^ + PaletteSize(lpDIB);
  else
    result := nil;
  end;
end;

(*************************************************************************
 *
 * DIBWidth()
 *
 * Parameter:
 *
 * PChar lpDIB      - pointer to packed-DIB memory block
 *
 * Return Value:
 *
 * DWORD            - width of the DIB
 *
 * Description:
 *
 * This function gets the width of the DIB from the BITMAPINFOHEADER
 * width field if it is a Windows 3.0-style DIB or from the BITMAPCOREHEADER
 * width field if it is an OS/2-style DIB.
 *
 ************************************************************************)

function DIBWidth(lpDIB: PChar): DWORD;
var
  lpbmi: PBITMAPINFOHEADER; // pointer to a Win 3.0-style DIB
  lpbmc: PBITMAPCOREHEADER; // pointer to an OS/2-style DIB
begin
  result := 0;
  if Assigned(lpDIB) then
  begin
// point to the header (whether Win 3.0 and OS/2)
    lpbmi := PBITMAPINFOHEADER(lpDIB);
    lpbmc := PBITMAPCOREHEADER(lpDIB);
    case lpbmi^.biSize = sizeof(BITMAPINFOHEADER) of
// return the DIB width if it is a Win 3.0 DIB
      TRUE:
        result := lpbmi^.biWidth;
    else
// it is an OS/2 DIB, so return its width
      result := DWORD(lpbmc^.bcWidth);
    end;
  end;
end;

(*************************************************************************
 *
 * DIBHeight()
 *
 * Parameter:
 *
 * PChar lpDIB      - pointer to packed-DIB memory block
 *
 * Return Value:
 *
 * DWORD            - height of the DIB
 *
 * Description:
 *
 * This function gets the height of the DIB from the BITMAPINFOHEADER
 * height field if it is a Windows 3.0-style DIB or from the BITMAPCOREHEADER
 * height field if it is an OS/2-style DIB.
 *
 ************************************************************************)

function DIBHeight(lpDIB: PChar): DWORD;
var
  lpbmi: PBITMAPINFOHEADER; // pointer to a Win 3.0-style DIB
  lpbmc: PBITMAPCOREHEADER; // pointer to an OS/2-style DIB
begin
  result := 0;
  if Assigned(lpDIB) then
  begin
// point to the header (whether Win 3.0 and OS/2)
    lpbmi := PBITMAPINFOHEADER(lpDIB);
    lpbmc := PBITMAPCOREHEADER(lpDIB);
    case lpbmi^.biSize = sizeof(BITMAPINFOHEADER) of
// return the DIB height if it is a Win 3.0 DIB
      TRUE:
        result := lpbmi^.biHeight;
    else
// it is an OS/2 DIB, so return its height
      result := DWORD(lpbmc^.bcHeight);
    end;
  end;
end;

(*************************************************************************
 *
 * CreateDIBPalette()
 *
 * Parameter:
 *
 * HDIB hDIB        - specifies the DIB
 *
 * Return Value:
 *
 * HPALETTE         - specifies the palette
 *
 * Description:
 *
 * This function creates a palette from a DIB by allocating memory for the
 * logical palette, reading and storing the colors from the DIB's color table
 * into the logical palette, creating a palette from this logical palette,
 * and then returning the palette's handle. This allows the DIB to be
 * displayed using the best possible colors (important for DIBs with 256 or
 * more colors).
 *
 ************************************************************************)

function CreateDIBPalette(DIB: THandle): HPALETTE;
var
  lpPal: PLOGPALETTE; // pointer to a logical palette
  hLogPal: THandle; // handle to a logical palette
  hPal: HPALETTE; // handle to a palette
  i, wNumColors: Integer; // loop index, number of colors in color table
  lpbi: PChar; // pointer to packed-DIB
  lpbmi: PBITMAPINFO; // pointer to BITMAPINFO structure (Win3.0)
  lpbmc: PBITMAPCOREINFO; // pointer to BITMAPCOREINFO structure (OS/2)
  bWinStyleDIB: BOOL; // Win3.0 DIB?
begin
  hPal := 0;
  hLogPal := 0;
  result := 0;
// if handle to DIB is invalid, return NULL
  if DIB <> 0 then
  begin
// lock DIB memory block and get a pointer to it
    lpbi := GlobalLock(DIB);
// get pointer to BITMAPINFO (Win 3.0)
    lpbmi := PBITMAPINFO(lpbi);
// get pointer to BITMAPCOREINFO (OS/2 1.x)
    lpbmc := PBITMAPCOREINFO(lpbi);
// get the number of colors in the DIB
    wNumColors := DIBNumColors(lpbi);
// is this a Win 3.0 DIB?
    bWinStyleDIB := IS_WIN30_DIB(lpbi);
    if wNumColors <> 0 then
    begin
// allocate memory block for logical palette
      hLogPal := GlobalAlloc(GHND, sizeof(LOGPALETTE) + sizeof(PALETTEENTRY) * wNumColors);
// if not enough memory, clean up and return NULL
      if hLogPal = 0 then
      begin
        GlobalUnlock(DIB);
        exit;
      end;
// lock memory block and get pointer to it
      lpPal := PLOGPALETTE(GlobalLock(hLogPal));
// set version and number of palette entries
      lpPal^.palVersion := PALVERSION;
      lpPal^.palNumEntries := WORD(wNumColors);
// store RGB triples (if Win 3.0 DIB) or RGB quads (if OS/2 DIB)
// into palette
      for i := 0 to wNumColors - 1 do
        case bWinStyleDIB of
          TRUE:
            begin
              lpPal^.palPalEntry[i].peRed := lpbmi^.bmiColors[i].rgbRed;
              lpPal^.palPalEntry[i].peGreen := lpbmi^.bmiColors[i].rgbGreen;
              lpPal^.palPalEntry[i].peBlue := lpbmi^.bmiColors[i].rgbBlue;
              lpPal^.palPalEntry[i].peFlags := 0;
            end;
        else
          begin
            lpPal^.palPalEntry[i].peRed := lpbmc^.bmciColors[i].rgbtRed;
            lpPal^.palPalEntry[i].peGreen := lpbmc^.bmciColors[i].rgbtGreen;
            lpPal^.palPalEntry[i].peBlue := lpbmc^.bmciColors[i].rgbtBlue;
            lpPal^.palPalEntry[i].peFlags := 0;
          end;
        end;
// create the palette and get handle to it
      hPal := CreatePalette(lpPal^);
// if error getting handle to palette, clean up and return NULL
      if hPal = 0 then
      begin
        GlobalUnlock(hLogPal);
        GlobalFree(hLogPal);
        exit;
      end;
    end; // if
// clean up
    GlobalUnlock(hLogPal);
    GlobalFree(hLogPal);
    GlobalUnlock(DIB);
// return handle to DIB's palette
    result := hPal;
  end;
end;

(*************************************************************************
 *
 * DIBToBitmap()
 *
 * Parameters:
 *
 * HDIB hDIB        - specifies the DIB to convert
 *
 * HPALETTE hPal    - specifies the palette to use with the bitmap
 *
 * Return Value:
 *
 * HBITMAP          - identifies the device-dependent bitmap
 *
 * Description:
 *
 * This function creates a bitmap from a DIB using the specified palette.
 * If no palette is specified, default is used.
 *
 * NOTE:
 *
 * The bitmap returned from this funciton is always a bitmap compatible
 * with the screen (e.g. same bits/pixel and color planes) rather than
 * a bitmap with the same attributes as the DIB.  This behavior is by
 * design, and occurs because this function calls CreateDIBitmap to
 * do its work, and CreateDIBitmap always creates a bitmap compatible
 * with the hDC parameter passed in (because it in turn calls
 * CreateCompatibleBitmap).
 *
 * So for instance, if your DIB is a monochrome DIB and you call this
 * function, you will not get back a monochrome HBITMAP -- you will
 * get an HBITMAP compatible with the screen DC, but with only 2
 * colors used in the bitmap.
 *
 * If your application requires a monochrome HBITMAP returned for a
 * monochrome DIB, use the function SetDIBits().
 *
 * Also, the DIBpassed in to the function is not destroyed on exit. This
 * must be done later, once it is no longer needed.
 *
 ************************************************************************)

function DIBToBitmap(DIB: THandle; hPal: HPALETTE): HBITMAP;
var
  lpDIBHdr, lpDIBBits: PChar; // pointer to DIB header, pointer to DIB bits
  hbmp: HBITMAP; // handle to device-dependent bitmap
  DC: HDC; // handle to DC
  hOldPal: HPALETTE; // handle to a palette
begin
  hOldPal := 0;
  result := 0;
// if invalid handle, return NULL
  if DIB <> 0 then
  begin
// lock memory block and get a pointer to it
    lpDIBHdr := GlobalLock(DIB);
// get a pointer to the DIB bits
    lpDIBBits := FindDIBBits(lpDIBHdr);
    if not Assigned(lpDIBBits) then
    begin
      GlobalUnlock(DIB);
      exit;
    end;
// get a DC
    DC := GetDC(0);
    if DC = 0 then
    begin
// clean up and return NULL
      GlobalUnlock(DIB);
      exit;
    end;
// select and realize palette
    if hPal <> 0 then
      hOldPal := SelectPalette(DC, hPal, FALSE);
    RealizePalette(DC);
// create bitmap from DIB info. and bits
    hbmp := CreateDIBitmap(DC, PBITMAPINFOHEADER(lpDIBHdr)^, CBM_INIT, lpDIBBits, PBITMAPINFO(lpDIBHdr)^, DIB_RGB_COLORS);
// restore previous palette
    if hOldPal <> 0 then
      SelectPalette(DC, hOldPal, FALSE);
// clean up
    ReleaseDC(0, DC);
    GlobalUnlock(DIB);
// return handle to the bitmap
    result := hbmp;
  end;
end;

(*************************************************************************
 *
 * BitmapToDIB()
 *
 * Parameters:
 *
 * HBITMAP hBitmap  - specifies the bitmap to convert
 *
 * HPALETTE hPal    - specifies the palette to use with the bitmap
 *
 * Return Value:
 *
 * HDIB             - identifies the device-dependent bitmap
 *
 * Description:
 *
 * This function creates a DIB from a bitmap using the specified palette.
 *
 ************************************************************************)

function BitmapToDIB(hbmp: HBITMAP; hPal: HPALETTE): THandle;
var
  bm: BITMAP; // bitmap structure
  bi: BITMAPINFOHEADER; // bitmap header
  lpbi: PBITMAPINFOHEADER; // pointer to BITMAPINFOHEADER
  dwLen: DWORD; // size of memory block
  DIB, h: THandle; // handle to DIB, temp handle
  DC: HDC; // handle to DC
  biBits: WORD; // bits per pixel
begin
  result := 0;
// check if bitmap handle is valid
  if hbmp <> 0 then
  begin
// fill in BITMAP structure, return NULL if it didn't work
    if GetObject(hBmp, sizeof(bm), @bm) = 0 then
      exit;
// if no palette is specified, use default palette
    if hPal = 0 then
      hPal := GetStockObject(DEFAULT_PALETTE);
// calculate bits per pixel
    biBits := bm.bmPlanes * bm.bmBitsPixel;
// make sure bits per pixel is valid
    if (biBits <= 1) then
      biBits := 1
    else if (biBits <= 4) then
      biBits := 4
    else if (biBits <= 8) then
      biBits := 8
    else
// if greater than 8-bit, force to 24-bit
      biBits := 24;
// initialize BITMAPINFOHEADER
    bi.biSize := sizeof(BITMAPINFOHEADER);
    bi.biWidth := bm.bmWidth;
    bi.biHeight := bm.bmHeight;
    bi.biPlanes := 1;
    bi.biBitCount := biBits;
    bi.biCompression := BI_RGB;
    bi.biSizeImage := 0;
    bi.biXPelsPerMeter := 0;
    bi.biYPelsPerMeter := 0;
    bi.biClrUsed := 0;
    bi.biClrImportant := 0;
// calculate size of memory block required to store BITMAPINFO
    dwLen := bi.biSize + PaletteSize(@bi);
// get a DC
    DC := GetDC(0);
// select and realize our palette
    hPal := SelectPalette(DC, hPal, FALSE);
    RealizePalette(DC);
// alloc memory block to store our bitmap
    DIB := GlobalAlloc(GHND, dwLen);
// if we couldn't get memory block
    if DIB = 0 then
    begin
// clean up and return NULL
      SelectPalette(DC, hPal, TRUE);
      RealizePalette(DC);
      ReleaseDC(0, DC);
      exit;
    end;
// lock memory and get pointer to it
    lpbi := PBITMAPINFOHEADER(GlobalLock(DIB));
// use our bitmap info. to fill BITMAPINFOHEADER
    CopyMemory(lpbi, @bi, sizeof(bi));
// call GetDIBits with a NULL lpBits param, so it will calculate the
// biSizeImage field for us
    GetDIBits(DC, hBmp, 0, bi.biHeight, nil, PBITMAPINFO(lpbi)^, DIB_RGB_COLORS);
// get the info. returned by GetDIBits and unlock memory block
    CopyMemory(@bi, lpbi, sizeof(bi));
    GlobalUnlock(DIB);
// if the driver did not fill in the biSizeImage field, make one up
    if (bi.biSizeImage = 0) then
      bi.biSizeImage := WIDTHBYTES(bm.bmWidth * biBits) * bm.bmHeight;
// realloc the buffer big enough to hold all the bits
    dwLen := bi.biSize + PaletteSize(@bi) + bi.biSizeImage;
    h := GlobalReAlloc(DIB, dwLen, 0);
    if h <> 0 then
      DIB := h
    else
    begin
// clean up and return NULL
      GlobalFree(DIB);
      SelectPalette(DC, hPal, TRUE);
      RealizePalette(DC);
      ReleaseDC(0, DC);
      exit;
    end;
// lock memory block and get pointer to it */
    lpbi := PBITMAPINFOHEADER(GlobalLock(DIB));
// call GetDIBits with a NON-NULL lpBits param, and actualy get the
// bits this time
    if GetDIBits(DC, hBmp, 0, bi.biHeight, PChar(lpbi) + lpbi^.biSize + PaletteSize(PChar(lpbi)), PBITMAPINFO(lpbi)^, DIB_RGB_COLORS) = 0 then
    begin
// clean up and return NULL
      GlobalUnlock(DIB);
      SelectPalette(DC, hPal, TRUE);
      RealizePalette(DC);
      ReleaseDC(0, DC);
      exit;
    end;
    CopyMemory(@bi, lpbi, sizeof(bi));
// clean up
    GlobalUnlock(DIB);
    SelectPalette(DC, hPal, TRUE);
    RealizePalette(DC);
    ReleaseDC(0, DC);
// return handle to the DIB
    result := DIB;
  end;
end;

(*************************************************************************
 *
 * PalEntriesOnDevice()
 *
 * Parameter:
 *
 * HDC hDC          - device context
 *
 * Return Value:
 *
 * int              - number of palette entries on device
 *
 * Description:
 *
 * This function gets the number of palette entries on the specified device
 *
 ************************************************************************)

function PalEntriesOnDevice(DC: HDC): Integer;
begin
// Find out the number of colors on this device.
  result := (1 shl (GetDeviceCaps(DC, BITSPIXEL) * GetDeviceCaps(DC, PLANES)));
end;

(*************************************************************************
 *
 * GetSystemPalette()
 *
 * Parameters:
 *
 * None
 *
 * Return Value:
 *
 * HPALETTE         - handle to a copy of the current system palette
 *
 * Description:
 *
 * This function returns a handle to a palette which represents the system
 * palette.  The system RGB values are copied into our logical palette using
 * the GetSystemPaletteEntries function.
 *
 ************************************************************************)

function GetSystemPalette: HPALETTE;
var
  DC: HDC; // handle to a DC
  hPal: HPALETTE; // handle to a palette
  hLogPal: THandle; // handle to a logical palette
  lpLogPal: PLOGPALETTE; // pointer to a logical palette
  nColors: Integer; // number of colors
begin
// Find out how many palette entries we want.
  DC := GetDC(0);
  result := 0;
  if DC <> 0 then
  begin
    nColors := PalEntriesOnDevice(DC); // Number of palette entries
// Allocate room for the palette and lock it.
    hLogPal := GlobalAlloc(GHND, sizeof(LOGPALETTE) + nColors *
      sizeof(PALETTEENTRY));
// if we didn't get a logical palette, return NULL
    if hLogPal = 0 then
      exit;
// get a pointer to the logical palette
    lpLogPal := PLOGPALETTE(GlobalLock(hLogPal));
// set some important fields
    lpLogPal^.palVersion := PALVERSION;
    lpLogPal^.palNumEntries := nColors;
// Copy the current system palette into our logical palette
    GetSystemPaletteEntries(DC, 0, nColors, PPALETTEENTRY(lpLogPal^.palPalEntry));
// Go ahead and create the palette.  Once it's created,
// we no longer need the LOGPALETTE, so free it.
    hPal := CreatePalette(lpLogPal^);
// clean up
    GlobalUnlock(hLogPal);
    GlobalFree(hLogPal);
    ReleaseDC(0, DC);
    result := hPal;
  end;
end;

(*************************************************************************
 *
 * AllocRoomForDIB()
 *
 * Parameters:
 *
 * BITMAPINFOHEADER - bitmap info header stucture
 *
 * HBITMAP          - handle to the bitmap
 *
 * Return Value:
 *
 * HDIB             - handle to memory block
 *
 * Description:
 *
 *  This routine takes a BITMAPINOHEADER, and returns a handle to global
 *  memory which can contain a DIB with that header.  It also initializes
 *  the header portion of the global memory.  GetDIBits() is used to determine
 *  the amount of room for the DIB's bits.  The total amount of memory
 *  needed = sizeof(BITMAPINFOHEADER) + size of color table + size of bits.
 *
 ************************************************************************)

function AllocRoomForDIB(bi: BITMAPINFOHEADER; hBmp: HBITMAP): THandle;
var
  dwLen: DWORD;
  DIB: THandle;
  DC: HDC;
  lpbi: PBITMAPINFOHEADER;
  hTemp: THandle;
begin
// Figure out the size needed to hold the BITMAPINFO structure
// (which includes the BITMAPINFOHEADER and the color table).
  dwLen := bi.biSize + PaletteSize(PChar(@bi));
  DIB := GlobalAlloc(GHND, dwLen);
  result := 0;
// Check that DIB handle is valid
  if DIB <> 0 then
  begin
// Set up the BITMAPINFOHEADER in the newly allocated global memory,
// then call GetDIBits() with lpBits = NULL to have it fill in the
// biSizeImage field for us.
    lpbi := PBITMAPINFOHEADER(GlobalLock(DIB));
    CopyMemory(lpbi, @bi, sizeof(bi));
    DC := GetDC(0);
    GetDIBits(DC, hBmp, 0, bi.biHeight, nil, PBITMAPINFO(lpbi)^, DIB_RGB_COLORS);
    ReleaseDC(0, DC);
// If the driver did not fill in the biSizeImage field,
// fill it in -- NOTE: this is a bug in the driver!
    if lpbi^.biSizeImage = 0 then
      lpbi^.biSizeImage := WIDTHBYTES(DWORD(lpbi^.biWidth) * lpbi^.biBitCount) * lpbi^.biHeight;
// Get the size of the memory block we need
    dwLen := lpbi^.biSize + PaletteSize(PChar(@bi)) + lpbi^.biSizeImage;
// Unlock the memory block
    GlobalUnlock(DIB);
// ReAlloc the buffer big enough to hold all the bits
    hTemp := GlobalReAlloc(DIB, dwLen, 0);
    if hTemp <> 0 then
      result := hTemp
    else
    begin
      GlobalFree(DIB);
      exit;
    end;
  end;
end;

(*************************************************************************
 *
 * ChangeDIBFormat()
 *
 * Parameter:
 *
 * HDIB             - handle to packed-DIB in memory
 *
 * WORD             - desired bits per pixel
 *
 * DWORD            - desired compression format
 *
 * Return Value:
 *
 * HDIB             - handle to the new DIB if successful, else NULL
 *
 * Description:
 *
 * This function will convert the bits per pixel and/or the compression
 * format of the specified DIB. Note: If the conversion was unsuccessful,
 * we return NULL. The original DIB is left alone. Don't use code like the
 * following:
 *
 *    hMyDIB = ChangeDIBFormat(hMyDIB, 8, BI_RLE4);
 *
 * The conversion will fail, but hMyDIB will now be NULL and the original
 * DIB will now hang around in memory. We could have returned the old
 * DIB, but we wanted to allow the programmer to check whether this
 * conversion succeeded or failed.
 *
 ************************************************************************)

function ChangeDIBFormat(DIB: THandle; wBitCount: DWORD; dwCompression: DWORD): THandle;
var
  DC: HDC; // Handle to DC
  hBmp: HBITMAP; // Handle to bitmap
  Bm: BITMAP; // BITMAP data structure
  bi: BITMAPINFOHEADER; // Bitmap info header
  lpbi: PBITMAPINFOHEADER; // Pointer to bitmap info
  hNewDIB: THandle; // Handle to new DIB
  hPal, hOldPal: HPALETTE; // Handle to palette, prev pal
  DIBBPP, NewBPP: WORD; // DIB bits per pixel, new bpp
  DIBComp, NewComp: DWORD; // DIB compression, new compression
begin
  result := 0;
// Check for a valid DIB handle
  if DIB <> 0 then
  begin
// Get the old DIB's bits per pixel and compression format
    lpbi := PBITMAPINFOHEADER(GlobalLock(DIB));
    DIBBPP := PBITMAPINFOHEADER(lpbi)^.biBitCount;
    DIBComp := PBITMAPINFOHEADER(lpbi)^.biCompression;
    GlobalUnlock(DIB);
// Validate wBitCount and dwCompression
// They must match correctly (i.e., BI_RLE4 and 4 BPP or
// BI_RLE8 and 8BPP, etc.) or we return failure
    if (wBitCount = 0) then
    begin
      NewBPP := DIBBPP;
      if (((dwCompression = BI_RLE4) and (NewBPP = 4)) or
        ((dwCompression = BI_RLE8) and (NewBPP = 8)) or
        ((dwCompression = BI_RGB))) then
        NewComp := dwCompression
      else
        NewComp := DIBComp;
    end
    else if ((wBitCount = 1) and (dwCompression = BI_RGB)) then
    begin
      NewBPP := wBitCount;
      NewComp := BI_RGB;
    end
    else if (wBitCount = 4) then
    begin
      NewBPP := wBitCount;
      if ((dwCompression = BI_RGB) or (dwCompression = BI_RLE4)) then
        NewComp := dwCompression
      else
        exit;
    end
    else if (wBitCount = 8) then
    begin
      NewBPP := wBitCount;
      if ((dwCompression = BI_RGB) or (dwCompression = BI_RLE8)) then
        NewComp := dwCompression
      else
        exit;
    end
    else if ((wBitCount = 24) and (dwCompression = BI_RGB)) then
    begin
      NewBPP := wBitCount;
      NewComp := BI_RGB;
    end
    else
      exit;
// Save the old DIB's palette
    hPal := CreateDIBPalette(DIB);
    if hPal = 0 then
      exit;
// Convert old DIB to a bitmap
    hBmp := DIBToBitmap(DIB, hPal);
    if hBmp = 0 then
    begin
      DeleteObject(hPal);
      exit;
    end;
// Get info about the bitmap
    GetObject(hBmp, sizeof(BITMAP), @Bm);
// Fill in the BITMAPINFOHEADER appropriately
    bi.biSize := sizeof(BITMAPINFOHEADER);
    bi.biWidth := Bm.bmWidth;
    bi.biHeight := Bm.bmHeight;
    bi.biPlanes := 1;
    bi.biBitCount := NewBPP;
    bi.biCompression := NewComp;
    bi.biSizeImage := 0;
    bi.biXPelsPerMeter := 0;
    bi.biYPelsPerMeter := 0;
    bi.biClrUsed := 0;
    bi.biClrImportant := 0;
// Go allocate room for the new DIB
    hNewDIB := AllocRoomForDIB(bi, hBmp);
    if hNewDIB = 0 then
      exit;
// Get a pointer to the new DIB
    lpbi := PBITMAPINFOHEADER(GlobalLock(hNewDIB));
// Get a DC and select/realize our palette in it
    DC := GetDC(0);
    hOldPal := SelectPalette(DC, hPal, FALSE);
    RealizePalette(DC);
// Call GetDIBits and get the new DIB bits
    if GetDIBits(DC, hBmp, 0, lpbi^.biHeight, PChar(lpbi) + lpbi^.biSize + PaletteSize(PChar(lpbi)), PBITMAPINFO(lpbi)^, DIB_RGB_COLORS) = 0 then
    begin
      GlobalUnlock(hNewDIB);
      GlobalFree(hNewDIB);
      hNewDIB := 0;
    end;
// Clean up and return
    SelectPalette(DC, hOldPal, TRUE);
    RealizePalette(DC);
    ReleaseDC(0, DC);
// Unlock the new DIB's memory block
    if hNewDIB <> 0 then
      GlobalUnlock(hNewDIB);
    DeleteObject(hBmp);
    DeleteObject(hPal);
    result := hNewDIB;
  end;
end;

(*************************************************************************
 *
 * ChangeBitmapFormat()
 *
 * Parameter:
 *
 * HBITMAP          - handle to a bitmap
 *
 * WORD             - desired bits per pixel
 *
 * DWORD            - desired compression format
 *
 * HPALETTE         - handle to palette
 *
 * Return Value:
 *
 * HDIB             - handle to the new DIB if successful, else NULL
 *
 * Description:
 *
 * This function will convert a bitmap to the specified bits per pixel
 * and compression format. The bitmap and it's palette will remain
 * after calling this function.
 *
 ************************************************************************)

function ChangeBitmapFormat(hBmp: HBITMAP; wBitCount: DWORD; dwCompression: DWORD; hPal: HPALETTE): THandle;
var
  DC: HDC; // Screen DC
  hNewDIB: THandle; // Handle to new DIB
  Bm: BITMAP; // BITMAP data structure
  bi: BITMAPINFOHEADER; // Bitmap info. header
  lpbi: PBITMAPINFOHEADER; // Pointer to bitmap header
  hOldPal: HPALETTE; // Handle to palette
  NewBPP: WORD; // New bits per pixel
  NewComp: DWORD; // New compression format
begin
  hOldPal := 0;
  result := 0;
// Check for a valid bitmap handle
  if hBmp <> 0 then
  begin
// Validate wBitCount and dwCompression
// They must match correctly (i.e., BI_RLE4 and 4 BPP or
// BI_RLE8 and 8BPP, etc.) or we return failure
    NewComp := BI_RGB;
    case wBitCount of
      0:
        begin
          NewComp := dwCompression;
          if (NewComp = BI_RLE4) then
            NewBPP := 4
          else if (NewComp = BI_RLE8) then
            NewBPP := 8
          else // Not enough info */
            exit;
        end;
      1:
        begin
          NewBPP := wBitCount;
          if (dwCompression = BI_RGB) then
            NewComp := BI_RGB;
        end;
      4:
        begin
          NewBPP := wBitCount;
          if ((dwCompression = BI_RGB) or (dwCompression = BI_RLE4)) then
            NewComp := dwCompression
          else
            exit;
        end;
      8:
        begin
          NewBPP := wBitCount;
          if ((dwCompression = BI_RGB) or (dwCompression = BI_RLE8)) then
            NewComp := dwCompression
          else
            exit;
        end;
      24, 32:
        begin
          NewBPP := wBitCount;
          if ((dwCompression = BI_RGB)) then
            NewComp := dwCompression
          else
            exit;
        end;
    else
      exit;
    end;
// Get info about the bitmap
    GetObject(hBmp, sizeof(BITMAP), @Bm);
// Fill in the BITMAPINFOHEADER appropriately
    bi.biSize := sizeof(BITMAPINFOHEADER);
    bi.biWidth := Bm.bmWidth;
    bi.biHeight := Bm.bmHeight;
    bi.biPlanes := 1;
    bi.biBitCount := NewBPP;
    bi.biCompression := NewComp;
    bi.biSizeImage := 0;
    bi.biXPelsPerMeter := 0;
    bi.biYPelsPerMeter := 0;
    bi.biClrUsed := 0;
    bi.biClrImportant := 0;
// Go allocate room for the new DIB
    hNewDIB := AllocRoomForDIB(bi, hBmp);
    if hNewDIB = 0 then
      exit;
// Get a pointer to the new DIB
    lpbi := PBITMAPINFOHEADER(GlobalLock(hNewDIB));
    DC := GetDC(0);
    // If we have a palette, select/realize it
    if hPal <> 0 then
    begin
      hOldPal := SelectPalette(DC, hPal, FALSE);
      RealizePalette(DC);
    end;
// Call GetDIBits and get the new DIB bits
    if GetDIBits(DC, hBmp, 0, lpbi^.biHeight, PChar(lpbi) + lpbi^.biSize + PaletteSize(PChar(lpbi)), PBITMAPINFO(lpbi)^, DIB_RGB_COLORS) = 0 then
    begin
      GlobalUnlock(hNewDIB);
      GlobalFree(hNewDIB);
      hNewDIB := 0;
    end;
// Clean up and return
    if hOldPal <> 0 then
    begin
      SelectPalette(DC, hOldPal, TRUE);
      RealizePalette(DC);
      ReleaseDC(0, DC);
    end;
// Unlock the new DIB's memory block
    if hNewDIB <> 0 then
      GlobalUnlock(hNewDIB);
    result := hNewDIB;
  end;
end;

(*************************************************************************
 *
 * CopyWindowToDIB()
 *
 * Parameters:
 *
 * HWND hWnd        - specifies the window
 *
 * WORD fPrintArea  - specifies the window area to copy into the device-
 *                    independent bitmap
 *
 * Return Value:
 *
 * HDIB             - identifies the device-independent bitmap
 *
 * Description:
 *
 * This function copies the specified part(s) of the window to a device-
 * independent bitmap.
 *
 ************************************************************************)

function CopyWindowToDIB(Wnd: HWND; fPrintArea: DWORD): THandle;
var
  DIB: THandle; // handle to DIB
  rectWnd: TRect;
  rectClient: TRect;
  pt1, pt2: TPoint;
begin
  result := 0;
// check for a valid window handle
  if Wnd <> 0 then
  begin
    case fPrintArea of
      PW_WINDOW: // copy entire window
        begin
// get the window rectangle
          GetWindowRect(Wnd, rectWnd);
// get the DIB of the window by calling
// CopyScreenToDIB and passing it the window rect
          DIB := CopyScreenToDIB(rectWnd);
        end;
      PW_CLIENT: // copy client area
        begin
// get the client area dimensions
          GetClientRect(Wnd, rectClient);
// convert client coords to screen coords
          pt1.x := rectClient.left;
          pt1.y := rectClient.top;
          pt2.x := rectClient.right;
          pt2.y := rectClient.bottom;
          ClientToScreen(Wnd, pt1);
          ClientToScreen(Wnd, pt2);
          rectClient.left := pt1.x;
          rectClient.top := pt1.y;
          rectClient.right := pt2.x;
          rectClient.bottom := pt2.y;
// get the DIB of the client area by calling
// CopyScreenToDIB and passing it the client rect
          DIB := CopyScreenToDIB(rectClient);
        end;
    else
      exit;
    end;
// return the handle to the DIB
    result := DIB;
  end;
end;

(*************************************************************************
 *
 * CopyScreenToDIB()
 *
 * Parameter:
 *
 * LPRECT lpRect    - specifies the window
 *
 * Return Value:
 *
 * HDIB             - identifies the device-independent bitmap
 *
 * Description:
 *
 * This function copies the specified part of the screen to a device-
 * independent bitmap.
 *
 ************************************************************************)

function CopyScreenToDIB(const Rect: TRect): THandle;
var
  hBmp: HBITMAP; // handle to device-dependent bitmap
  hPal: HPALETTE; // handle to palette
  DIB: THandle; // handle to DIB
begin
  result := 0;
// get the device-dependent bitmap in lpRect by calling
//  CopyScreenToBitmap and passing it the rectangle to grab
  hBmp := CopyScreenToBitmap(Rect);
// check for a valid bitmap handle
  if hBmp <> 0 then
  begin
// get the current palette
    hPal := GetSystemPalette;
// convert the bitmap to a DIB
    DIB := BitmapToDIB(hBmp, hPal);
// clean up
    DeleteObject(hPal);
    DeleteObject(hBmp);
// return handle to the packed-DIB
    result := DIB;
  end;
end;

(*************************************************************************
 *
 * CopyWindowToBitmap()
 *
 * Parameters:
 *
 * HWND hWnd        - specifies the window
 *
 * WORD fPrintArea  - specifies the window area to copy into the device-
 *                    dependent bitmap
 *
 * Return Value:
 *
 * HDIB         - identifies the device-dependent bitmap
 *
 * Description:
 *
 * This function copies the specified part(s) of the window to a device-
 * dependent bitmap.
 *
 *
 ************************************************************************)

function CopyWindowToBitmap(Wnd: HWND; fPrintArea: DWORD): HBITMAP;
var
  hBmp: HBITMAP; // handle to device-dependent bitmap
  rectWnd: TRect;
  rectClient: TRect;
  pt1, pt2: TPoint;
begin
  result := 0;
// check for a valid window handle
  if IsWindow(Wnd) then
  begin
    case fPrintArea of
      PW_WINDOW: // copy entire window
        begin
// get the window rectangle
          GetWindowRect(Wnd, rectWnd);
// get the bitmap of that window by calling
// CopyScreenToBitmap and passing it the window rect
          hBmp := CopyScreenToBitmap(rectWnd);
        end;
      PW_CLIENT: // copy client area
        begin
// get client dimensions
          GetClientRect(Wnd, rectClient);
// convert client coords to screen coords
          pt1.x := rectClient.left;
          pt1.y := rectClient.top;
          pt2.x := rectClient.right;
          pt2.y := rectClient.bottom;
          ClientToScreen(Wnd, pt1);
          ClientToScreen(Wnd, pt2);
          rectClient.left := pt1.x;
          rectClient.top := pt1.y;
          rectClient.right := pt2.x;
          rectClient.bottom := pt2.y;
// get the bitmap of the client area by calling
// CopyScreenToBitmap and passing it the client rect
          hBmp := CopyScreenToBitmap(rectClient);
        end;
    else
      exit;
    end;
// return handle to the bitmap
    result := hBmp;
  end;
end;

(*************************************************************************
 *
 * CopyScreenToBitmap()
 *
 * Parameter:
 *
 * LPRECT lpRect    - specifies the window
 *
 * Return Value:
 *
 * HDIB             - identifies the device-dependent bitmap
 *
 * Description:
 *
 * This function copies the specified part of the screen to a device-
 * dependent bitmap.
 *
 *
 ************************************************************************)

function CopyScreenToBitmap(Rect: TRect): HBITMAP;
var
  hScrDC, hMemDC: HDC; // screen DC and memory DC
  hBmp, hOldBitmap: HBITMAP; // handles to deice-dependent bitmaps
  nX, nY, nX2, nY2: Integer; // coordinates of rectangle to grab
  nWidth, nHeight: Integer; // DIB width and height
  xScrn, yScrn: Integer; // screen resolution
begin
  result := 0;
// check for an empty rectangle
  if IsRectEmpty(Rect) then
    exit;
// create a DC for the screen and create
// a memory DC compatible to screen DC

  hScrDC := CreateDC('DISPLAY', nil, nil, nil);
  hMemDC := CreateCompatibleDC(hScrDC);
// get points of rectangle to grab
  nX := Rect.left;
  nY := Rect.top;
  nX2 := Rect.right;
  nY2 := Rect.bottom;
// get screen resolution
  xScrn := GetDeviceCaps(hScrDC, HORZRES);
  yScrn := GetDeviceCaps(hScrDC, VERTRES);
//make sure bitmap rectangle is visible
  if (nX < 0) then
    nX := 0;
  if (nY < 0) then
    nY := 0;
  if (nX2 > xScrn) then
    nX2 := xScrn;
  if (nY2 > yScrn) then
    nY2 := yScrn;
  nWidth := nX2 - nX;
  nHeight := nY2 - nY;
// create a bitmap compatible with the screen DC
  hBmp := CreateCompatibleBitmap(hScrDC, nWidth, nHeight);
// select new bitmap into memory DC
  hOldBitmap := SelectObject(hMemDC, hBmp);
// bitblt screen DC to memory DC
  BitBlt(hMemDC, 0, 0, nWidth, nHeight, hScrDC, nX, nY, SRCCOPY);
// select old bitmap back into memory DC and get handle to
// bitmap of the screen
  hBmp := SelectObject(hMemDC, hOldBitmap);
// clean up
  DeleteDC(hScrDC);
  DeleteDC(hMemDC);
// return handle to the bitmap
  result := hBmp;
end;

(*************************************************************************
 *
 * PaintDIB()
 *
 * Parameters:
 *
 * HDC hDC          - DC to do output to
 *
 * LPRECT lpDCRect  - rectangle on DC to do output to
 *
 * HDIB hDIB        - handle to global memory with a DIB spec
 *                    in it followed by the DIB bits
 *
 * LPRECT lpDIBRect - rectangle of DIB to output into lpDCRect
 *
 * Return Value:
 *
 * BOOL             - TRUE if DIB was drawn, FALSE otherwise
 *
 * Description:
 *   Painting routine for a DIB.  Calls StretchDIBits() or
 *   SetDIBitsToDevice() to paint the DIB.  The DIB is
 *   output to the specified DC, at the coordinates given
 *   in lpDCRect.  The area of the DIB to be output is
 *   given by lpDIBRect.
 *
 * NOTE: This function always selects the palette as background. Before
 * calling this function, be sure your palette is selected to desired
 * priority (foreground or background).
 *
 *
 ************************************************************************)

function PaintDIB(DC: HDC; DCRect: TRect; DIB: THandle; DIBRect: TRect; hPal: HPALETTE): BOOL;
var
  lpDIBHdr: PChar; // Pointer to BITMAPINFOHEADER
  lpDIBBits: PChar; // Pointer to DIB bits
  bSuccess: BOOL; // Success/fail flag
  hOldPal: HPALETTE; // Previous palette
begin
  bSuccess := FALSE;
  result := bSuccess;
  hOldPal := 0;
// Check for valid DIB handle
  if DIB <> 0 then
  begin
// Lock down the DIB, and get a pointer to the beginning of the bit buffer
    lpDIBHdr := GlobalLock(DIB);
    lpDIBBits := FindDIBBits(lpDIBHdr);
// Select and realize our palette as background
    if hPal <> 0 then
    begin
      hOldPal := SelectPalette(DC, hPal, TRUE);
      RealizePalette(DC);
    end;
// Make sure to use the stretching mode best for color pictures
    SetStretchBltMode(DC, COLORONCOLOR);
// Determine whether to call StretchDIBits() or SetDIBitsToDevice()
{$WARNINGS OFF}
    if ((RECTWIDTH(DCRect) = RECTWIDTH(DIBRect)) and
      (RECTHEIGHT(DCRect) = RECTHEIGHT(DIBRect))) then
      bSuccess := SetDIBitsToDevice(DC, DCRect.left, DCRect.top, RECTWIDTH(DCRect), RECTHEIGHT(DCRect), DIBRect.left,
        DIBHeight(lpDIBHdr) - DIBRect.top - RECTHEIGHT(DIBRect), 0, DIBHeight(lpDIBHdr), lpDIBBits,
        PBITMAPINFO(lpDIBHdr)^, DIB_RGB_COLORS) <> 0
    else
      bSuccess := StretchDIBits(DC, DCRect.left, DCRect.top, RECTWIDTH(DCRect), RECTHEIGHT(DCRect), DIBRect.left,
        DIBRect.top, RECTWIDTH(DIBRect), RECTHEIGHT(DIBRect), lpDIBBits, PBITMAPINFO(lpDIBHdr)^, DIB_RGB_COLORS, SRCCOPY) <> 0;
{$WARNINGS ON}
// Unlock the memory block
    GlobalUnlock(DIB);
// Reselect old palette
    if hOldPal <> 0 then
      SelectPalette(DC, hOldPal, FALSE);
// Return with success/fail flag
    result := bSuccess;
  end;
end;

(*************************************************************************
 *
 * PaintBitmap()
 *
 * Parameters:
 *
 * HDC hDC          - DC to do output to
 *
 * LPRECT lpDCRect  - rectangle on DC to do output to
 *
 * HBITMAP hDDB     - handle to device-dependent bitmap (DDB)
 *
 * LPRECT lpDDBRect - rectangle of DDB to output into lpDCRect
 *
 * HPALETTE hPalette - handle to the palette to use with hDDB
 *
 * Return Value:
 *
 * BOOL             - TRUE if bitmap was drawn, FLASE otherwise
 *
 * Description:
 *
 * Painting routine for a DDB.  Calls BitBlt() or
 * StretchBlt() to paint the DDB.  The DDB is
 * output to the specified DC, at the coordinates given
 * in lpDCRect.  The area of the DDB to be output is
 * given by lpDDBRect.  The specified palette is used.
 *
 * NOTE: This function always selects the palette as background. Before
 * calling this function, be sure your palette is selected to desired
 * priority (foreground or background).
 *
 ************************************************************************)

function PaintBitmap(DC: HDC; DCRect: TRect; hDDB: HBITMAP; DDBRect: TRect; hPal: HPALETTE): BOOL;
var
  hMemDC: HDC; // Handle to memory DC
  hOldBitmap: HBITMAP; // Handle to previous bitmap
  hOldPal1: HPALETTE; // Handle to previous palette
  hOldPal2: HPALETTE; // Handle to previous palette
  bSuccess: BOOL; // Success/fail flag
begin
  hOldPal1 := 0;
  hOldPal2 := 0;
  Result := false;
// Create a memory DC
  hMemDC := CreateCompatibleDC(DC);
// If this failed, return FALSE
  if hMemDC <> 0 then
  begin
// If we have a palette, select and realize it
    if hPal <> 0 then
    begin
      hOldPal1 := SelectPalette(hMemDC, hPal, TRUE);
      hOldPal2 := SelectPalette(DC, hPal, TRUE);
      RealizePalette(DC);
    end;
// Select bitmap into the memory DC
    hOldBitmap := SelectObject(hMemDC, hDDB);
// Make sure to use the stretching mode best for color pictures
    SetStretchBltMode(DC, COLORONCOLOR);
// Determine whether to call StretchBlt() or BitBlt()
    if ((RECTWIDTH(DCRect) = RECTWIDTH(DDBRect)) and
      (RECTHEIGHT(DCRect) = RECTHEIGHT(DDBRect))) then
      bSuccess := BitBlt(DC, DCRect.left, DCRect.top, DCRect.right - DCRect.left,
        DCRect.bottom - DCRect.top, hMemDC, DDBRect.left,
        DDBRect.top, SRCCOPY)
    else
      bSuccess := StretchBlt(DC, DCRect.left, DCRect.top, DCRect.right - DCRect.left,
        DCRect.bottom - DCRect.top, hMemDC, DDBRect.left, DDBRect.top, DDBRect.right - DDBRect.left,
        DDBRect.bottom - DDBRect.top, SRCCOPY);
// Clean up
    SelectObject(hMemDC, hOldBitmap);

    if hOldPal1 <> 0 then
      SelectPalette(hMemDC, hOldPal1, FALSE);
    if hOldPal2 <> 0 then
      SelectPalette(DC, hOldPal2, FALSE);
    DeleteDC(hMemDC);
// Return with success/fail flag
    result := bSuccess;
  end;
end;

(*************************************************************************
 *
 * LoadDIB()
 *
 * Loads the specified DIB from a file, allocates memory for it,
 * and reads the disk file into the memory.
 *
 *
 * Parameters:
 *
 * PChar lpFileName - specifies the file to load a DIB from
 *
 * Returns: A handle to a DIB, or NULL if unsuccessful.
 *
 * NOTE: The DIB API were not written to handle OS/2 DIBs; This
 * function will reject any file that is not a Windows DIB.
 *
 *************************************************************************)

function LoadDIB(lpFileName: PChar): THandle;
var
  DIB: THandle;
  hFile: THandle;
begin
  result := 0;
  if not Assigned(lpFileName) then
    exit;
// Set the cursor to a hourglass, in case the loading operation
// takes more than a sec, the user will know what's going on.
//...  SetCursor(LoadCursor(0, IDC_WAIT));
// Create File with security related attributes
  hFile := CreateFile(lpFileName, GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN or SECURITY_ANONYMOUS or SECURITY_SQOS_PRESENT, (* security level checks *)
    0);
  if hFile = INVALID_HANDLE_VALUE then
    exit;
  if GetFileType(hFile) <> FILE_TYPE_DISK then
  begin
    CloseHandle(hFile);
//...    SetCursor(LoadCursor(0, IDC_ARROW));
    exit;
  end
  else
  begin
    DIB := ReadDIBFile(hFile);
    CloseHandle(hFile);
//...    SetCursor(LoadCursor(0, IDC_ARROW));
    result := DIB;
  end;
end;

(*************************************************************************
 *
 * SaveDIB()
 *
 * Saves the specified DIB into the specified file name on disk.  No
 * error checking is done, so if the file already exists, it will be
 * written over.
 *
 * Parameters:
 *
 * HDIB hDib - Handle to the dib to save
 *
 * PChar lpFileName - pointer to full pathname to save DIB under
 *
 * Return value: 0 if successful, or one of:
 *        ERR_INVALIDHANDLE
 *        ERR_OPEN
 *        ERR_LOCK
 *
 *************************************************************************)

function SaveDIB(hDib: THandle; lpFileName: PChar): DWORD;
var
  bmfHdr: BITMAPFILEHEADER; // Header for Bitmap file
  lpBI: PBITMAPINFOHEADER; // Pointer to DIB info structure
  fh: THandle; // file handle for opened file
  dwDIBSize: DWORD;
  dwWritten: DWORD;
  dwBmBitsSize: DWORD; // Size of Bitmap Bits only
begin
  result := ERROR_INVALID_HANDLE;
  if hDib = 0 then
    exit;
  if not Assigned(lpFileName) then
  begin
    result := ERROR_FILE_NOT_FOUND;
    exit;
  end;
  fh := CreateFile(lpFileName, GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_FLAG_SEQUENTIAL_SCAN or SECURITY_ANONYMOUS or SECURITY_SQOS_PRESENT, 0);
  if fh = INVALID_HANDLE_VALUE then
  begin
    result := ERROR_TOO_MANY_OPEN_FILES;
    exit;
  end;
  if (GetFileType(fh) <> FILE_TYPE_DISK) then
  begin
    CloseHandle(fh);
    result := ERROR_TOO_MANY_OPEN_FILES;
    exit;
  end;
// Get a pointer to the DIB memory, the first of which contains
// a BITMAPINFO structure
  lpBI := PBITMAPINFOHEADER(GlobalLock(hDib));
  if not Assigned(lpBI) then
  begin
    CloseHandle(fh);
    result := ERROR_DISCARDED;
    exit
  end;
// Check to see if we're dealing with an OS/2 DIB.  If so, don't
// save it because our functions aren't written to deal with these
// DIBs.
  if (lpBI^.biSize <> sizeof(BITMAPINFOHEADER)) then
  begin
    GlobalUnlock(hDib);
    CloseHandle(fh);
    result := ERROR_INVALID_DATA;
    exit
  end;
// Fill in the fields of the file header
// Fill in file type (first 2 bytes must be "BM" for a bitmap)
  bmfHdr.bfType := DIB_HEADER_MARKER; // "BM"
// Calculating the size of the DIB is a bit tricky (if we want to
// do it right).  The easiest way to do this is to call GlobalSize()
// on our global handle, but since the size of our global memory may have
// been padded a few bytes, we may end up writing out a few too
// many bytes to the file (which may cause problems with some apps,
// like HC 3.0).
//
// So, instead let's calculate the size manually.
//
// To do this, find size of header plus size of color table.  Since the
// first DWORD in both BITMAPINFOHEADER and BITMAPCOREHEADER conains
// the size of the structure, let's use this.
// Partial Calculation
  dwDIBSize := PDWORD(lpBI)^ + PaletteSize(PChar(lpBI));
// Now calculate the size of the image
// It's an RLE bitmap, we can't calculate size, so trust the biSizeImage
// field
  if ((lpBI^.biCompression = BI_RLE8) or (lpBI^.biCompression = BI_RLE4)) then
    dwDIBSize := dwDIBSize + lpBI^.biSizeImage
  else
  begin
// It's not RLE, so size is Width (DWORD aligned) * Height
{$WARNINGS OFF}
    dwBmBitsSize := WIDTHBYTES((lpBI^.biWidth) * (DWORD(lpBI^.biBitCount))) * lpBI^.biHeight;
    dwDIBSize := dwDIBSize + dwBmBitsSize;
{$WARNINGS ON}
// Now, since we have calculated the correct size, why don't we
// fill in the biSizeImage field (this will fix any .BMP files which
// have this field incorrect).
    lpBI^.biSizeImage := dwBmBitsSize;
  end;
// Calculate the file size by adding the DIB size to sizeof(BITMAPFILEHEADER)
  bmfHdr.bfSize := dwDIBSize + sizeof(BITMAPFILEHEADER);
  bmfHdr.bfReserved1 := 0;
  bmfHdr.bfReserved2 := 0;
// Now, calculate the offset the actual bitmap bits will be in
// the file -- It's the Bitmap file header plus the DIB header,
// plus the size of the color table.
  bmfHdr.bfOffBits := sizeof(BITMAPFILEHEADER) + lpBI^.biSize + PaletteSize(PChar(lpBI));
// Write the file header
  WriteFile(fh, PChar(@bmfHdr)^, sizeof(BITMAPFILEHEADER), dwWritten, nil);
// Write the DIB header and the bits -- use local version of
// MyWrite, so we can write more than 32767 bytes of data
  WriteFile(fh, PChar(lpBI)^, dwDIBSize, dwWritten, nil);
  GlobalUnlock(hDib);
  CloseHandle(fh);
  if (dwWritten = 0) then
// oops, something happened in the write
    result := ERROR_TOO_MANY_OPEN_FILES
  else
// Success code
    result := ERROR_SUCCESS;
end;

(*************************************************************************
 *
 * DestroyDIB ()
 *
 * Purpose:  Frees memory associated with a DIB
 *
 * Returns:  Nothing
 *
 *************************************************************************)

function DestroyDIB(hDib: THandle): DWORD;
begin
  GlobalFree(hDib);
  result := 0;
end;

(*************************************************************************
 *
 * Function:  ReadDIBFile (int)
 *
 *  Purpose:  Reads in the specified DIB file into a global chunk of
 *            memory.
 *
 *  Returns:  A handle to a dib (hDIB) if successful.
 *            NULL if an error occurs.
 *
 * Comments:  BITMAPFILEHEADER is stripped off of the DIB.  Everything
 *            from the end of the BITMAPFILEHEADER structure on is
 *            returned in the global memory handle.
 *
 *
 * NOTE: The DIB API were not written to handle OS/2 DIBs, so this
 * function will reject any file that is not a Windows DIB.
 *
 *************************************************************************)
{$HINTS OFF}

function ReadDIBFile(hFile: THandle): THandle;
var
  bmfHeader: BITMAPFILEHEADER;
  dwBitsSize: DWORD;
  nNumColors: UINT; // Number of colors in table
  hDIB: THandle;
  hDIBtmp: THandle; // Used for GlobalRealloc() //MPB
  lpbi: PBITMAPINFOHEADER;
  offBits: DWORD;
  dwRead: DWORD;
label ErrExit, ErrExitNoUnlock, OKExit;
begin
  result := 0;
  if hFile = 0 then
    exit;
// get length of DIB in bytes for use when reading
  dwBitsSize := GetFileSize(hFile, nil);
// Allocate memory for header & color table. We'll enlarge this
// memory as needed.
  hDIB := GlobalAlloc(GMEM_MOVEABLE, sizeof(BITMAPINFOHEADER) + 256 * sizeof(RGBQUAD));
  if hDIB <> 0 then
    exit;
  lpbi := PBITMAPINFOHEADER(GlobalLock(hDIB));
  if not Assigned(lpbi) then
  begin
    GlobalFree(hDIB);
    exit;
  end;
// read the BITMAPFILEHEADER from our file
  if not ReadFile(hFile, PChar(@bmfHeader)^, sizeof(BITMAPFILEHEADER), dwRead, nil) then
    goto ErrExit;
  if sizeof(BITMAPFILEHEADER) <> dwRead then
    goto ErrExit;
  if bmfHeader.bfType <> DIB_HEADER_MARKER then // 'BM'
    goto ErrExit;
// read the BITMAPINFOHEADER
  if ReadFile(hFile, PChar(lpbi)^, sizeof(BITMAPINFOHEADER), dwRead, nil) then
    goto ErrExit;
  if sizeof(BITMAPINFOHEADER) <> dwRead then
    goto ErrExit;
// Check to see that it's a Windows DIB -- an OS/2 DIB would cause
// strange problems with the rest of the DIB API since the fields
// in the header are different and the color table entries are
// smaller.
//
// If it's not a Windows DIB (e.g. if biSize is wrong), return NULL.
  if lpbi^.biSize = sizeof(BITMAPCOREHEADER) then
    goto ErrExit;
// Now determine the size of the color table and read it.  Since the
// bitmap bits are offset in the file by bfOffBits, we need to do some
// special processing here to make sure the bits directly follow
// the color table (because that's the format we are susposed to pass
// back)
  nNumColors := lpbi^.biClrUsed;
  if nNumColors <> 0 then
// no color table for 24-bit, default size otherwise
    if lpbi^.biBitCount <> 24 then
// standard size table
      nNumColors := 1 shl (lpbi^.biBitCount);
// fill in some default values if they are zero
  if lpbi^.biClrUsed = 0 then
    lpbi^.biClrUsed := nNumColors;
  if lpbi^.biSizeImage = 0 then
  begin
    lpbi^.biSizeImage := ((((lpbi^.biWidth * lpbi^.biBitCount) + 31) and (not 31)) shr 3) * lpbi^.biHeight;
  end;
// get a proper-sized buffer for header, color table and bits
  GlobalUnlock(hDIB);
  hDIBtmp := GlobalReAlloc(hDIB, lpbi^.biSize + nNumColors * sizeof(RGBQUAD) + lpbi^.biSizeImage, 0);
  if hDIBtmp <> 0 then // can't resize buffer for loading
    goto ErrExitNoUnlock //MPB
  else
    hDIB := hDIBtmp;
  lpbi := PBITMAPINFOHEADER(GlobalLock(hDIB));
// read the color table
  ReadFile(hFile, PChar(PChar(lpbi) + lpbi^.biSize)^, nNumColors * sizeof(RGBQUAD), dwRead, nil);
// offset to the bits from start of DIB header
  offBits := lpbi^.biSize + nNumColors * sizeof(RGBQUAD);
// If the bfOffBits field is non-zero, then the bits might *not* be
// directly following the color table in the file.  Use the value in
// bfOffBits to seek the bits.
  if bmfHeader.bfOffBits <> 0 then
    SetFilePointer(hFile, bmfHeader.bfOffBits, nil, FILE_BEGIN);
  if ReadFile(hFile, PChar(PChar(lpbi) + offBits)^, lpbi^.biSizeImage, dwRead, nil) then
    goto OKExit;
  ErrExit:
  GlobalUnlock(hDIB);
  ErrExitNoUnlock:
  GlobalFree(hDIB);
  result := 0;
  exit;
  OKExit:
  GlobalUnlock(hDIB);
  result := hDIB;
end;

{$HINTS ON}

(*
  ScreenShotThisInit()

  Will do the initial work for the screenshot (including format of the DIB and
  compression option ...)
*)

function ScreenShotThisInit(hwnd: HWND; noCompress: Boolean): THandle;
var
  DC: HDC;
  rScreen: TRect;
  hBmp: HBITMAP;
  hPal: HPALETTE;
  iBits: Integer;
  dwCompress: DWORD;
begin
  DC := CreateDC(PChar(Display), nil, nil, nil);
  ZeroMemory(@rScreen, sizeof(rScreen));
  rScreen.right := GetDeviceCaps(DC, HORZRES);
  rScreen.bottom := GetDeviceCaps(DC, VERTRES);
  iBits := GetDeviceCaps(DC, BITSPIXEL) * GetDeviceCaps(DC, PLANES);
  DeleteDC(DC);
  hBmp := CopyWindowToBitmap(hwnd, PW_WINDOW);
  if hBmp <> 0 then
    hPal := GetSystemPalette
  else
    hPal := 0;

  if (iBits <= 1) then
    iBits := 1
  else if (iBits <= 4) then
    iBits := 4
  else if (iBits <= 8) then
    iBits := 8
  else if (iBits <= 24) then
    iBits := 24
  else if (iBits <= 32) then
    iBits := 32;

  dwCompress := BI_RGB;
  if not noCompress then
    case iBits of
      4: dwCompress := BI_RLE4;
      8: dwCompress := BI_RLE8;
    end;

  result := ChangeBitmapFormat(hBmp, iBits, dwCompress, hPal);
  DeleteObject(hPal);
  DeleteObject(hBmp);
end;

(*
  ScreenShotThisFinit()

  Does the rest, i.e. saving a DIB to a file :)
*)

function ScreenShotThisFinit(DIB: THandle; fname: string): Boolean;
begin
  result := False;
  if DIB <> 0 then
  begin
    result := SaveDIB(DIB, @fname[1]) = ERROR_SUCCESS;
    DestroyDIB(DIB);
  end;
end;

(*
  ScreenShotThis()

  This is the essential function for Delphi. Using this one it is possible to
  create a screenshot of a window. To screenshot the whole Desktop Area use
  GetDesktopWindow() as parameter for hwnd!

  Note: it combines the two above functions!
*)

function ScreenShotThis(hwnd: HWND; fname: string; noCompress: Boolean): Boolean;
var
  DIB: THandle;
begin
  DIB := ScreenShotThisInit(hwnd, noCompress);
  result := ScreenShotThisFinit(DIB, fname);
end;

//------------------------------------------------------------------------------
// TSCreenshot class
//------------------------------------------------------------------------------

{$IFDEF PNGSAVESUPPORT}
{$INCLUDE PngSupport.pas}
{$ENDIF}

constructor TScreenshot.Create;
var
  pc: PChar;
  siz: DWORD;
begin
  inherited Create;
  FVerbose := False;
  FAutohideApp := True;
{$IFDEF PNGSAVESUPPORT}
  FPngSupported := InitPnglib(pnglib1);
  if not FPngSupported then
    FPngSupported := InitPnglib(pnglib2);
  if FPngSupported then
    FAutoSaveMask := png_defmask
  else
{$ENDIF}
    FAutoSaveMask := bmp_defmask;
  siz := GetCurrentDirectory(0, nil);
  pc := GetMemory(siz);
  if Assigned(pc) then
  try
    GetCurrentDirectory(siz, pc);
    SetString(FPathForFiles, pc, lstrlen(pc));
  finally
    FreeMemory(pc);
  end;
end;

constructor TScreenshot.Create(wnd: HWND);
var
  pc: PChar;
  siz: DWORD;
begin
  inherited Create;
  FAppWnd := wnd;
  FVerbose := False;
  FAutohideApp := True;
{$IFDEF PNGSAVESUPPORT}
  FPngSupported := InitPnglib(pnglib1);
  if not FPngSupported then
    FPngSupported := InitPnglib(pnglib2);
  if FPngSupported then
    FAutoSaveMask := png_defmask
  else
{$ENDIF}
    FAutoSaveMask := bmp_defmask;
  siz := GetCurrentDirectory(0, nil);
  pc := GetMemory(siz);
  if Assigned(pc) then
  try
    GetCurrentDirectory(siz, pc);
    SetString(FPathForFiles, pc, lstrlen(pc));
  finally
    FreeMemory(pc);
  end;
end;

destructor TScreenshot.Destroy;
begin
  self.Free;
{$IFDEF PNGSAVESUPPORT}
  if FPngSupported then
    DeInitPngLib;
{$ENDIF}
  inherited Destroy;
end;

function TScreenshot.PathForFiles(s: string):Boolean;
begin
  result:=SetCurrentDirectory(@s[1]);
end;

function TScreenshot.Window(hwnd: HWND): Boolean;
var
  hBmp: HBITMAP;
  hPal: HPALETTE;
  iBits: Integer;
  dwCompress: DWORD;
{$IFDEF PNGSAVESUPPORT}
  rect: TRect;
{$ENDIF}
begin
  result := False;
  self.Free;

  if IsWindow(hwnd) then
    if IsWindowVisible(hwnd) then
    begin
// Get the set some data needed
      FDC := CreateDC(PChar(Display), nil, nil, nil);
      ZeroMemory(@FScreenRect, sizeof(FScreenRect));
      FScreenRect.right := GetDeviceCaps(FDC, HORZRES);
      FScreenRect.bottom := GetDeviceCaps(FDC, VERTRES);
      iBits := GetDeviceCaps(FDC, BITSPIXEL) * GetDeviceCaps(FDC, PLANES);
      DeleteDC(FDC);
// Hide app if desired
      if FAutohideApp then
        HideApp(hwnd);
      Sleep(Wait);
// Actually copy the window ...
      hBmp := CopyWindowToBitmap(hwnd, PW_WINDOW);
// Restore app if desired
      if FAutohideApp then
        RestoreApp(hwnd);
// Proceed ...
{$IFDEF PNGSAVESUPPORT}
      if not FPngSupported then
        FBmpEnforced := True;
      case FBmpEnforced of
        True:
          begin
{$ENDIF}
            if hBmp <> 0 then
              hPal := GetSystemPalette
            else
              hPal := 0;
// Configure bit depth for the DIB we'll create
            if (iBits <= 1) then
              iBits := 1
            else if (iBits <= 4) then
              iBits := 4
            else if (iBits <= 8) then
              iBits := 8
            else if (iBits <= 24) then
              iBits := 24
            else if (iBits <= 32) then
              iBits := 32;

            dwCompress := BI_RGB; // No Compression
            if FCompress then
              case iBits of
                4: dwCompress := BI_RLE4;
                8: dwCompress := BI_RLE8;
              end;

// And put into DIB object
            FDIB := ChangeBitmapFormat(hBmp, iBits, dwCompress, hPal);
            DeleteObject(hPal);
            DeleteObject(hBmp);
{$IFDEF PNGSAVESUPPORT}
            FDIBisBMP := False;
          end;
      else
        begin
          FDIBisBMP := True;
          GetWindowRect(hwnd, rect);
          FExtension.x := rect.Right - rect.Left;
          FExtension.y := rect.Bottom - rect.Top;
          FDIB := hBmp;
        end;
      end;
{$ENDIF}
      result := FDIB <> 0;
    end;
end;

function TScreenshot.Desktop: Boolean;
begin
  result := self.Window(GetDesktopWindow);
end;

procedure TScreenshot.SetRLECompression(b: Boolean);
begin
  FCompress := b;
end;

procedure TScreenshot.SetAutohide(b: Boolean);
begin
  FAutohideApp := b;
end;

procedure TScreenshot.SetAppWnd(wnd: HWND);
begin
  FAppWnd := wnd;
end;

procedure TScreenshot.Free; // ... free all data (including the DIB)
begin
  if FDIB <> 0 then
  begin
{$IFDEF PNGSAVESUPPORT}
    if FPngSupported then
      if FDIBisBMP then
      begin
        FDIBisBMP := False;
        DeleteObject(FDIB);
        ZeroMemory(@FExtension, sizeof(FExtension));
        FDIBisBMP := False;
      end
      else
        DestroyDIB(FDIB)
    else
{$ENDIF}
      DestroyDIB(FDIB);
    FDIB := 0;
  end;
end;

function TScreenshot.Save(fname: string): Boolean;
begin
  result := False;
  if FDIB <> 0 then
{$IFDEF PNGSAVESUPPORT}
    if FPngSupported then
      case FDIBisBMP of
        True:
          result := SavehBmp2PngFile(fname, FDIB, FExtension.x, FExtension.y, NoAlpha);
      else
{$ENDIF}
        result := SaveDIB(FDIB, @fname[1]) = ERROR_SUCCESS;
{$IFDEF PNGSAVESUPPORT}
      end
    else
      result := SaveDIB(FDIB, @fname[1]) = ERROR_SUCCESS;
{$ENDIF}
end;

function TScreenshot.SaveAs: Boolean;
var
  ofn: TOpenFileName;
  ofn_buffer: array[0..MAX_PATH - 1] of char;
begin
  result := False;
  if FDIB <> 0 then
  begin
    ZeroMemory(@ofn, sizeof(ofn));
    ZeroMemory(@ofn_buffer[0], sizeof(ofn_buffer));
    ofn.lStructSize := sizeof(ofn);
    ofn.hWndOwner := appwnd;
    ofn.hInstance := hInstance;
    ofn.lpstrInitialDir := nil;
{$IFDEF PNGSAVESUPPORT}
    if FPngSupported then
      case FDIBisBmp of
        True:
          begin
            ofn.lpstrFilter := @png_filterstring[1];
            ofn.lpstrDefExt := png_ext;
          end;
      else
        begin
{$ENDIF}
          ofn.lpstrFilter := @bmp_filterstring[1];
          ofn.lpstrDefExt := bmp_ext;
{$IFDEF PNGSAVESUPPORT}
        end;
      end
    else
    begin
      ofn.lpstrFilter := @bmp_filterstring[1];
      ofn.lpstrDefExt := bmp_ext;
    end;
{$ENDIF}
    ofn.nMaxFile := sizeof(ofn_buffer);
    ofn.lpstrFile := ofn_buffer;
    ofn.Flags := OFN_PATHMUSTEXIST or OFN_LONGNAMES or OFN_EXPLORER or OFN_HIDEREADONLY;
    if not GetSaveFileName(ofn) then
    begin
      ZeroMemory(@ofn, sizeof(ofn));
      ZeroMemory(@ofn_buffer[0], sizeof(ofn_buffer));
    end
    else
      result := self.Save(ofn_buffer);
  end;
end;

function TScreenshot.SaveAndFree(fname: string): Boolean;
begin
  result := self.Save(fname);
  self.Free;
end;

function TScreenshot.SaveAsAndFree: Boolean;
begin
  result := self.SaveAs;
  self.Free;
end;

procedure TScreenshot.ResetInternalCounter;
begin
  FInternalCounter := 0;
end;

function TScreenshot.AutoSaveWindow(hwnd: HWND): Boolean;
begin
  inc(FInternalCounter);
  result := self.Window(hwnd);
  if result then
    result := self.SaveAndFree(Format(FAutosaveMask, [FInternalCounter]));
end;

function TScreenshot.AutoSaveDesktop: Boolean;
begin
  result := self.AutoSaveWindow(GetDesktopWindow);
end;

function TScreenshot.TimeSaveWindow(hwnd: HWND): Boolean;
var
  st: SYSTEMTIME;
begin
  result := self.Window(hwnd);
  GetLocalTime(st);
  if result then
    result := self.SaveAndFree(Format('%4.4d-%2.2d-%2.2d@%2.2d-%2.2d-%2.2d,%3.3d.png',
      [
      st.wYear,
        st.wMonth,
        st.wDay,
        st.wHour,
        st.wMinute,
        st.wSecond,
        st.wMilliseconds
        ]));
end;

function TScreenshot.TimeSaveDesktop: Boolean;
begin
  result := self.TimeSaveWindow(GetDesktopWindow);
end;

procedure TScreenshot.HideApp(hwnd: HWND);
begin
  if IsWindow(FAppWnd) then
  begin
// Hide window if it is not client of or application window itself
    SetForeGroundWindow(hwnd);
    if (hwnd <> FAppWnd) and (not IsChild(FAppWnd, hwnd)) then
      ShowWindow(FAppWnd, SW_HIDE);
// Process Message to apply the changes, e.g. hiding the application window
    ProcessMessages(FAppWnd);
  end;
end;

procedure TScreenshot.RestoreApp(hwnd: HWND);
begin
  if IsWindow(FAppWnd) then
  begin
    ShowWindow(FAppWnd, SW_SHOW);
    SetForeGroundWindow(FAppWnd);
    ProcessMessages(FAppWnd);
  end;
end;

procedure TScreenshot.SetVerbose(b: Boolean);
begin
  FVerbose := b;
end;

{$IFDEF PNGSAVESUPPORT}

procedure TScreenshot.SetBmpEnforced(b: Boolean);
begin
  if FPngSupported then
  begin
    FBmpEnforced := b;
    case FBmpEnforced of
      True:
        FAutoSaveMask := bmp_defmask;
    else
      FAutoSaveMask := png_defmask;
    end;
  end
  else
    FBmpEnforced := True;
end;
{$ENDIF}

//------------------------------------------------------------------------------
// Unit initialisation
//------------------------------------------------------------------------------
{$IFDEF AUTOLOAD}
initialization
  SShot := TScreenShot.Create;
finalization
  if Assigned(SShot) then
    SShot.Destroy;
{$ENDIF}
end.

