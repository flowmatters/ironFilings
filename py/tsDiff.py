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
io = TIME.Management.NonInteractiveIO

#f1 = sys.argv[1]
#f2 = sys.argv[2]

d = "Z:\\joelrahman\\Documents\\FlowMatters\\Projects\\009_MDBA_FEWS\\BackgroundData\\SourceModels\\OvensModel_DataSources\\"
f1 = d + "AveragePET.csv"
f2 = d + "MeanMonthlyPET.csv"

tsSet1 = io.Load(f1)
tsSet2 = io.Load(f2)

pairs = zip(tsSet1,tsSet2)

results = [TIME.Core.Data.subtract(pair[0],pair[1]) for pair in pairs]
for i in range(0,results.Count):
	if tsSet1[i].name == tsSet2[i].name:
		results.name = tsSet1[i].name + "(" + f1 + "-" + f2 + ")"
	else
		results.name = tsSet1[i].name +"-"+ tsSet2[i].name

#
