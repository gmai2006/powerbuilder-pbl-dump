from collections import namedtuple
import datetime
from pathlib import Path

BLOCK_SIZE = 512
BLOCK_SIZE_UNICODE = 1024
NODE_BLOCK_SIZE = 3072
NODE_ENTRY_OFFSET = 32

HEADER_BLOCK = [4, 14, 2, 2, 4, 256, 4, 4]
HEADER_BLOCK_UNICODE = [4, 28, 8, 4, 4, 512, 4, 4]

SOURCE = ['.srd', '.srs', '.srw', '.sru', '.srf',  
         '.srm', '.srx', '.srj', '.srp', '.srq', '.sra']

EntryClass = namedtuple('Entry', 'ent version offset objectsize date commentlen objectlen objectname')
DataClass = namedtuple('Data', 'dat address offset datalen data')
HeaderClass = namedtuple('Header', 'hdr powerbuilder version date scc_offset scc_size')
BitMapClass = namedtuple('Bitmap', 'fre offset block')
NodClass = namedtuple('Nod', 'nod offsetleft parentoffset offsetright spaceleft postfirst count poslast entries')

def do_nothing(arr):
  return arr

def decode(b):
  return str(b.decode('latin-1'))

def bin2int(b):
  return int.from_bytes(b, byteorder='little')

def long2time(ms):
  return datetime.datetime.fromtimestamp(ms//1000.0)

def bin2time(b):
  return long2time(bin2int(b))

def ignore(b):
  return str(len(b))

def isSourceFile(name):
  result = [x for x in SOURCE if name.endswith(x)]
  return len(result) > 0

def save_2_file(entry, data, outputPath):
    text = getTextFromData(data)
    comment_len = entry.commentlen
    text = text[comment_len:]
    save2file(entry.objectname, text, outputPath)

def getTextFromData(arr):
  text = ''
  for x in arr:
    length = x[len(x) - 2]
    text += x[len(x) - 1][0:length]
  return text

def save2file(name, text, outputPath):
  data_folder = Path(outputPath)
  file_to_open = data_folder / name

  with open(file_to_open, 'w+', encoding='utf-8') as output:
    output.write('HA$PBExportHeader$' + name + '\n')
    output.write('$PBExportComments$' + '\n')
    output.write(text)
  output.close()

'''
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
'''
def extract_pbl_header(f, attributes):
  # header_attributes = [4, 14, 2, 2, 4, 256, 4, 4]
  functors = [decode, decode, decode, decode, bin2time, 
    ignore, bin2int, bin2int]
  
  block_bytes = retrieve_bytes_from_file(f, 0, BLOCK_SIZE)

  lst = extract_bytes_2_lst(block_bytes, attributes, functors)

  if not lst[0].startswith('HDR*'):
    raise Exception('HDR', 'Invalid header', lst[0])

  if not lst[1].startswith('PowerBuilder'):
    raise Exception('HDR', 'Missing PowerBuilder keyword', lst[1])

  return HeaderClass(lst[0], lst[1], lst[2] + lst[3], lst[4], lst[6], lst[7])

'''
+--------------------------------------------------------------+
I  Bitmap Block (512 Byte)                                     I
+-----------+------------+-------------------------------------+
I Pos.      I Type       I Information                         I
+-----------+------------+-------------------------------------+
I  1 - 4    I Char(4)    I 'FRE*'                              I
I  5 - 8    I Long       I Offset of next block or 0           I
I  9 - 512  I Bit(504)   I Bitmap, each Bit represents a block I
+-----------+------------+-------------------------------------+
'''
def extract_pbl_pre(f):
  pre_attributes = [4, 4, 504]
  functors = [decode, bin2int, ignore]
  block_bytes = retrieve_bytes_from_file(f, BLOCK_SIZE, BLOCK_SIZE)
  lst = extract_bytes_2_lst(block_bytes, pre_attributes, functors)

  if not validate(lst, 'PRE*'):
    raise Exception('PRE', 'Missing PRE keyword ', lst[0])

  return BitMapClass(lst[0], lst[1], lst[2])

def extract_nods(f, unicode):
  nods = []
  nod = extract_nod(f, BLOCK_SIZE * 2, unicode)
  nods.append(nod)
  next_offset = nod.offsetright
  while (next_offset > 0):
    nod = extract_nod(f, next_offset, unicode) 
    next_offset = nod.offsetright
    nods.append(nod)
    
  return nods    

def extract_nod(f, starting_address, unicode):
  entries = []

  attributes = [4, 4, 4, 4, 2, 2, 2, 2, NODE_BLOCK_SIZE - 20]
  functors = [decode, bin2int, bin2int, bin2int, bin2int, bin2int, 
  bin2int, bin2int, do_nothing]
  
  block_bytes = retrieve_bytes_from_file(f, starting_address, NODE_BLOCK_SIZE)
  lst = extract_bytes_2_lst(block_bytes, attributes, functors)

  if not validate(lst, 'NOD*'):
    raise Exception('NOD', 'Missing NOD', lst[0])

  chunk = lst[len(lst) - 1]

  # pos of the first entry
  start_pos = 8 #33-24
  # numbers of entries
  number_of_entries = lst[6]
 
  for x in range(0, number_of_entries):
    if unicode:
      entry = extract_entry_def_unicode(chunk[start_pos:])
      total_entry_len = 28 + entry.objectlen
      start_pos += total_entry_len
    else:
      entry = extract_entry_def(chunk[start_pos:])
      total_entry_len = 24 + entry.objectlen
      start_pos += total_entry_len
    entries.append(entry)

  if not validate(entries, 'ENT*'):
    raise Exception('ENT', 'Missing entry')

  return NodClass(lst[0], lst[1], lst[2], 
  lst[3], lst[4], lst[5], lst[6], lst[7], entries)

'''
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
'''
def extract_entry_def(arr):
  object_name_len = extract_object_name_len_from_entry(arr)
  blocks = [4, 4, 4, 4, 4, 2, 2, object_name_len - 1]
  functors = [decode, decode, bin2int, bin2int, bin2time, 
  bin2int, bin2int, decode]
  lst = extract_bytes_2_lst(arr, blocks, functors)
  entry = EntryClass(lst[0], lst[1], lst[2], lst[3], lst[4], lst[5], lst[6], lst[7])
  return entry

def extract_entry_def_unicode(arr):
  object_name_len = extract_object_name_len_from_entry(arr)
  blocks = [4, 8, 4, 4, 4, 2, 2, object_name_len - 1]
  functors = [decode, decode, bin2int, bin2int, bin2time, 
  bin2int, bin2int, decode]
  lst = extract_bytes_2_lst(arr, blocks, functors)
  entry = EntryClass(lst[0], lst[1], lst[2], lst[3], lst[4], lst[5], lst[6], lst[7])
  return entry

#23 - 24  I Integer    I Length of Objectname   
def extract_object_name_len_from_entry(entry):
  blocks = [4, 4, 4, 4, 4, 2, 2]
  functors = [decode, decode, bin2int, bin2int, bin2time, bin2int, 
  bin2int]
  lst = extract_bytes_2_lst(entry, blocks, functors)
  return lst[len(lst) -1]

def extract_bytes_2_lst(arr, blocks, functors):
  result = []
  start = 0
  end = 0
  for x in range(0, len(blocks)):
    end = start + blocks[x]
    chunk = arr[start:end]
    result.append(functors[x](chunk))
    start = end

  return result

def extract_data_from_entry(f, entry):
  start_address = entry.offset
  data = []
  while start_address > 0:
    datum = extract_data(f, start_address)
    start_address = datum.offset
    data.append(datum)

  return data

def extract_data(f, starting_address):
  attributes = [4, 4, 2, 502]
  functors = [decode, bin2int, bin2int, decode]
  block_bytes = retrieve_bytes_from_file(f, starting_address, BLOCK_SIZE)
  lst = extract_bytes_2_lst(block_bytes, attributes, functors)
  text = lst[len(lst) - 1]
  text_len = lst[2]
  actual_text = text[0:text_len]
  lst[len(lst) - 1] = actual_text

  if not validate(lst, 'DAT*'):
    raise Exception('DAT', 'Invalid data block')

  return DataClass(lst[0], starting_address, lst[1], lst[2], actual_text)

'''
validate items in the list matches the given name
'''
def validate(lst, name):
  return filter(lambda x: x[0] == name, lst)

def lst_of_offset(lst):
  return [x.offset for x in lst]

def lst_data_2_map(lst_of_data):
  return dict([(x.address, x) for x in lst_of_data])

def lst_data_2_inverted_map(lst_of_data):
  return dict([(x.offset, x.address) for x in lst_of_data])

def lst_of_addresses_offset(lst_of_data):
  return [(x.address, x.offset) for x in lst_of_data]

def lst_of_addresses(lst_of_data):
  return [x.address for x in lst_of_data]

def lst_of_offset(lst_of_data):
  return [x.offset for x in lst_of_data]

def lst_address_from_map(map_of_data):
  return list([x for x in map_of_data.keys()])

def retrieve_bytes_from_file(f, start_address, size):
  block = start_address // BLOCK_SIZE
  start = 0
  result = []
  with open(f, 'rb') as fil:
    while start < block:
      chunk = fil.read(BLOCK_SIZE)
      start = start + 1
      if not chunk:
        print('Not found EOF reached ', start_address)
        fil.close()
        return None

    result = fil.read(size)    
    fil.close()

  return result

