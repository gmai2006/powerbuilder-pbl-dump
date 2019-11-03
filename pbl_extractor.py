# https://www.delftstack.com/howto/python/how-to-convert-bytes-to-integers/
# view-source:http://www.dwox.com/PBL_File_Format.txt

import pbl_util as util
from os import listdir
from os.path import isfile, join
import sys

def extract_pbls(inputPath, outputPath, unicode = False):
  onlyFiles = [f for f in listdir(inputPath) if isfile(join(inputPath, f))]
  for f in onlyFiles:
    print(f)
    extract_pbl(join(inputPath, f), outputPath)

def extract_pbl(f, outputPath, unicode = False):
  pbl_info = extract_pbl_info(f, unicode)
  for nod in pbl_info['nods']:
    for entry in nod.entries:
      name = entry.objectname
      extension = str(name[len(name)- 4: len(name)])
      if not extension in util.SOURCE:
        continue

      data = util.extract_data_from_entry(f, entry)
      util.save_2_file(entry, data, outputPath)
        

def extract_pbl_info(f, unicode):
  pbl_info = {}

  if unicode:
    pbl_info['header'] = util.extract_pbl_header(f, util.HEADER_BLOCK_UNICODE)
  else:
    pbl_info['header'] = util.extract_pbl_header(f, util.HEADER_BLOCK)

  pbl_info['pre'] = util.extract_pbl_pre(f)

  pbl_info['nods'] = util.extract_nods(f, unicode)

  return pbl_info

def main():
  if len(sys.argv) < 3:
    print('Require input directory and output directory')
    return

  print('input dir ', sys.argv[1])
  print('output dir ', sys.argv[2])
  extract_pbls(sys.argv[1], sys.argv[2])  

if __name__ == "__main__":
  main()