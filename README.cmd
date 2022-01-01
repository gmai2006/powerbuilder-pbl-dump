#PowerBuilder pbl file extraction
This program extracts the PB source code from PowerBuilder pbl (PowerBuilder binary) files.  The program is based on the PB specification attached below.

#Instruction
To extract the source from PowerBuilder pbl files: Run the following pythong program 
python pbl_extractor.py <input dir> <output dir>

#A list of all source files
.sra - Application Object (The entry point to the application)
.srd - DataWindow Object (Retrieves, represents and modifies data in the database)
.srw - Window Object
.sru - User Object
.srm - Menu Object (List of commands and handlers)
.srf - Function Object
.srs - Structure Object (Structure definition)
.srq - Query Object

The following is the PB specification written by Arnd Schmidt.


#PowerBuilder pbl specification
+--------------------------------------------------------------+
I PBL File Format                                  2003 - 2012 I
+--------------------------------------------------------------+
Dear PB Fans out there,

these are the results of the analysis I did, written down as
a short ASCII text description (valid thru PB5-11.5).

With this knowledge you can write your own LibraryDirectory
or Export Function for PowerBuilder PBL/PBD/DLL/EXE files.

Think about the possibility; including files via PBR assignment
and extracting them during runtime. That is a nice gimmick.

Most of the terms used are the results and presumptions of my 
analysis.

Thanks to: 
  - Kevin Cai for Bytes 17-18 of the Node-Block
  - Jeremy Lakeman for Bytes 19-20, 23-24 of the Node-Block

Regards

Arnd Schmidt                                          April 2011



arnd.schmidt@dwox.com

+--------------------------------------------------------------+
I PBL File Format                                              I
+--------------------------------------------------------------+

Rules and facts:

1.) A PBL is always made out of blocks of 512, except the Node 
Block (NOD*), that has a size of 6 blocks, meaning 3072 Bytes.

2.) There is always one Header (HDR*) block, 
followed by a free/used blocks bitmap (FRE*). 
Then follows the first 'NOD*' block . 
Theoretically this first 'NOD*' block might(!) point to a 
parent node, but I have never seen that.

3.) Object Data (also SCC Informations) are always 
stored in single forward linked/chained of 'DAT*'-Blocks.

The information about the offset and the length is stored in 
the Header (HDR*).

4.) A PBD is a PBL.

5.) DLL and EXE files have a 'TRL*' at the end of the file. 
This is pointing to the one and only 'HDR*'-Block.
Attention: 
For signed DLLs (like PowerBuilder's signed DLLs in Version 11.5)
you have to recalculate the offset to the 'TRL*' Block.

+--------------------------------------------------------------+
I Library Header Block (512 Byte)                              I
+-----------+------------+-------------------------------------+
I Pos.      I Type       I Information                         I
+-----------+------------+-------------------------------------+
I   1 - 4   I Char(4)    I 'HDR*'                              I
I   5 - 18  I String     I 'PowerBuilder' + 0x00 + 0x00        I
I  19 - 22  I Char(4)    I PBL Format Version? (0400/0500/0600)I
I  23 - 26  I Long       I Creation/Optimization Datetime      I
I  29 - xx  I String     I Library Comment                     I
I 285 - 288 I Long       I Offset of first SCC data block      I
I 289 - 292 I Long       I Size (Net size of SCC data)         I
+-----------+------------+-------------------------------------+

+--------------------------------------------------------------+
I Library Header Block - Unicode (1024 Byte)                   I
+-----------+------------+-------------------------------------+
I Pos.      I Type       I Information                         I
+-----------+------------+-------------------------------------+
I   1 - 4   I Char(4)    I 'HDR*'                              I
I   5 - 32  I StringW    I 'PowerBuilder' + 0x00 + 0x00        I
I  33 - 40  I CharW(4)   I PBL Format Version? (0400/0500/0600)I
I  41 - 44  I Long       I Creation/Optimization Datetime      I
I  47 - xx  I StringW    I Library Comment                     I
I 559 - 562 I Long       I Offset of first SCC data block      I
I 563 - 566 I Long       I Size (Net size of SCC data)         I
+-----------+------------+-------------------------------------+

+--------------------------------------------------------------+
I  Bitmap Block (512 Byte)                                     I
+-----------+------------+-------------------------------------+
I Pos.      I Type       I Information                         I
+-----------+------------+-------------------------------------+
I  1 - 4    I Char(4)    I 'FRE*'                              I
I  5 - 8    I Long       I Offset of next block or 0           I
I  9 - 512  I Bit(504)   I Bitmap, each Bit represents a block I
+-----------+------------+-------------------------------------+
(512 - 8) * 8 = 4032 Blocks are referenced

+--------------------------------------------------------------+
I Node Block (3072 Byte)                                       I
+-----------+------------+-------------------------------------+
I Pos.      I Type       I Information                         I
+-----------+------------+-------------------------------------+
I   1 - 4   I Char(4)    I 'NOD*'                              I
I   5 - 8   I Long       I Offset of next (left ) block or 0   I
I   9 - 12  I Long       I Offset of parent block or 0         I
I  13 - 16  I Long       I Offset of next (right) block or 0   I
I  17 - 18  I Integer    I Space left in block, initial = 3040 I
I  19 - 20  I Integer    I Position of alphabetically          I
I           I            I first Objectname in this block      I
I  21 - 22  I Integer    I Count of entries in that node       I
I  23 - 24  I Integer    I Position of alphabetically          I
I           I            I last Objectname in this block       I
I  33 - xx  I Chunks     I 'ENT*'-Chunks                       I
+-----------+------------+-------------------------------------+

+--------------------------------------------------------------+
I Entry Chunk (Variable Length)                                I
+-----------+------------+-------------------------------------+
I Pos.      I Type       I Information                         I
+-----------+------------+-------------------------------------+
I   1 - 4   I Char(4)    I 'ENT*'                              I
I   5 - 8   I Char(4)    I PBL version? (0400/0500/0600)       I
I   9 - 12  I Long       I Offset of first data block          I
I  13 - 16  I Long       I Objectsize (Net size of data)       I
I  17 - 20  I Long       I Unix datetime                       I
I  21 - 22  I Integer    I Length of Comment                   I
I  23 - 24  I Integer    I Length of Objectname                I
I  25 - xx  I String     I Objectname                          I
+-----------+------------+-------------------------------------+

+--------------------------------------------------------------+
I Entry Chunk - Unicode (Variable Length)                      I
+-----------+------------+-------------------------------------+
I Pos.      I Type       I Information                         I
+-----------+------------+-------------------------------------+
I   1 - 4   I Char(4)    I 'ENT*'                              I
I   5 - 12  I CharW(4)   I PBL version? (0400/0500/0600)       I
I  13 - 16  I Long       I Offset of first data block          I
I  17 - 20  I Long       I Objectsize (Net size of data)       I
I  21 - 24  I Long       I Unix datetime                       I
I  25 - 26  I Integer    I Length of Comment                   I
I  27 - 28  I Integer    I Length of Objectname                I
I  29 - xx  I StringW    I Objectname                          I
+-----------+------------+-------------------------------------+

+--------------------------------------------------------------+
I Data Block (512 Byte)                                        I
+-----------+------------+-------------------------------------+
I Pos.      I Type       I Information                         I
+-----------+------------+-------------------------------------+
I   1 - 4   I Char(4)    I 'DAT*'                              I
I   5 - 8   I Long       I Offset of next data block or 0      I
I   9 - 10  I Integer    I Length of data in block             I
I  11 - XXX I Blob{}     I Data (maximum Length is 502         I
+-----------+------------+-------------------------------------+

+--------------------------------------------------------------+
I Trailer Block (in DLL/EXE) always last block (512 Byte)      I
+-----------+------------+-------------------------------------+
I Pos.      I Type       I Information                         I
+-----------+------------+-------------------------------------+
I   1 - 4   I Char(4)    I 'TRL*'                              I
I   5 - 8   I Long       I Offset of Library Header ('HDR*')   I
+-----------+------------+-------------------------------------+

+--------------------------------------------------------------+
I SCC DATA                                                     I
I     Structure of status information chunks                   I
I     in DAT*-blocks (Variable Length)                         I
+---------+----------------------------------------------------I
I Type    I Information                                        I
+---------+----------------------------------------------------I
I String  I Libraryname (the opposite!)                        I
I String  I Objectname                                         I
I String  I Developername                                      I
I Char(1) I Flag                                               I
+---------+----------------------------------------------------I

+--------------------------------------------------------------+
I PB6/7 Status Flags                                           I
+------+------+------------------------------------------------+
I Icon I Flag I Meaning                                        I
+------+------+------------------------------------------------+
I      I  r   I Object is registered                           I
I      I  d   I Object is Checked Out (locked)                 I
I      I  s   I Object (Working Copy) to be checked in         I
I      I  u   I Unknown?! After an Error occurred.             I
I      I      I (Checked out by user <Unknown>                 I
I      I      I  Could be set to 'r' with an Hex-Editor.)      I
+------+------+------------------------------------------------+

+--------------------------------------------------------------+
I SCC DATA chunk                                               I
I In newer PB Versions the DAT*-blocks content starts with the I
I ansi-encoded String 'SCC*'.                                  I
I Objectname and Version Informations are stored as            I
I 0-Byte (Word) separated strings.                             I
+----------+---------------------------------------------------I
I Type     I Information                                       I
+----------+------------+--------------------------------------+
I  1 - 4   I Char(4)    I 'SCC*'                               I
I  5 - xxx I Blob       I Objectname (string) followed by      I
I          I            I Null-Byte 0x00 (Word in Unicode)     I
I          I            I indicating the string end            I
I          I            I Version (String) followed by         I
I          I            I Null-Byte 0x00 (Word in Unicode)     I
I          I            I indicating the string end            I
I          I            I Next Objectname und Versioninfo      I
I          I            I repeatedly until the end             I
+----------+------------+--------------------------------------+

DateTimes are stored in Long format in Unix representation.
Timezone is always GMT (+/- 0:00), so the datetime has to be
converted to LocalDateTime via LocalTimeZone conversation.

In the compiled object data blocks, there are at least 2 more 
datetimes, starting at byte 23 and the other one at 27!
Looks like these are the modification and regeneration date...



