(******************************************************************************
 ******************************************************************************
 ***                                                                        ***
 ***   Compilerswitches                                                     ***
 ***   Version [2.40a]                              {Last mod 2004-02-17}   ***
 ***                                                                        ***
 ******************************************************************************
 ******************************************************************************

                                 _\\|//_
                                (` * * ')
 ______________________________ooO_(_)_Ooo_____________________________________
 ******************************************************************************
 ******************************************************************************
 ***                                                                        ***
 ***                Copyright (c) 1995 - 2004 by -=Assarbad=-               ***
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

 Copyright (c) 1995-2004, -=Assarbad=- ["copyright holder(s)"]
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
 version 2.4 of compilerswitches.pas

 - updated to include Delphi 7 definitions
 - updated to include a DEBUGGING option
 ******************************************************************************)

{$DEFINE DEBUGGING}
{$DEFINE PNGSAVESUPPORT}

{$APPTYPE GUI}
{$ALIGN ON}
{$B-} //complete boolean eval off
{$G-} //imported data off
{$I+} //io checks on
{$J-} //writable constants off
{$L-} //local symbols off
{$H+} //longstrings on
{$P+} //openstrings on
{$Q-} //overflow checking off
{$T-} //typed @ off
{$R-} //rangecheck off
{$U-} //pentium(tm) safe divide off
{$W-} //stackframes off
{$X+} //extended syntax on
{$V-} //var shortstring check off

{$IFNDEF DEBUGGING}
{$C-} //assertions on
{$D-} //no debug info
{$Y-} //no reference informations
{$O+} //optimization on
{$M-}//type info off
{$HINTS OFF}
{$WARNINGS OFF}//warnings off
{$ELSE}
{$M+}//type info off
{$ENDIF}

{$IMAGEBASE $00400000}
{$MINSTACKSIZE 1024}
{$MINENUMSIZE 4} //minimum enum type size = 1

// Version definitions
{$UNDEF DELPHI1}{$IFDEF VER80}{$DEFINE DELPHI1}{$ENDIF}
{$UNDEF DELPHI2}{$IFDEF VER90}{$DEFINE DELPHI2}{$ENDIF}
{$UNDEF DELPHI3}{$IFDEF VER100}{$DEFINE DELPHI3}{$ENDIF}
{$UNDEF DELPHI4}{$IFDEF VER120}{$DEFINE DELPHI4}{$ENDIF}
{$UNDEF DELPHI5}{$IFDEF VER130}{$DEFINE DELPHI5}{$ENDIF}
{$UNDEF DELPHI6}{$IFDEF VER140}{$DEFINE DELPHI6}{$ENDIF}
{$UNDEF DELPHI7}{$IFDEF VER150}{$DEFINE DELPHI7}{$ENDIF}

{$IFDEF DELPHI1}
{$DEFINE DELPHI}
{$DEFINE DELPHI1UP}
{$ENDIF}

{$IFDEF DELPHI2}
{$DEFINE DELPHI}
{$DEFINE DELPHI1UP}
{$DEFINE DELPHI2UP}
{$ENDIF}

{$IFDEF DELPHI3}
{$DEFINE DELPHI}
{$DEFINE DELPHI1UP}
{$DEFINE DELPHI2UP}
{$DEFINE DELPHI3UP}
{$ENDIF}

{$IFDEF DELPHI4}
{$DEFINE DELPHI}
{$DEFINE DELPHI1UP}
{$DEFINE DELPHI2UP}
{$DEFINE DELPHI3UP}
{$DEFINE DELPHI4UP}
{$ENDIF}

{$IFDEF DELPHI5}
{$DEFINE DELPHI}
{$DEFINE DELPHI1UP}
{$DEFINE DELPHI2UP}
{$DEFINE DELPHI3UP}
{$DEFINE DELPHI4UP}
{$DEFINE DELPHI5UP}
{$ENDIF}

{$IFDEF DELPHI6}
{$DEFINE DELPHI}
{$DEFINE DELPHI1UP}
{$DEFINE DELPHI2UP}
{$DEFINE DELPHI3UP}
{$DEFINE DELPHI4UP}
{$DEFINE DELPHI5UP}
{$DEFINE DELPHI6UP}
{$ENDIF}

{$IFDEF DELPHI7}
{$DEFINE DELPHI}
{$DEFINE DELPHI1UP}
{$DEFINE DELPHI2UP}
{$DEFINE DELPHI3UP}
{$DEFINE DELPHI4UP}
{$DEFINE DELPHI5UP}
{$DEFINE DELPHI6UP}
{$DEFINE DELPHI7UP}
{$ENDIF}

{$IFNDEF DELPHI}
'This applicaction requires Delphi version 1-7'
{$ENDIF}

