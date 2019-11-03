import pbl_extractor as extractor
from os import listdir
from os.path import isfile, join
import pbl_util as util

def list_nods(pbl_file):
  pbl_info, data = extractor.extract_pbl(pbl_file)
  nods = pbl_info['nod']
  print('# of nods', len(nods))
  for nod in nods:
    print(nod)

def list_entries(pbl_file):
  pbl_info = extractor.extract_pbl_info(pbl_file)
  nods = pbl_info['nod']

  print('# of nods', len(nods))
  for nod in nods:
    entries = nod.entries
    print('# of entries in a NOD', len(entries))
    for x in entries:
      print(x)

def search_entry(inputPath, filename):
  onlyFiles = [f for f in listdir(inputPath) if isfile(join(inputPath, f))]
  for f in onlyFiles:
    pbl_info = extractor.extract_pbl(join(inputPath, f))

    for nod in pbl_info['nod']:
      if len(list(filter(lambda ent: ent.objectname == filename, nod.entries))):
        print(f)
    

def analyze_pbl(f, outputPath):
  pbl_info = extractor.extract_pbl_info(f, False)
  nods = pbl_info['nods']

  for nod in nods:
    print(nod.nod, nod.offsetright, nod.spaceleft, nod.postfirst, nod.count)
    for entry in nod.entries:
      print(entry)
      data = util.extract_data_from_entry(f, entry)
      for datum in data:
        print(datum.offset, datum.datalen)
  
analyze_pbl('/backup/powerbuilder/data/final.pbl', '/backup/powerbuilder/output')