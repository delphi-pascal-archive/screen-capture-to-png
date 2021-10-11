(******************************************************************************
 ******************************************************************************
 ***                                                                        ***
 ***   FormatString (include file)                                          ***
 ***   Version [no version information]             {Last mod 2003-04-19}   ***
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
 ***              Portions Copyright (c) 2002 by Eugen Honeker              ***
 ***                                                                        ***
 ***   CONTACT TO THE AUTHOR(S):                                            ***
 ***                                ____________________________________    ***
 ***                               |                                    |   ***
 ***                               | Eugen Honeker                      |   ***
 ***                               |____________________________________|   ***
 ***                               |                                    |   ***
 ***                               | Eugen@vclfree.de                   |   ***
 ***                               |               E.Honeker@vclfree.de |   ***
 ***                               |____________________________________|   ***
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

 Copyright (c) 1995-2003, -=Assarbad=- & Eugen Honeker ["copyright holder(s)"]
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

{
function frmt(mformat: string; args: array of POINTER): string;
(*
  Functionality:
    This function wraps the wvsprintf() function provided by windows and
    resembles the behavior of C's printf().
    [GENERIC] Note, you have to cast the parameters in the provided array to
    _some_ pointer type (e.g. pointer, pchar, pdword).
*)
(****************************************************************
 function frmt
 Rückgabewert: String

 Funktion:
 Wrapper für wvsprintf(). Formatiert einen String entsprechend
 den Vorgaben in "mformat".

 (ergänzend:)
  VERSION 3.1 of this function!
   according to PSDK 4/2000 there's no limit for the buffer
   according to PSDK 10/2000 and later the limit is 1024 byte!
 ****************************************************************)
var
  buf: array[0..$400 - 1] of char;
begin
  ZeroMemory(@buf[0], sizeof(buf));
  wvsprintf(@buf[0], @mformat[1], pchar(@args));
  SetString(result, pchar(@buf[0]), lstrlen(@buf[0]));
end;
}

(*
Eugen also did his own version of this, this is for your convenience and pre-
servation of this knowledge, only. Furthermore it is widely compatible with the
Format() function from SysUtils.pas, except, that it can only handle strings up
to 1024 characters (output)

It may receive any type of variable (integer, float, string ...).

Slightly changed to get it compatible with Delphi 3!!!
Changed again.

[GENERIC]
*)

function Format(fmt: string; params: array of const): string;
var
  pdw1, pdw2: PDWORD;
  i: integer;
  pc: PCHAR;
begin
  pdw1 := nil;
  if High(params) >= 0 then
    GetMem(pdw1, (High(params) + 1) * sizeof(Pointer));
  pdw2 := pdw1;
  for i := 0 to High(params) do begin
    pdw2^ := PDWORD(@params[i])^;
    inc(pdw2);
  end;
  pc:=GetMemory(1024);
  if Assigned(pc) then
  try
    SetString(Result, pc, wvsprintf(pc, PCHAR(fmt), PCHAR(pdw1)));
  finally
    if (pdw1 <> nil) then FreeMem(pdw1);
    FreeMem(pc);
  end
  else
    Result := '';
end;

