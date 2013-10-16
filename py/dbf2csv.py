import clr
import os
import sys
import traceback
import System
clr.AddReference("System.Core")
clr.AddReference("System.Windows.Forms")
clr.ImportExtensions(System.Linq)

TimePath="C:\\src\\trunk\\Solutions\\Output"
if os.environ.has_key('IFTIMEPATH')
  TimePath=os.environ['IFTIMEPATH']

sys.path.Add(TimePath)
clr.AddReferenceToFile("TIME.dll")
clr.AddReferenceToFile("TIME.Winforms.dll")
clr.AddReferenceToFile("TIME.Visualisation.dll")
import TIME
io = TIME.DataTypes.IO.DBFAccess()

dbfFile = sys.argv[1]
csvFile = sys.argv[2]

io = TIME.DataTypes.IO.DBFAccess(dbfFile)

