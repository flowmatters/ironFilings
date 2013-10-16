import clr
import sys
import traceback
import System
clr.AddReference("System.Core")
clr.AddReference("System.Windows.Forms")
clr.ImportExtensions(System.Linq)

#sys.path.Add("C:\\src\\trunk\\Solutions\\Output")
sys.path.Add("C:\\Program Files\eWater\Source 3.2.8.58")

clr.AddReferenceToFile("TIME.dll")
clr.AddReferenceToFile("TIME.Winforms.dll")
clr.AddReferenceToFile("TIME.Visualisation.dll")
import TIME

io = TIME.Management.NonInteractiveIO

def rampUp(template):
	result = template.blankData()
	for i in range(0,result.itemCount()):
		result[i] = float(i)/(result.itemCount()-1)
	return result

def rampDown(template):
	result = template.blankData()
	for i in range(0,result.itemCount()):
		result[i] = float(result.itemCount()-1-i)/(result.itemCount()-1)
	return result

def mergeRamp(starting,ending):
	result = starting*rampDown(starting) + ending*rampUp(ending)
	result.name = starting.name
	return result

#preDev = io.Load("C:\\Path\\To\\PreDevTimeSeries.csv") # don't forget \\ as the path separator
#postDev = io.Load("C:\\Path\\To\\PostDevTimeSeries.csv") # ditto
preDev = io.Load("C:\\tmp\\ipy\\silodataupdated.csv") # don't forget \\ as the path separator
postDev = io.Load("C:\\tmp\\ipy\\AveragePET.csv") # ditto

combined = [mergeRamp(pre,post) for (pre,post) in zip(preDev,postDev)]
csvIO = TIME.DataTypes.IO.CsvFileIo.CSVFileIO()
for ts in combined: csvIO.use(ts.name,ts)

csvIO.save("C:\\tmp\\ipy\\merged.csv")

# Remaining lines write out a "debug" csv file with showing two original time series, the ramps and the result
debugFile = TIME.DataTypes.IO.CsvFileIo.CSVFileIO()
debugFile.use(preDev[0].name,preDev[0])
debugFile.use("DownRamp",rampDown(preDev[0]))
debugFile.use(postDev[0].name,postDev[0])
debugFile.use("UpRamp",rampUp(postDev[0]))
debugFile.use(combined[0].name,combined[0])
debugFile.save("C:\\tmp\\debug.csv")
