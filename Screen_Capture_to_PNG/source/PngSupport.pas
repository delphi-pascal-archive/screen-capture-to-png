(******************************************************************************
  Note, the following declarations have been taken from PngLib.pas. It
  contained the following copyright information:

  ------------------------------------------------------------------------------
  PngLib.Pas

  Conversion from C header file to Pascal Unit by Edmund H. Hand in
  April of 1998.
  For conditions of distribution and use, see the COPYRIGHT NOTICE from the
  orginal C Header file below.

  This unit is intended for use with LPng.DLL.  LPng.DLL was compiled with
  Microsoft Visual C++ 5.0 and is comprised of the standard PNG library
  version 1.0.1.  LPng.DLL uses ZLib 1.1.2 internally for compression and
  decompression.  The ZLib functions are also exported in the DLL, but they
  have not yet been defined here.

  The primary word of warning I must offer is that most of the function
  pointers for callback functions have merely been declared as the pascal
  Pointer type. I have only defined one procedure type for read and write
  callback functions.  So if you plan to use other callback types, check the
  included header file for the function definition.

  The header comments of the original C Header file follow.

 * png.h - header file for PNG reference library
 *
 * libpng 1.0.1
 * For conditions of distribution and use, see the COPYRIGHT NOTICE below.
 * Copyright (c) 1995, 1996 Guy Eric Schalnat, Group 42, Inc.
 * Copyright (c) 1996, 1997 Andreas Dilger
 * Copyright (c) 1998 Glenn Randers-Pehrson
 * March 15, 1998
 *
 * Note about libpng version numbers:
 *
 *    Due to various miscommunications, unforeseen code incompatibilities
 *    and occasional factors outside the authors' control, version numbering
 *    on the library has not always been consistent and straightforward.
 *    The following table summarizes matters since version 0.89c, which was
 *    the first widely used release:
 *
 *      source                    png.h   png.h   shared-lib
 *      version                   string    int   version
 *      -------                   ------  ------  ----------
 *      0.89c ("1.0 beta 3")      0.89        89  1.0.89
 *      0.90  ("1.0 beta 4")      0.90        90  0.90  [should have been 2.0.90]
 *      0.95  ("1.0 beta 5")      0.95        95  0.95  [should have been 2.0.95]
 *      0.96  ("1.0 beta 6")      0.96        96  0.96  [should have been 2.0.96]
 *      0.97b ("1.00.97 beta 7")  1.00.97     97  1.0.1 [should have been 2.0.97]
 *      0.97c                     0.97        97  2.0.97
 *      0.98                      0.98        98  2.0.98
 *      0.99                      0.99        98  2.0.99
 *      0.99a-m                   0.99        99  2.0.99
 *      1.00                      1.00       100  2.1.0 [int should be 10000]
 *      1.0.0                     1.0.0      100  2.1.0 [int should be 10000]
 *      1.0.1                     1.0.1    10001  2.1.0
 *
 *    Henceforth the source version will match the shared-library minor
 *    and patch numbers; the shared-library major version number will be
 *    used for changes in backward compatibility, as it is intended.
 *    The PNG_PNGLIB_VER macro, which is not used within libpng but
 *    is available for applications, is an unsigned integer of the form
 *    xyyzz corresponding to the source version x.y.z (leading zeros in y and z).
 *
 *
 * See libpng.txt for more information.  The PNG specification is available
 * as RFC 2083 <ftp://ftp.uu.net/graphics/png/documents/>
 * and as a W3C Recommendation <http://www.w3.org/TR/REC.png.html>
 *
 * Contributing Authors:
 *    John Bowler
 *    Kevin Bracey
 *    Sam Bushell
 *    Andreas Dilger
 *    Magnus Holmgren
 *    Tom Lane
 *    Dave Martindale
 *    Glenn Randers-Pehrson
 *    Greg Roelofs
 *    Guy Eric Schalnat
 *    Paul Schmidt
 *    Tom Tanner
 *    Willem van Schaik
 *    Tim Wegner
 *
 * The contributing authors would like to thank all those who helped
 * with testing, bug fixes, and patience.  This wouldn't have been
 * possible without all of you.
 *
 * Thanks to Frank J. T. Wojcik for helping with the documentation.
 *
 * COPYRIGHT NOTICE:
 *
 * The PNG Reference Library is supplied "AS IS".  The Contributing Authors
 * and Group 42, Inc. disclaim all warranties, expressed or implied,
 * including, without limitation, the warranties of merchantability and of
 * fitness for any purpose.  The Contributing Authors and Group 42, Inc.
 * assume no liability for direct, indirect, incidental, special, exemplary,
 * or consequential damages, which may result from the use of the PNG
 * Reference Library, even if advised of the possibility of such damage.
 *
 * Permission is hereby granted to use, copy, modify, and distribute this
 * source code, or portions hereof, for any purpose, without fee, subject
 * to the following restrictions:
 * 1. The origin of this source code must not be misrepresented.
 * 2. Altered versions must be plainly marked as such and must not be
 *    misrepresented as being the original source.
 * 3. This Copyright notice may not be removed or altered from any source or
 *    altered source distribution.
 *
 * The Contributing Authors and Group 42, Inc. specifically permit, without
 * fee, and encourage the use of this source code as a component to
 * supporting the PNG file format in commercial products.  If you use this
 * source code in a product, acknowledgment is not required but would be
 * appreciated.

  ------------------------------------------------------------------------------

  The sole rest is (c) 2003 by -=Assarbad=- [Assarbad AT gmx DOT info]

                 ___
                /   |                     ||              ||
               / _  |   ________ ___  ____||__    ___   __||
              / /_\ |  / __/ __//   |/  _/|   \  /   | /   |
             / ___  |__\\__\\  / /\ || |  | /\ \/ /\ |/ /\ | DOT NET
            /_/   \_/___/___/ /_____\|_|  |____/_____\\__/\|
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  [http://assarbad.net | http://assarbad.org]

  Last Change: 2003-05-03 [v1.21]

  REQUIRES AT LEAST LIBPNG v1.0.1

  v1.21 [2003-05-03]
  - Fixed a flaw that also could (under some cirumstances) create a color dis-
    tortion. Solved by filling the allocated buffers with zeroes.
  v1.2  [2003-04-24]
  - Now supporting newer LIBPNG.DLL v1.0.1, v.1.0.13 and v1.2.4 tested!
  - The handling of versioning in PNG is somewhat strange. I've to use a bogus
    version string for version 1.2.x because it won't work with the string from
    1.0.1 ... whereas 1.0.13 does! If somebody has information how to circumvent
    this, please drop me a mail.
  v1.1a [2003-04-22]
  - Fixed a small flaw. The code for moving image data without alpha channel was
    buggy because it actually moved 4 bytes instead of 3 needed. This was no
    problem except on the left border of the image, where the color had been
    distorted. This is fixed now.
  - Code for alpha and non-alpha image movement distinguished by CASE statement.
  v1.1  [2003-04-21]
  - First public release :)
  - Highly optimised by using inline assembler for the movement of the image
    data. Only 3 instructions difference between the code with alpha channel and
    the one without.
  v1.0  [I dont know ;) ...]
  - Not released!
  - "Slow" code because of "moving" single bytes.

  The license is BSDL (copyright owner = Assarbad)

 ******************************************************************************)

var
  hPngLib: HMODULE = 0;
  hMSVCRT: HMODULE = 0;

const
  NoAlpha = COLORREF(-1);

// Version information for png.h - this should match the version in png.c
  PNG_LIBPNG_VER_STRING_10 = '1.0.1';
  PNG_LIBPNG_VER_STRING_12 = '1.2.0';

// color types.  Note that not all combinations are legal
  PNG_COLOR_TYPE_GRAY = 0;
  PNG_COLOR_TYPE_PALETTE = 3;
  PNG_COLOR_TYPE_RGB = 2;
  PNG_COLOR_TYPE_RGB_ALPHA = 6;
  PNG_COLOR_TYPE_GRAY_ALPHA = 4;

// These are for the interlacing type.  These values should NOT be changed.
  PNG_INTERLACE_NONE: Integer = 0; // Non-interlaced image
  PNG_INTERLACE_ADAM7: Integer = 1; // Adam7 interlacing
  PNG_INTERLACE_LAST: Integer = 2; // Not a valid value

// This is for compression type. PNG 1.0 only defines the single type.
  PNG_COMPRESSION_TYPE_BASE: Integer = 0; // Deflate method 8, 32K window
  PNG_COMPRESSION_TYPE_DEFAULT: Integer = 0;

// This is for filter type. PNG 1.0 only defines the single type.
  PNG_FILTER_TYPE_BASE = 0; // Single row per-byte filtering
  PNG_FILTER_TYPE_DEFAULT = 0;

// Supported compression types for text in PNG files (tEXt, and zTXt).
// The values of the PNG_TEXT_COMPRESSION_ defines should NOT be changed.
  PNG_TEXT_COMPRESSION_NONE_WR = -3;
  PNG_TEXT_COMPRESSION_zTXt_WR = -2;
  PNG_TEXT_COMPRESSION_NONE = -1;
  PNG_TEXT_COMPRESSION_zTXt = 0;
  PNG_TEXT_COMPRESSION_LAST = 1; // Not a valid value

type
  PPChar = ^PChar;
  PPWord = ^PWord;
  PPByte = ^PByte;

(* Three color definitions.  The order of the red, green, and blue, (and the
 * exact size) is not important, although the size of the fields need to
 * be png_byte or png_uint_16 (as defined below).
 *)
  TPng_Color = record
    red: Byte;
    green: Byte;
    blue: Byte;
  end;
  PPng_Color = ^TPng_Color;
  PPPng_Color = ^PPng_Color;

  TPng_Color_16 = record
    index: Byte; // Used for palette files
    red: Word; // For use in reg, green, blue files
    green: Word;
    blue: Word;
    gray: Word; // For use in grayscale files
  end;
  PPng_Color_16 = ^TPng_Color_16;
  PPPng_Color_16 = ^PPng_Color_16;

  TPng_Color_8 = record
    red: Byte; // for use in red green blue files
    green: Byte;
    blue: Byte;
    gray: Byte; // for use in grayscale files
    alpha: Byte; // for alpha channel files
  end;
  PPng_Color_8 = ^TPng_Color_8;
  PPPng_Color_8 = ^PPng_Color_8;

(* png_text holds the text in a PNG file, and whether they are compressed
 * in the PNG file or not.  The "text" field points to a regular C string.
 *)
  TPng_Text = record
    compression: Integer; // compression value, see PNG_TEXT_COMPRESSION_
    key: PChar; // keyword, 1-79 character description of "text"
    text: PChar; // comment, may be an empty string (ie "")
    text_length: Integer; // length of "text" field
  end;
  PPng_Text = ^TPng_Text;
  PPPng_Text = ^PPng_Text;

  TPng_Text_Array = array[0..65535] of TPng_Text;
  PPng_Text_Array = ^TPng_Text_Array;

(* png_time is a way to hold the time in an machine independent way.
 * Two conversions are provided, both from time_t and struct tm.  There
 * is no portable way to convert to either of these structures, as far
 * as I know.  If you know of a portable way, send it to me.  As a side
 * note - PNG is Year 2000 compliant!
 *)
  TPng_Time = record
    year: Word; // full year, as in, 1995
    month: Byte; // month of year, 1 - 12
    day: Byte; // day of month, 1 - 31
    hour: Byte; // hour of day, 0 - 23
    minute: Byte; // minute of hour, 0 - 59
    second: Byte; // second of minute, 0 - 60 (for leap seconds)
  end;
  PPng_Time = ^TPng_Time;
  PPPng_Time = ^PPng_Time;

(* png_info is a structure that holds the information in a PNG file so
 * that the application can find out the characteristics of the image.
 * If you are reading the file, this structure will tell you what is
 * in the PNG file.  If you are writing the file, fill in the information
 * you want to put into the PNG file, then call png_write_info().
 * The names chosen should be very close to the PNG specification, so
 * consult that document for information about the meaning of each field.
 *
 * With libpng < 0.95, it was only possible to directly set and read the
 * the values in the png_info_struct, which meant that the contents and
 * order of the values had to remain fixed.  With libpng 0.95 and later,
 * however, * there are now functions which abstract the contents of
 * png_info_struct from the application, so this makes it easier to use
 * libpng with dynamic libraries, and even makes it possible to use
 * libraries that don't have all of the libpng ancillary chunk-handing
 * functionality.
 *
 * In any case, the order of the parameters in png_info_struct should NOT
 * be changed for as long as possible to keep compatibility with applications
 * that use the old direct-access method with png_info_struct.
 *)
  TPng_Info = record
   //the following are necessary for every PNG file
    width: Cardinal; // width of image in pixels (from IHDR)
    height: Cardinal; // height of image in pixels (from IHDR)
    valid: Cardinal; // valid chunk data (see PNG_INFO_ below)
    rowbytes: Cardinal; // bytes needed to hold an untransformed row
    palette: PPng_Color; // array of color values (valid & PNG_INFO_PLTE)
    num_palette: Word; // number of color entries in "palette" (PLTE)
    num_trans: Word; // number of transparent palette color (tRNS)
    bit_depth: Byte; // 1, 2, 4, 8, or 16 bits/channel (from IHDR)
    color_type: Byte; // see PNG_COLOR_TYPE_ below (from IHDR)
    compression_type: Byte; // must be PNG_COMPRESSION_TYPE_BASE (IHDR)
    filter_type: Byte; // must be PNG_FILTER_TYPE_BASE (from IHDR)
    interlace_type: Byte; // One of PNG_INTERLACE_NONE,PNG_INTERLACE_ADAM7

   // The following is informational only on read, and not used on writes.
    channels: Byte; // number of data channels per pixel (1, 3, 4)
    pixel_depth: Byte; // number of bits per pixel
    spare_byte: Byte; // to align the data, and for future use
    signature: array[0..7] of Byte; // magic bytes read by libpng from start of file

   (* The rest of the data is optional.  If you are reading, check the
    * valid field to see if the information in these are valid.  If you
    * are writing, set the valid field to those chunks you want written,
    * and initialize the appropriate fields below.
    *)

   (* The gAMA chunk describes the gamma characteristics of the system
    * on which the image was created, normally in the range [1.0, 2.5].
    * Data is valid if (valid & PNG_INFO_gAMA) is non-zero.
    *)
    gamma: Single; // gamma value of image, if (valid & PNG_INFO_gAMA)

    // GR-P, 0.96a
    // Data valid if (valid & PNG_INFO_sRGB) non-zero.
    srgb_intent: Byte; // sRGB rendering intent [0, 1, 2, or 3]

   (* The tEXt and zTXt chunks contain human-readable textual data in
    * uncompressed and compressed forms, respectively.  The data in "text"
    * is an array of pointers to uncompressed, null-terminated C strings.
    * Each chunk has a keyword which describes the textual data contained
    * in that chunk.  Keywords are not required to be unique, and the text
    * string may be empty.  Any number of text chunks may be in an image.
    *)
    num_text: Integer; // number of comments read/to write
    max_text: Integer; // current size of text array
    text: PPng_Text; // array of comments read/to write

   (* The tIME chunk holds the last time the displayed image data was
    * modified.  See the png_time struct for the contents of this struct.
    *)
    mod_time: TPng_Time;

   (* The sBIT chunk specifies the number of significant high-order bits
    * in the pixel data.  Values are in the range [1, bit_depth], and are
    * only specified for the channels in the pixel data.  The contents of
    * the low-order bits is not specified.  Data is valid if
    * (valid & PNG_INFO_sBIT) is non-zero.
    *)
    sig_bit: TPng_Color_8; // significant bits in color channels

   (* The tRNS chunk supplies transparency data for paletted images and
    * other image types that don't need a full alpha channel.  There are
    * "num_trans" transparency values for a paletted image, stored in the
    * same order as the palette colors, starting from index 0.  Values
    * for the data are in the range [0, 255], ranging from fully transparent
    * to fully opaque, respectively.  For non-paletted images, there is a
    * single color specified which should be treated as fully transparent.
    * Data is valid if (valid & PNG_INFO_tRNS) is non-zero.
    *)
    trans: PByte; // transparent values for paletted image
    trans_values: TPng_Color_16; // transparent color for non-palette image

   (* The bKGD chunk gives the suggested image background color if the
    * display program does not have its own background color and the image
    * is needs to composited onto a background before display.  The colors
    * in "background" are normally in the same color space/depth as the
    * pixel data.  Data is valid if (valid & PNG_INFO_bKGD) is non-zero.
    *)
    background: TPng_Color_16;

   (* The oFFs chunk gives the offset in "offset_unit_type" units rightwards
    * and downwards from the top-left corner of the display, page, or other
    * application-specific co-ordinate space.  See the PNG_OFFSET_ defines
    * below for the unit types.  Valid if (valid & PNG_INFO_oFFs) non-zero.
    *)
    x_offset: Cardinal; // x offset on page
    y_offset: Cardinal; // y offset on page
    offset_unit_type: Byte; // offset units type

   (* The pHYs chunk gives the physical pixel density of the image for
    * display or printing in "phys_unit_type" units (see PNG_RESOLUTION_
    * defines below).  Data is valid if (valid & PNG_INFO_pHYs) is non-zero.
    *)
    x_pixels_per_unit: Cardinal; // horizontal pixel density
    y_pixels_per_unit: Cardinal; // vertical pixel density
    phys_unit_type: Byte; // resolution type (see PNG_RESOLUTION_ below)

   (* The hIST chunk contains the relative frequency or importance of the
    * various palette entries, so that a viewer can intelligently select a
    * reduced-color palette, if required.  Data is an array of "num_palette"
    * values in the range [0,65535]. Data valid if (valid & PNG_INFO_hIST)
    * is non-zero.
    *)
    hist: PWord;

   (* The cHRM chunk describes the CIE color characteristics of the monitor
    * on which the PNG was created.  This data allows the viewer to do gamut
    * mapping of the input image to ensure that the viewer sees the same
    * colors in the image as the creator.  Values are in the range
    * [0.0, 0.8].  Data valid if (valid & PNG_INFO_cHRM) non-zero.
    *)
    x_white: Single;
    y_white: Single;
    x_red: Single;
    y_red: Single;
    x_green: Single;
    y_green: Single;
    x_blue: Single;
    y_blue: Single;

   (* The pCAL chunk describes a transformation between the stored pixel
    * values and original physcical data values used to create the image.
    * The integer range [0, 2^bit_depth - 1] maps to the floating-point
    * range given by [pcal_X0, pcal_X1], and are further transformed by a
    * (possibly non-linear) transformation function given by "pcal_type"
    * and "pcal_params" into "pcal_units".  Please see the PNG_EQUATION_
    * defines below, and the PNG-Group's Scientific Visualization extension
    * chunks document png-scivis-19970203 for a complete description of the
    * transformations and how they should be implemented, as well as the
    * png-extensions document for a description of the ASCII parameter
    * strings.  Data values are valid if (valid & PNG_INFO_pCAL) non-zero.
    *)
    pcal_purpose: PChar; // pCAL chunk description string
    pcal_X0: Integer; // minimum value
    pcal_X1: Integer; // maximum value
    pcal_units: PChar; // Latin-1 string giving physical units
    pcal_params: PPChar; // ASCII strings containing parameter values
    pcal_type: Byte; // equation type (see PNG_EQUATION_ below)
    pcal_nparams: Byte; // number of parameters given in pcal_params
  end;
  PPng_Info = ^TPng_Info;
  PPPng_Info = ^PPng_Info;

(* This is used for the transformation routines, as some of them
 * change these values for the row.  It also should enable using
 * the routines for other purposes.
 *)
  TPng_Row_Info = record
    width: Cardinal; // width of row
    rowbytes: Cardinal; // number of bytes in row
    color_type: Byte; // color type of row
    bit_depth: Byte; // bit depth of row
    channels: Byte; // number of channels (1, 2, 3, or 4)
    pixel_depth: Byte; // bits per pixel (depth * channels)
  end;
  PPng_Row_Info = ^TPng_Row_Info;
  PPPng_Row_Info = ^PPng_Row_Info;

(* The structure that holds the information to read and write PNG files.
 * The only people who need to care about what is inside of this are the
 * people who will be modifying the library for their own special needs.
 * It should NOT be accessed directly by an application, except to store
 * the jmp_buf.
 *)
  TPng_Struct = record
    jmpbuf: array[0..10] of Integer; // used in png_error
    error_fn: Pointer; // function for printing errors and aborting
    warning_fn: Pointer; // function for printing warnings
    error_ptr: Pointer; // user supplied struct for error functions
    write_data_fn: Pointer; // function for writing output data
    read_data_fn: Pointer; // function for reading input data
    read_user_transform_fn: Pointer; // user read transform
    write_user_transform_fn: Pointer; // user write transform
    io_ptr: Integer; // ptr to application struct for I/O functions

    mode: Cardinal; // tells us where we are in the PNG file
    flags: Cardinal; // flags indicating various things to libpng
    transformations: Cardinal; // which transformations to perform

    zstream: Pointer; // pointer to decompression structure (below)
    zbuf: PByte; // buffer for zlib
    zbuf_size: Integer; // size of zbuf
    zlib_level: Integer; // holds zlib compression level
    zlib_method: Integer; // holds zlib compression method
    zlib_window_bits: Integer; // holds zlib compression window bits
    zlib_mem_level: Integer; // holds zlib compression memory level
    zlib_strategy: Integer; // holds zlib compression strategy

    width: Cardinal; // width of image in pixels
    height: Cardinal; // height of image in pixels
    num_rows: Cardinal; // number of rows in current pass
    usr_width: Cardinal; // width of row at start of write
    rowbytes: Cardinal; // size of row in bytes
    irowbytes: Cardinal; // size of current interlaced row in bytes
    iwidth: Cardinal; // width of current interlaced row in pixels
    row_number: Cardinal; // current row in interlace pass
    prev_row: PByte; // buffer to save previous (unfiltered) row
    row_buf: PByte; // buffer to save current (unfiltered) row
    sub_row: PByte; // buffer to save "sub" row when filtering
    up_row: PByte; // buffer to save "up" row when filtering
    avg_row: PByte; // buffer to save "avg" row when filtering
    paeth_row: PByte; // buffer to save "Paeth" row when filtering
    row_info: TPng_Row_Info; // used for transformation routines

    idat_size: Cardinal; // current IDAT size for read
    crc: Cardinal; // current chunk CRC value
    palette: PPng_Color; // palette from the input file
    num_palette: Word; // number of color entries in palette
    num_trans: Word; // number of transparency values
    chunk_name: array[0..4] of Byte; // null-terminated name of current chunk
    compression: Byte; // file compression type (always 0)
    filter: Byte; // file filter type (always 0)
    interlaced: Byte; // PNG_INTERLACE_NONE, PNG_INTERLACE_ADAM7
    pass: Byte; // current interlace pass (0 - 6)
    do_filter: Byte; // row filter flags (see PNG_FILTER_ below )
    color_type: Byte; // color type of file
    bit_depth: Byte; // bit depth of file
    usr_bit_depth: Byte; // bit depth of users row
    pixel_depth: Byte; // number of bits per pixel
    channels: Byte; // number of channels in file
    usr_channels: Byte; // channels at start of write
    sig_bytes: Byte; // magic bytes read/written from start of file
    filler: Byte; // filler byte for 24->32-bit pixel expansion
    background_gamma_type: Byte;
    background_gamma: Single;
    background: TPng_Color_16; // background color in screen gamma space
    background_1: TPng_Color_16; // background normalized to gamma 1.0
    output_flush_fn: Pointer; // Function for flushing output
    flush_dist: Cardinal; // how many rows apart to flush, 0 - no flush
    flush_rows: Cardinal; // number of rows written since last flush
    gamma_shift: Integer; // number of "insignificant" bits 16-bit gamma
    gamma: Single; // file gamma value
    screen_gamma: Single; // screen gamma value (display_gamma/viewing_gamma
    gamma_table: PByte; // gamma table for 8 bit depth files
    gamma_from_1: PByte; // converts from 1.0 to screen
    gamma_to_1: PByte; // converts from file to 1.0
    gamma_16_table: PPWord; // gamma table for 16 bit depth files
    gamma_16_from_1: PPWord; // converts from 1.0 to screen
    gamma_16_to_1: PPWord; // converts from file to 1.0
    sig_bit: TPng_Color_8; // significant bits in each available channel
    shift: TPng_Color_8; // shift for significant bit tranformation
    trans: PByte; // transparency values for paletted files
    trans_values: TPng_Color_16; // transparency values for non-paletted files
    read_row_fn: Pointer; // called after each row is decoded
    write_row_fn: Pointer; // called after each row is encoded
    info_fn: Pointer; // called after header data fully read
    row_fn: Pointer; // called after each prog. row is decoded
    end_fn: Pointer; // called after image is complete
    save_buffer_ptr: PByte; // current location in save_buffer
    save_buffer: PByte; // buffer for previously read data
    current_buffer_ptr: PByte; // current location in current_buffer
    current_buffer: PByte; // buffer for recently used data
    push_length: Cardinal; // size of current input chunk
    skip_length: Cardinal; // bytes to skip in input data
    save_buffer_size: Integer; // amount of data now in save_buffer
    save_buffer_max: Integer; // total size of save_buffer
    buffer_size: Integer; // total amount of available input data
    current_buffer_size: Integer; // amount of data now in current_buffer
    process_mode: Integer; // what push library is currently doing
    cur_palette: Integer; // current push library palette index
    current_text_size: Integer; // current size of text input data
    current_text_left: Integer; // how much text left to read in input
    current_text: PByte; // current text chunk buffer
    current_text_ptr: PByte; // current location in current_text
    palette_lookup: PByte; // lookup table for dithering
    dither_index: PByte; // index translation for palette files
    hist: PWord; // histogram
    heuristic_method: Byte; // heuristic for row filter selection
    num_prev_filters: Byte; // number of weights for previous rows
    prev_filters: PByte; // filter type(s) of previous row(s)
    filter_weights: PWord; // weight(s) for previous line(s)
    inv_filter_weights: PWord; // 1/weight(s) for previous line(s)
    filter_costs: PWord; // relative filter calculation cost
    inv_filter_costs: PWord; // 1/relative filter calculation cost
    time_buffer: PByte; // String to hold RFC 1123 time text
  end;
  PPng_Struct = ^TPng_Struct;
  PPPng_Struct = ^PPng_Struct;

  Tpng_open_file = function(fname, mode: PChar): Pointer; cdecl;
  Tpng_close_file = function(filep: Pointer): Integer; cdecl;
  Tpng_create_write_struct = function(user_png_ver: PChar; error_ptr, error_fn, warn_fn: Pointer): PPng_Struct; cdecl;
  Tpng_create_info_struct = function(png_ptr: PPng_Struct): PPng_Info; cdecl;
  Tpng_write_info = procedure(png_ptr: PPng_Struct; info_ptr: PPng_Info); cdecl;
  Tpng_init_io = procedure(png_ptr: PPng_Struct; fp: Pointer); cdecl;
  Tpng_set_write_status_fn = procedure(png_ptr: PPng_Struct; write_row_fn: Pointer); cdecl;
  Tpng_set_IHDR = procedure(png_ptr: PPng_Struct; info_ptr: PPng_Info; width, height: Cardinal; bit_depth, color_type, interlace_type, compression_type, filter_type: Integer); cdecl;
  Tpng_set_text = procedure(png_ptr: PPng_Struct; info_ptr: PPng_Info; text_ptr: PPng_Text; num_text: Integer); cdecl;
  Tpng_set_swap = procedure(png_ptr: PPng_Struct); cdecl;
  Tpng_write_image = procedure(png_ptr: PPng_Struct; image: PPByte); cdecl;
  Tpng_write_end = procedure(png_ptr: PPng_Struct; info_ptr: PPng_Info); cdecl;
  Tpng_write_flush = procedure(png_ptr: PPng_Struct); cdecl;
  Tpng_destroy_write_struct = procedure(png_ptr_ptr: PPPng_Struct; info_ptr_ptr: PPPng_Info); cdecl;

var
  png_close_file: Tpng_close_file = nil;
  png_create_info_struct: Tpng_create_info_struct = nil;
  png_create_write_struct: Tpng_create_write_struct = nil;
  png_destroy_write_struct: Tpng_destroy_write_struct = nil;
  png_init_io: Tpng_init_io = nil;
  png_open_file: Tpng_open_file = nil;
  png_set_IHDR: Tpng_set_IHDR = nil;
  png_set_swap: Tpng_set_swap = nil;
  png_set_text: Tpng_set_text = nil;
  png_set_write_status_fn: Tpng_set_write_status_fn = nil;
  png_write_end: Tpng_write_end = nil;
  png_write_flush: Tpng_write_flush = nil;
  png_write_image: Tpng_write_image = nil;
  png_write_info: Tpng_write_info = nil;

{
Version 1.0.13 (and probably any 1.2.x) does not include the functions denoted
by "-". Furthermore it needs zlib.dll in the system search path. I found out,
that these two functions can be replaced by fopen() and fclose() respectively
(which is available on probably any Windows system through MSVCRT.DLL).
However, the old LIBPNG (I believe version 1.0.1 does not run with fopen() and
fclose()! ... so if the "old style" open and close functions are available, they
are used - else the MSVCRT.DLL is loaded.

-  png_close_file  ->  fclose()
-  png_open_file   ->  fopen()
+  png_create_info_struct
+  png_create_write_struct
+  png_destroy_write_struct
+  png_init_io
+  png_set_IHDR
+  png_set_swap
+  png_set_text
+  png_set_write_status_fn
+  png_write_end
+  png_write_flush
+  png_write_image
+  png_write_info
}

(******************************************************************************)
resourcestring
  pnglib1 = 'libpng.dll';
  pnglib2 = 'lpng.dll';
  msvcrt_name = 'msvcrt.dll';
  sz_png_close_file = 'png_close_file';
  sz_png_create_info_struct = 'png_create_info_struct';
  sz_png_create_write_struct = 'png_create_write_struct';
  sz_png_destroy_write_struct = 'png_destroy_write_struct';
  sz_png_init_io = 'png_init_io';
  sz_png_open_file = 'png_open_file';
  sz_png_set_IHDR = 'png_set_IHDR';
  sz_png_set_swap = 'png_set_swap';
  sz_png_set_text = 'png_set_text';
  sz_png_set_write_status_fn = 'png_set_write_status_fn';
  sz_png_write_end = 'png_write_end';
  sz_png_write_flush = 'png_write_flush';
  sz_png_write_image = 'png_write_image';
  sz_png_write_info = 'png_write_info';
  sz_fopen = 'fopen';
  sz_fclose = 'fclose';

function InitPnglib(libname: string): Boolean;
begin
  result := False;
  hPngLib := GetModuleHandle(PChar(libname));
  if hPngLib = 0 then
    hPngLib := LoadLibrary(PChar(libname));
  if hPngLib <> 0 then
  begin
    @png_close_file := GetProcAddress(hPngLib, PChar(sz_png_close_file));
    @png_open_file := GetProcAddress(hPngLib, PChar(sz_png_open_file));
    @png_create_info_struct := GetProcAddress(hPngLib, PChar(sz_png_create_info_struct));
    @png_create_write_struct := GetProcAddress(hPngLib, PChar(sz_png_create_write_struct));
    @png_destroy_write_struct := GetProcAddress(hPngLib, PChar(sz_png_destroy_write_struct));
    @png_init_io := GetProcAddress(hPngLib, PChar(sz_png_init_io));
    @png_set_IHDR := GetProcAddress(hPngLib, PChar(sz_png_set_IHDR));
    @png_set_swap := GetProcAddress(hPngLib, PChar(sz_png_set_swap));
    @png_set_text := GetProcAddress(hPngLib, PChar(sz_png_set_text));
    @png_set_write_status_fn := GetProcAddress(hPngLib, PChar(sz_png_set_write_status_fn));
    @png_write_end := GetProcAddress(hPngLib, PChar(sz_png_write_end));
    @png_write_flush := GetProcAddress(hPngLib, PChar(sz_png_write_flush));
    @png_write_image := GetProcAddress(hPngLib, PChar(sz_png_write_image));
    @png_write_info := GetProcAddress(hPngLib, PChar(sz_png_write_info));

    if not (Assigned(png_close_file) and Assigned(png_open_file)) then
    begin
      hMSVCRT := GetModuleHandle(PChar(msvcrt_name));
      if hMSVCRT = 0 then
        hMSVCRT := LoadLibrary(PChar(msvcrt_name));
      if hMSVCRT <> 0 then
      begin
        @png_close_file := GetProcAddress(hMSVCRT, PChar(sz_fclose));
        @png_open_file := GetProcAddress(hMSVCRT, PChar(sz_fopen));
      end;
    end;

    result :=
      Assigned(png_close_file) and
      Assigned(png_create_info_struct) and
      Assigned(png_create_write_struct) and
      Assigned(png_destroy_write_struct) and
      Assigned(png_init_io) and
      Assigned(png_open_file) and
      Assigned(png_set_IHDR) and
      Assigned(png_set_swap) and
      Assigned(png_set_text) and
      Assigned(png_set_write_status_fn) and
      Assigned(png_write_end) and
      Assigned(png_write_flush) and
      Assigned(png_write_image) and
      Assigned(png_write_info);

    if not result then
    begin
      FreeLibrary(hPngLib);
      FreeLibrary(hMSVCRT);
    end;
  end;
end;

procedure DeInitPngLib;
begin
  if hPngLib <> 0 then
    FreeLibrary(hPngLib);
  if hMSVCRT <> 0 then
    FreeLibrary(hMSVCRT);
end;

function SavehBmp2PngFile(Filename: string; hBmp: hBitmap; dx, dy: Integer; Alpha: COLORREF): Boolean;
// The COLORREF value look as follows: AABBGGRR (where AA is the Alpha value)
var
  DC: HDC;
  Png: PPng_Struct;
  PngInfo: PPng_Info;
  PngText: TPng_Text;
  neededsize: DWORD;
  CurrPxBmp,
    CurrPxPng,
    PngData,
    RowPtrs,
    DDBraw,
    DDBits: PChar;
  tempsize,
    x,
    y,
    PngColorType,
    LineWidth, // One scanline's size in bytes and DWORD aligned!
    PngBytesPerPixel, // 3 or 4 ... depending of wether it is with or without Aplha channel
    PngBitDepth: Integer;
  PDW_Value: PDWORD;
  hFile: Pointer;
begin
  result := False;
// Set the size needed to store the bits of our hBmp
  neededsize := sizeof(TBitmapInfoHeader) + dy * (dx + 4) * 3;
// Allocate this amount
  DDBraw := GetMemory(neededsize);
// When allocation successful proceed ...
  if Assigned(DDBraw) then
  try
// First empty the buffer
    ZeroMemory(DDBraw, neededsize);
// Start filling our bitmap data (header goes first)
    with PBitmapInfoHeader(DDBraw)^ do
    begin
      biSize := sizeof(TBitmapInfoHeader);
      biWidth := dx;
      biHeight := dy;
      biPlanes := 1;
      biBitCount := 24;
      biCompression := BI_RGB;
      biSizeImage := 0;
      biXPelsPerMeter := 1;
      biYPelsPerMeter := 1;
      biClrUsed := 0;
      biClrImportant := 0;
    end;
// The DDBits start right after the TBitmapInfoHeader ...
    DDBits := DDBraw + sizeof(TBitmapInfoHeader);
// Get the Pixels as device independent "bit field"
    DC := GetDC(0);
    GetDIBits(DC, hBmp, 0, dy, DDBits, PBitmapInfo(DDBraw)^, DIB_RGB_COLORS);
    ReleaseDC(0, DC);
// Determine size of one scanline in byte (aligned to DWORD boundary)
    LineWidth := (((PBitmapInfoHeader(DDBraw)^.biWidth * 3) + 3) div 4) * 4;
    PngBitDepth := 8;
// Set the number of bytes per pel and the color type respectively (depends on
// wether Alpha channel is desired or not).
    case Alpha of
      COLORREF(-1):
        begin
          PngColorType := PNG_COLOR_TYPE_RGB;
          PngBytesPerPixel := 3;
        end;
    else
      begin
        PngColorType := PNG_COLOR_TYPE_RGB_ALPHA;
        PngBytesPerPixel := 4;
      end;
    end;
// Allocate memory to hold the actual bitmap data (image data)
    tempsize := PBitmapInfoHeader(DDBraw)^.biHeight * PBitmapInfoHeader(DDBraw)^.biWidth * PngBytesPerPixel;
    PngData := GetMemory(tempsize);
    if Assigned(PngData) then
      ZeroMemory(PngData, tempsize);
// Allocate a list of row (i.e. scanline) pointers
    tempsize := sizeof(Pointer) * PBitmapInfoHeader(DDBraw)^.biHeight;
    RowPtrs := GetMemory(tempsize);
    if Assigned(PngData) and Assigned(RowPtrs) then
    try
      ZeroMemory(RowPtrs, tempsize);
      PDW_Value := PDWORD(RowPtrs);
      for y := 0 to PBitmapInfoHeader(DDBraw)^.biHeight - 1 do
      begin
// Set the value for this row pointer
        PDW_Value^ := DWORD(PngData) + DWORD(PBitmapInfoHeader(DDBraw)^.biWidth * PngBytesPerPixel * y);
// Step to next row pointer
        inc(PDW_Value {, sizeof(PDW_Value^)});
      end;
// This actually copies the DDBits into the Data section for the PNG to be created
// Note: The byte order has to be changed. I do this with some tricks.
//       Also the treatment of the Alpha channel is much faster now

      case Alpha of
        NoAlpha:
          for y := 0 to PBitmapInfoHeader(DDBraw)^.biHeight - 1 do
            for x := 0 to PBitmapInfoHeader(DDBraw)^.biWidth - 1 do
            begin
              CurrPxBmp := PChar(DDBits) + y * LineWidth + x * 3;
              CurrPxPng := PChar(PngData) + (PBitmapInfoHeader(DDBraw)^.biHeight - 1 - y) * (PngBytesPerPixel * PBitmapInfoHeader(DDBraw)^.biWidth) + x * PngBytesPerPixel;
              asm
// Save registers
                PUSH  eax;
                PUSH  edx;
// Copy the DWORD from the position to which CurrPxBmp points
                MOV   edx, [CurrPxBmp];
                MOV   eax, [edx];
// Swap byte order
                BSWAP eax;
// Now remove the former upper byte :)
                SHR   eax, 8;
// ... and copy the stuff back to the position to which CurrPxPng points
                MOV   edx, [CurrPxPng];
// ... which is to combine the lower 3 bytes of the register with the new data
// Note: that the upper byte is 0 and therefore has no impact!!! WHICH IS NECESSARY!!!
                OR    [edx], eax;
// Restore registers
                POP   edx;
                POP   eax;
              end;
            end;
      else
        for y := 0 to PBitmapInfoHeader(DDBraw)^.biHeight - 1 do
          for x := 0 to PBitmapInfoHeader(DDBraw)^.biWidth - 1 do
          begin
            CurrPxBmp := PChar(DDBits) + y * LineWidth + x * 3;
            CurrPxPng := PChar(PngData) + (PBitmapInfoHeader(DDBraw)^.biHeight - 1 - y) * (PngBytesPerPixel * PBitmapInfoHeader(DDBraw)^.biWidth) + x * PngBytesPerPixel;
// I hope this is optimised as good as possible. If not, send me suggestions ;)
            asm
// Save registers
              PUSH  eax;
              PUSH  edx;
// Copy the DWORD from the position to which CurrPxBmp points
              MOV   edx, [CurrPxBmp];
              MOV   eax, [edx];
// Swap byte order
              BSWAP eax;
// Now remove the former upper byte :)
              SHR   eax,8;
// remove the upper byte
              AND   edx, $00FFFFFF;
// Compare eax and edx
              CMP   eax, edx;
// If equal we leave zero in the upper byte (which is no transparency at this point)
              JE    @NoChange;
// Else we set the upper byte to $FF
              OR    eax, $FF000000;
            @NoChange:
// ... and copy the stuff back to the position to which CurrPxPng points
              MOV   edx, [CurrPxPng];
              MOV   [edx], eax;
// Restore registers
              POP   edx;
              POP   eax;
            end;
          end;
      end;

// Open the file
      hFile := png_open_file(PChar(Filename), 'wb');
      if Assigned(hFile) then
      try
        Png := png_create_write_struct(@PNG_LIBPNG_VER_STRING_10[1], nil, nil, nil);
        if not Assigned(Png) then
          Png := png_create_write_struct(@PNG_LIBPNG_VER_STRING_12[1], nil, nil, nil);
        if Assigned(Png) then
        try
// Create info struct and init io functions
          PngInfo := png_create_info_struct(Png);
          png_init_io(Png, hFile);
          png_set_write_status_fn(Png, nil);
// Set image attributes, compression, etc...
          png_set_IHDR(Png,
            PngInfo,
            PBitmapInfoHeader(DDBraw)^.biWidth,
            PBitmapInfoHeader(DDBraw)^.biHeight,
            PngBitDepth,
            PngColorType,
            PNG_INTERLACE_NONE,
            PNG_COMPRESSION_TYPE_DEFAULT,
            PNG_FILTER_TYPE_DEFAULT);
// Set the "vendor" data. Note: This is not really necessary. Can be empty, too.
          pngtext.key := 'Software';
          pngtext.text := 'EDA - http://assarbad.net';
          pngtext.compression := PNG_TEXT_COMPRESSION_NONE;
          png_set_text(Png, PngInfo, @pngtext, 1);
          png_write_info(Png, PngInfo);
          if Assigned(PngData) and Assigned(RowPtrs) then
          begin
// Swap 16 bit images from PC Format
            case PngBitDepth of
              16: png_set_swap(Png);
            end;
// Write the actual data, i.e. image data
            png_write_image(Png, PPByte(RowPtrs));
            png_write_end(Png, PngInfo);
            png_write_flush(Png);
            result := True;
          end;
        finally
          png_destroy_write_struct(@Png, @PngInfo);
        end;
      finally
        png_close_file(hFile);
      end;
    finally
      FreeMemory(PngData);
      FreeMemory(RowPtrs);
    end;
  finally
// Free all possibly allocated stuff ...
    FreeMemory(DDBraw);
  end;
end;

